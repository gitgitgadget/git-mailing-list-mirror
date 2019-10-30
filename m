Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545521F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 09:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJ3Jnm (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 05:43:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40361 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfJ3Jnm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 05:43:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id y81so2024809qkb.7
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 02:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQIAsOBrtCurcxb8MziRoaUtTn1qDUgUwDO9gaUlQlQ=;
        b=b7aSyoBZMhv/TLaNXrl9IQdzHDICmHxLgiG/XNT2RxD3EnEGjOOu70K01UHEJMKDHc
         r97AY06NutmQeUP8mkUk0nLQ+l5nWweazi0A++Qf7/LbvoCC4MR6XQAaYd7BvH1jsicg
         wTImXQYGG5fQGn399rJC0IZliDIr+TMlX4hUWBKnsf6fgBf9zGNclr66g1F37X3WyFRG
         meB09ApVZGDEl6iw7MXl4iQShPOOwaq17kjBcwJJUNxuWJR1jPjGa/PlCUb78LGRxb1K
         azuRh2+xLUZTfOuaGOvv+2DmjXtF5CJihJQiCP5rkgaRGtpD56qiZYTt/dx3qTM9sdNz
         QFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQIAsOBrtCurcxb8MziRoaUtTn1qDUgUwDO9gaUlQlQ=;
        b=mmJlQ7Gfto2bAftxt+A8W1TE76f1YO7o7CIN9jPlzM2BKWtN7rPZAlBCEV+8w4rT1t
         EA0tQ2XKs/DFh28f4SLhB1eA2Hus+a2SZ7FFWn0ny65KRWf56oTL/zTivqhFGk2x3y4b
         obz0lHJOKcCdVDq7wVMJW4WaMW9p/ikDdQGK/HZGwKamBSM4bCYM7f4ajfcNiIiYYKhL
         2sbUM61Qhf5UxI5T9WCF1RsY738F9Fa+3T0k1sGlbOkmjnN4jMUI6724Ht1eOKK6hqho
         PucTeulXHKUZ7W3Hbed6HVKqyV7o+KZtLzSkuHr6WXKAFyXukhNOh+xSLWrz8tqHPwpW
         Hcpw==
X-Gm-Message-State: APjAAAUQ1P2LBWBugtLAsRXP04z/xgyYOmA/0aEx2oMx5zS1jH7wbyIs
        WwInmFbARNZoUIbViCfqclKRa6NDnjndh6WjRgs2X/e3Tb4=
X-Google-Smtp-Source: APXvYqw7pQlNzVNBbMO78618aa+v/JOV8ytRZAT7pq77rzZDfo3hRnIBVjCjoq7PHQey0Z/DQXW6HFqYVwwSapLdWb4=
X-Received: by 2002:a05:620a:1278:: with SMTP id b24mr27287177qkl.206.1572428619446;
 Wed, 30 Oct 2019 02:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.425.git.1572306149.gitgitgadget@gmail.com>
 <8c088194f604eac3a6b00c48a7fddfdf807571fc.1572306149.git.gitgitgadget@gmail.com>
 <20191029204228.GA229589@google.com>
In-Reply-To: <20191029204228.GA229589@google.com>
From:   George Espinoza <gespinoz2019@gmail.com>
Date:   Wed, 30 Oct 2019 02:43:27 -0700
Message-ID: <CAP_ANinZuD645D8CniRJxscCkE3Se-uwAHFCtJCwKgt31+Pcig@mail.gmail.com>
Subject: Re: [PATCH 1/1] [Outreachy] merge-ours: include parse-options
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     george espinoza via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 29, 2019 at 1:42 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Mon, Oct 28, 2019 at 11:42:29PM +0000, george espinoza via GitGitGadget wrote:
> > From: george espinoza <gespinoz2019@gmail.com>
> >
> > Teach this command which currently handles its own argv to use
> > parse-options instead because parse-options helps make sure we handle
> > user input like -h in a standardized way across the project.
> > Also deleted the NO_PARSEOPT flag from git.c to coincide with
> > the conversion of the structure in this command since merge-ours
> > now uses parse-options and needed to update git.c accordingly.
>
> Hmm, I could still wish for some rephrasing on this commit message. Now
> that you took my example suggestions and pasted them directly into your
> previous sentences, it doesn't flow very nicely. The point comes across
> but it's a little redundant (for example, "also <verb> from git.c ....
> and needed to update git.c" is redundant).
>
> When significant assistance and advice is received it's often good form
> to include a "Helped-by:" line which looks similar to the signoff line,
> to provide credit. Maybe you will consider it as myself and dscho spent
> quite some time helping you in the GitGitGadget PR as well as via
> IRC/mail? :)
>
> Otherwise, the code looks OK to me.
>
>  - Emily
>
> >
> > Signed-off-by: george espinoza <gespinoz2019@gmail.com>
> > ---
> >  builtin/merge-ours.c | 14 ++++++++++----
> >  git.c                |  2 +-
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
> > index 4594507420..fb3674a384 100644
> > --- a/builtin/merge-ours.c
> > +++ b/builtin/merge-ours.c
> > @@ -11,14 +11,20 @@
> >  #include "git-compat-util.h"
> >  #include "builtin.h"
> >  #include "diff.h"
> > +#include "parse-options.h"
> >
> > -static const char builtin_merge_ours_usage[] =
> > -     "git merge-ours <base>... -- HEAD <remote>...";
> > +static const char * const merge_ours_usage[] = {
> > +     N_("git merge-ours [<base>...] -- <head> <merge-head>..."),
> > +     NULL,
> > +};
> >
> >  int cmd_merge_ours(int argc, const char **argv, const char *prefix)
> >  {
> > -     if (argc == 2 && !strcmp(argv[1], "-h"))
> > -             usage(builtin_merge_ours_usage);
> > +     struct option options[] = {
> > +             OPT_END()
> > +     };
> > +
> > +     argc = parse_options(argc, argv, prefix, options, merge_ours_usage, 0);
> >
> >       /*
> >        * The contents of the current index becomes the tree we
> > diff --git a/git.c b/git.c
> > index ce6ab0ece2..6aee0e9477 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -527,7 +527,7 @@ static struct cmd_struct commands[] = {
> >       { "merge-base", cmd_merge_base, RUN_SETUP },
> >       { "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
> >       { "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
> > -     { "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
> > +     { "merge-ours", cmd_merge_ours, RUN_SETUP },
> >       { "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
> >       { "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
> >       { "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
> > --
> > gitgitgadget

Ah, my sincerest apologies. I should have been more thorough in
evaluating the importance of a clean original commit message before
submitting it. I will certainly keep all of that in mind for this
project and any future projects and contributions. I will edit it
accordingly to your advice and include credit for the substantial and
significant assistance you and dscho provided. :) ty.

-George
