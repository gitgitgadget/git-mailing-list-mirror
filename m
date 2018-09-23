Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06AAE1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 06:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeIWMr5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 08:47:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45557 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeIWMr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 08:47:57 -0400
Received: by mail-io1-f68.google.com with SMTP id e12-v6so15361446iok.12
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d0WPYvOQCCqu+4POSSZhAt1mLl/ZxdHeujDfbRR+4Vk=;
        b=BS5p5Nu2xL90+v/lLmmeMPolCBtGgxLD2AV2S+HmbyXDsHq9C+/WTknTn1MMTcShqG
         Fd4mrFXxod9gzSM0l9oc1TGRgQWVJT9YxiAfLi2yUGQJJ0rmZYfNbuw2VqyA0+/pnumO
         XsZdZBeU0vyM6oejDJDDGERhPP/MfW2s92dzLc6C08ruQj325sqMc2bjcAXDdgse6C++
         XGaaVwD+RIG3i0Rx6Lk71viWKqR8w9SAXWNNqpDty7ihL2XSr2T19n8VRahwpkAJqbi6
         2AoctM8ptjBHNUKsMD9pQIFChavExbXMaAasbd507QxuQnwR+IB/lS0gW2dPvaFMumVH
         5AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d0WPYvOQCCqu+4POSSZhAt1mLl/ZxdHeujDfbRR+4Vk=;
        b=ioPXS+x2z+fp97Nw8vipKT4K+he2lw/b9T89bG3SdPVcCCngCRUpvLZCxv1x7Uo8Jz
         kXkCxJx55QuTdmnUN14y1S/CTxdkwuct8ODjXqEd4xAx1qmrFaKYC/pGl5yspbrRCSg0
         2dS4uc6rxURR63/mmHPc5sA5Vfmv5CIStYqMH94TbrUSKdozy1PKWX0C1XKFJ/nan06Z
         taGJYhtzNyVfNtb1mCFkrKfN6SF5LH5TCYbUqwJK92lsjsYmrIEISpq0o4HZddoq/5Hy
         IqFxew1nOHAWYHhhU6o3vQ/XMP8ekehN6ncIaDxhdHSEO3VdcTbhsLauNxkbKpTmLJoc
         n0hA==
X-Gm-Message-State: ABuFfohB2w83ze7k2VCf5OdEk+D2/FRLHQFdP7odQeJKTplMnu1/VJdq
        R/KRRT5sFuxRoT+f8z5hk0gfpodkNe115NdBl1w=
X-Google-Smtp-Source: ACcGV634LkouCzn27X/mkoBh6VnglV6f58Krodzr4UrWrYEsKdEyFxtL8cgKVjCMf5SEIwnHAH5A4snfto406fqGxpM=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr3641136ioe.282.1537685492716;
 Sat, 22 Sep 2018 23:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180922174707.16498-1-pclouds@gmail.com> <87fty1jppt.fsf@evledraar.gmail.com>
In-Reply-To: <87fty1jppt.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 23 Sep 2018 08:51:06 +0200
Message-ID: <CACsJy8CjZ+eupz+j5go2bRbSyf-cXWvCJkPFjfDejj89Z3j9ig@mail.gmail.com>
Subject: Re: [PATCH] git help: promote 'git help -av'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 9:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sat, Sep 22 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > When you type "git help" (or just "git") you are greeted with a list
> > with commonly used commands and their short description and are
> > suggested to use "git help -a" or "git help -g" for more details.
> >
> > "git help -av" would be more friendly and inline with what is shown
> > with "git help" since it shows list of commands with description as
> > well, and commands are properly grouped.
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
> >  git.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/git.c b/git.c
> > index a6f4b44af5..69c21f378b 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -31,7 +31,7 @@ const char git_usage_string[] =3D
> >          "           <command> [<args>]");
> >
> >  const char git_more_info_string[] =3D
> > -     N_("'git help -a' and 'git help -g' list available subcommands an=
d some\n"
> > +     N_("'git help -av' and 'git help -g' list available subcommands a=
nd some\n"
> >          "concept guides. See 'git help <command>' or 'git help <concep=
t>'\n"
> >          "to read about a specific subcommand or concept.");
>
> A side-effect of this not noted in your commit message is that we'll now
> invoke the pager, perhaps we should just do:
>
>     diff --git a/builtin/help.c b/builtin/help.c
>     index 8d4f6dd301..1a3b174aaf 100644
>     --- a/builtin/help.c
>     +++ b/builtin/help.c
>     @@ -436,9 +436,9 @@ int cmd_help(int argc, const char **argv, const c=
har *prefix)
>             parsed_help_format =3D help_format;
>
>             if (show_all) {
>     +               setup_pager();
>                     git_config(git_help_config, NULL);
>                     if (verbose) {
>     -                       setup_pager();
>                             list_all_cmds_help();
>                             return 0;
>                     }
>     @@ -460,8 +460,10 @@ int cmd_help(int argc, const char **argv, const =
char *prefix)
>                     return 0;
>             }
>
>     -       if (show_guides)
>     +       if (show_guides) {
>     +               setup_pager();
>                     list_common_guides_help();
>     +       }
>
>             if (show_all || show_guides) {
>                     printf("%s\n", _(git_more_info_string));
>
> Or is there a good reason we shouldn't invoke the pager for e.g. -g when
> the terminal is too small (per our default less config)?

Different pagers may behave differently (and so far "help -a" still
fits in my screen). So I don't think we should invoke pager more than
necessary.
--=20
Duy
