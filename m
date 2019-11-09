Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF4D1F454
	for <e@80x24.org>; Sat,  9 Nov 2019 07:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfKIHmg (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 02:42:36 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46785 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfKIHmg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 02:42:36 -0500
Received: by mail-qt1-f193.google.com with SMTP id u22so9433070qtq.13
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 23:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aXXkVhZp/ilLII+1aLSo430k1Pr/Ny+ex0nnDvthto=;
        b=a5/8gmN5h5R1+KLh07e2yyML5vKSgaSKQTaRwa4dO3EY1M/bbH66m3AZK6FbQUwYQM
         9M5nBr941/Gt26e0WhlwiQ3hBMKo/vewOmG4LS0hwB7wvcYcpEPxOwSjG/ImI4wHts8E
         4Yq7e6NklImIkWuo3mmzGyN7lQ6jxNUmJRozKT2D5Xw3/KGLAtj/+Xao/3ueOS0DS2g3
         NHn1UV2DK4DOVRrq/22ueALj6HFp80Po8bECJmZkdvLxDGgUmfNuWNThzPf1Js217Xiv
         egA2JY4hGOK6aYbwfebshqYJDyBseL6beDZiQ8HZ8YyFOuPgWZAdIkiVsLZ4xK07g2UY
         ntEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aXXkVhZp/ilLII+1aLSo430k1Pr/Ny+ex0nnDvthto=;
        b=npxJfLd2eWPBs7Bk7UrBlDFdu4ixSRbXtU2ZEeWz3HFjogDKY8wek/QxpGSLoOHtNU
         AhazaCafmN7QTyls8s/FBmlrtHmF1lJoxqbE/UTOBeDHpFOfUVLqojM/OTr27MAf245x
         Pu88mw+YItU0YVI1TDL3+lm19lHDNxmQVSqQThLfHtv6zaJzKRvq8bVC1atjMBVyKWZs
         OmvXieM5h0PJ2l4AjPaFgFaD9zy09h5q/KjzydRqNad6ZUr5EXn0Q54CwF3XjmptcGwc
         y8kF5LQMCqskhFYfJEejhQJ7M+avzpjde3QkmdcsqV6VqYbckZDordT3XawW3Q4m8IFl
         WoRw==
X-Gm-Message-State: APjAAAW7ZbbjTKPa2qtJvdGwOyP2vqx6XtrvoP5oYpvr+yFFzsRCH8Xj
        90otSykQTAPUxuQ4AEAiOmOAbGAa096CR8H6twU=
X-Google-Smtp-Source: APXvYqyvV0ouvPuwx56cekuhHrMwaoP6Oxp8hX2JGuuF49Ie/PuEGjQR9KGh4m5YLYTDdq8XeWCjpVVev99ojKYy2s8=
X-Received: by 2002:aed:31e7:: with SMTP id 94mr15559964qth.71.1573285353353;
 Fri, 08 Nov 2019 23:42:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.449.git.1573114201.gitgitgadget@gmail.com>
 <e8bca0910e7ba7582a50115eeeb66406d965a52a.1573114201.git.gitgitgadget@gmail.com>
 <xmqqmud8ouf2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmud8ouf2.fsf@gitster-ct.c.googlers.com>
From:   George Espinoza <gespinoz2019@gmail.com>
Date:   Fri, 8 Nov 2019 23:42:21 -0800
Message-ID: <CAP_ANin4=ES8PRo=dnPTzyq+BPwqfGGwBkWJzSndfHUk+J1ASg@mail.gmail.com>
Subject: Re: [PATCH 2/6] [Outreachy] check-ref-format: parse-options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     george espinoza via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 7, 2019 at 2:25 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "george espinoza via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: george espinoza <gespinoz2019@gmail.com>
> >
> > This command currently handles its own argv so by teaching it to
> > use parse-options instead we can standardize the way commands
> > handle user input across the project.
> >
> > As a consequence of using OPT_BOOL data structure on --normalize &
> > --refspec-pattern, --no-normalize & --no-refspec-pattern has been
> > can now be used.
> >
> > NO_PARSEOPT flag was also removed to update git.c with the
> > conversion of the structure in this command.
> >
> > This is a rough draft and I need some advice if I'm doing this
> > correctly since its being built but it is failing tests.
> >
> > Helped by: emily shaffer <emilyshaffer@google.com>
> > Helped by: johannes schindelin <johannes.schindelin@gmx.de>
>
> I do not think they spell their name like the above.  In general,
> most of us do not spell our names in all lowercase around here. I
> appreciate people with originality, but I'd rather see them to be
> original not in how they spell their names but in more productive
> ways ;-)
>

Ah, I see. I will use capital letters.
> > Signed-off-by: george espinoza <gespinoz2019@gmail.com>
> > ---
> >  builtin/check-ref-format.c | 49 +++++++++++++++++++-------------------
> >  git.c                      |  2 +-
> >  2 files changed, 26 insertions(+), 25 deletions(-)
> >
> > diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
> > index bc67d3f0a8..3fe0b5410a 100644
> > --- a/builtin/check-ref-format.c
> > +++ b/builtin/check-ref-format.c
> > @@ -6,10 +6,13 @@
> >  #include "refs.h"
> >  #include "builtin.h"
> >  #include "strbuf.h"
> > +#include "parse-options.h"
> >
> > -static const char builtin_check_ref_format_usage[] =
> > -"git check-ref-format [--normalize] [<options>] <refname>\n"
> > -"   or: git check-ref-format --branch <branchname-shorthand>";
> > +static const char * const builtin_check_ref_format_usage[] = {
> > +     N_("git check-ref-format [--normalize] [<options>] <refname>\n"),
> > +     N_("   or: git check-ref-format --branch <branchname-shorthand>"),
> > +     NULL,
> > +};
>
> OK.  This is the bog-standard prep for calling usage_with_options().

I see, I will look into doing something more here as necessary.
>
> > @@ -53,31 +56,29 @@ static int check_ref_format_branch(const char *arg)
> >
> >  int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
> >  {
> > -     int i;
> > -     int normalize = 0;
> > +     enum {
> > +             CHECK_REF_FORMAT_BRANCH,
> > +     };
> > +
> > +     int i = 0;
> > +     int verbose;
> > +     int normalize;
> > +     int allow_onelevel;
> > +     int refspec_pattern;
> >       int flags = 0;
> >       const char *refname;
>
> Discard the blank line before "int i = 0" line, and keep the blank
> line you have here between the last declaration and the first
> statement.

I meant to squash all my earlier commits but had an issue with git rebase -i.
It only says noop. I had an issue when I first started my other branch
and might of reset it. I'll look into fixing this before submitting my
next patch.
>
> > -     if (argc == 2 && !strcmp(argv[1], "-h"))
> > -             usage(builtin_check_ref_format_usage);
> > -
> > -     if (argc == 3 && !strcmp(argv[1], "--branch"))
> > -             return check_ref_format_branch(argv[2]);
> > +     struct option options[] = {
> > +             OPT__VERBOSE(&verbose, N_("be verbose")),
> > +             OPT_GROUP(""),
> > +             OPT_CMDMODE( 0 , "branch", &check_ref_format_branch, N_("branch"), CHECK_REF_FORMAT_BRANCH),
>
> This is an iffy/tricky way to use CMDMODE.  The way CMDMODE is
> designed to be used is to have multiple ones that sets the same
> target variable so that parse_options() can notice conflicting
> command line request that gives more than one from the same set.
>
> The command has two modes (i.e. the "--branch" mode and the unnamed
> mode), so it is understandable that there is only one CMDMODE in the
> options[] array, but I am not sure how well it would work for a
> command like this.  For example, "check-ref-format --branch
> --normalize --allow-onelevel $v" should error out because --branch
> is not compatible with any other options.  I do not think a single
> parse_options() call with a single options[] array can express that
> kind of constraints.

Ok I will look into another data structure to use for branch.
>
> Besides, shouldn't the third parameter of OPT_CMDMODE supposed to be
> the address of the variable that would receive the value in its fifth
> parameter?  I do not see a decl for check_ref_format_branch variable
> (isn't that the name of the function???).
>
> Ahh, you said it builds but does not pass test.  Of course, that is
> because this part is completely bogus.
>
> It appears that to your series the only thing that matters is the
> shape of the tree after applying all of the patches, and individual
> steps are not ready to be reviewd, so I'd stop here.
>

I had only intended /submit to show the last commit I had made that had passed
all the tests. I will review everything and only submit again once im 100%
sure everything is in order. Sorry Junio!
