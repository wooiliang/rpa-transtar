*** Settings ***
Documentation     Template robot main suite.
Library         RPA.Browser
Library         RPA.Email.ImapSmtp    smtp_server=smtp.gmail.com    smtp_port=587

*** Variables ***
${USERNAME}       xxxxxx@gmail.com
${PASSWORD}       xxxxxx
${RECIPIENT}      xxxxxx@gmail.com

*** Tasks ***
Minimal task
    ${date}=    Set Variable    28/01/2022
    RPA.Browser.Open Available Browser    https://mybooking.transtar.travel/transtar-schedule.html
    ${text}=    RPA.Browser.Get Text    //html/body/div/table/tbody/tr[last()]/td[1]
    ${text2}=    RPA.Browser.Get Text    //html/body/div/table/tbody/tr[last()]/td[2]
    Log    ${text}
    IF    """${text}""" == """${date}""" and """${text2}""" != """Full"""
        Authorize    account=${USERNAME}    password=${PASSWORD}
        Send Message    sender=${USERNAME}
        ...    recipients=${RECIPIENT}
        ...    subject=Transtar ${date}
        ...    body=Transtar ${date}
    ELSE
        Log    False.
    END
    Log    Done.
