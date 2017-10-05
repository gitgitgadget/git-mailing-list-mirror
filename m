Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E762036B
	for <e@80x24.org>; Thu,  5 Oct 2017 10:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdJEKNx (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 06:13:53 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:55444 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdJEKNv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 06:13:51 -0400
Received: by mail-vk0-f53.google.com with SMTP id i1so7759269vke.12
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kQ64zQlOElVtIGxwNSZdaXHIp71NK0+ErFloZlNJz2Y=;
        b=MarBg8U1iWi84xmcy1Vn6tj6EOD6qRSqCfhD8+gGdKKDrQmmG0MnJUXI02xZgdUI6S
         du6ck5JbZCNNQ1ix/vtmDFR4uigf8wASgQHHSH371yDlfxXaMVUrNnR/uK3UVecVSJnE
         +ndK9BH000wvfkkzOjFskjhn19Yz8l/R5/CibH8Jd9ttyDQtsAzP/y2j5QTxGNLQKgCd
         EPl3Jmcxn5zc7qlYtgI9qk38KNWL3qpATuxO2deJgRG2VowpObVgrnWuf/ASFl9cX2f9
         lqGxoPzlUxM5ezWVXjNDXvGQ6PNRNHJW3rG7nRaXFcu8eoAPSeCkDH1Zbbqwcmzp0EJ2
         mEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kQ64zQlOElVtIGxwNSZdaXHIp71NK0+ErFloZlNJz2Y=;
        b=eJE71ua0qp5I66qEuuU1VBQohLkjldjggpCur5ijX7pro6VibPr5DuKJ1rApN+S7wl
         jlM3hIKxNzKswbvOTY5XHMhagnBv22geRGU0mm5yOPA5vZCI+oVbtYNBbrwpXxIvGxI5
         kaj+hFY+Z53UuRisAtu45aCtMkxX0QJRh5ceJ+W0zN2Tief1hWptFz5BbEemNFY+HpQM
         i2ibIoLJqOOpRUphfAG+0clESjJU7UtbAaQuErnYVq/1fzkMJUg+A7vgWrOwAoBLO/ec
         3dIaAEbgeUENpfF/+Jp+TdFvhFU3hKJR3KwLg8CNoVor0KU7Fy3M4thdyMhBW858Wnky
         bDWQ==
X-Gm-Message-State: AHPjjUgIp1cshiDho+syiXqOE/5soLK1ukcPwCGPtMnPzJByG6jiQSGm
        jeH6rDbYz0XYphV6b4mwOTQj1FJUrHgT542uw6Q=
X-Google-Smtp-Source: AOwi7QA7we+DXdn+rIcJAvZDmOnoqoxP0L70qX6/HKlPYDZxn1H7SrUGPphA4A0vWXHjiQWf/MyBq2uHEg5/GEqFnRA=
X-Received: by 10.31.214.71 with SMTP id n68mr13810257vkg.31.1507198430325;
 Thu, 05 Oct 2017 03:13:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.16.157 with HTTP; Thu, 5 Oct 2017 03:13:29 -0700 (PDT)
In-Reply-To: <20171005081733.18529-1-nathan.payre@etu.univ-lyon1.fr>
References: <20171005081733.18529-1-nathan.payre@etu.univ-lyon1.fr>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 5 Oct 2017 19:13:29 +0900
X-Google-Sender-Auth: cGhexWQBtRIM4Hljgklx2A1Pw98
Message-ID: <CAPc5daVKM9PXYfKb3zMmCH3F8DeGcLHNtTCLDxMogOTH8uxWzg@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-config.txt: reword missleading sentence
To:     PAYRE NATHAN p1508475 <second.payre@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        daniel.bensoussan--bohm@etu.univ-lyon1.fr,
        timothee.albertin@etu.univ-lyon1.fr,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        matthieu.moy@univ-lyon1.fr,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2017 at 5:17 PM, PAYRE NATHAN p1508475
<second.payre@gmail.com> wrote:
> Change the word "bla" to "section.variable" to make it clear that it's a placeholder for a variable name.

Please make sure that your log message shows without wrapping and is a
confortable read on a 80-column terminal by wrapping long lines.

>
> See discussion at: https://public-inbox.org/git/20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca/

I do not think it matters that much in this particular case, but please
make it a habit to assume that time of people who run "git log" to
find out why the change was done is 100x more valuable than the
time you need to leave a good summary of the discussion in the
log message. A URL at the end _in addition to_ a summary in your
words is OK; just a URL without any effort to summarize why you
did this change is not.

I often find myself understanding the issues a lot better _only_
after I try to summarize the argument for a change in the log
message--it forces me to _think_. And (this probably does not
apply to this patch, as it is not a code change) it often results
in a better code. First I come up with a solution, write a quick
patch, try to explain the approach in the log message and then
realize there is a better solution _only_ after doing so. It is a
good habit to get into to try explaining the thought process in
the log message.

> Noticed-by: rpjday@crashcourse.ca
> ---

Here, after "Reported-by:" before the three-dash line, we need
your "Signed-off-by:" line. See Documentation/SubmittingPatches
for details. The name and address should match what appears
on the "From:" field from your e-mail.

Ah, one more thing. Do you want to be known as somebody
with ALL CAPS first and last name, with student number? ;-)
If it is cumbersome to convince your MUA to use your real
name spelled in normal way on the "From:" header, you could
start the body of your message with

    From: Payre Nathan <second.payre@gmail.com>

followed by an empty line, followed by the body of the log
message.


>  Documentation/git-config.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 83f86b923..f9808d7ad 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -177,8 +177,8 @@ See also <<FILES>>.
>         'git-config' will expand leading '{tilde}' to the value of
>         '$HOME', and '{tilde}user' to the home directory for the
>         specified user.  This option has no effect when setting the
> -       value (but you can use 'git config bla {tilde}/' from the
> -       command line to let your shell do the expansion).
> +       value (but you can use 'git config section.variable {tilde}/'
> +       from the command line to let your shell do the expansion).
>

The new text proposed by the patch looks good.

Note that I am not in front of a real computer, and I cannot
verify if there is a whitespace breakage in the patch to make
it unusable. I am guessing this one is OK (it seems there
is only one SP followed by HT on the context lines).

Thanks, and welcome to Git development community.
