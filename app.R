# remotes::install_github("surveydown-dev/surveydown", force = TRUE)
library(surveydown)

# Database setup

# surveydown stores data on a database that you define at https://supabase.com/
# To connect to a database, update the sd_database() function with details
# from your supabase database. For this demo, we set ignore = TRUE, which will
# ignore the settings and won't attempt to connect to the database. This is
# helpful for local testing if you don't want to record testing data in the
# database table. See the documentation for details:
# https://surveydown.org/store-data

db <- sd_database(
  host   = "",
  dbname = "",
  port   = "",
  user   = "",
  table  = "",
  ignore = TRUE
)

# Server setup
server <- function(input, output, session) {

  config <- sd_config(
    skip_if = tibble::tribble(
      ~question_id,   ~question_value,        ~target,
      "skip_to_page", "end",                  "end",
      "skip_to_page", "question_formatting",  "questionFormatting"
    ),
    show_if = tibble::tribble(
      ~question_id,  ~question_value, ~target,
      "penguins",    "other",         "penguins_other"
    ),
    all_questions_required = TRUE
  )

  # sd_server() initiates your survey - don't change it
  sd_server(
    input   = input,
    output  = output,
    session = session,
    config  = config,
    db      = db
  )

}

# shinyApp() initiates your app - don't change it
shiny::shinyApp(ui = sd_ui(), server = server)
