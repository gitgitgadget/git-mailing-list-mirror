Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D7A1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 04:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfD3Eq4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 00:46:56 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52296 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3Eq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 00:46:56 -0400
Received: by mail-it1-f194.google.com with SMTP id x132so2633922itf.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 21:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=44P12RKWdQX18sviRtm2apZKLaBKeSV/dpl9aTXKdgw=;
        b=J3gLP7sroazOS6qRCH2ytTnDIu7bsqnwLNENc9B50bSPgIclbC15TqNuQNH10DEglR
         bS0D8tEfpCLisQ1VbH8aroRkPdNJ96PUSphWG053el7g3vNkdF71M7NFpvJWuicQkcYs
         NZLHDhVkjyfMkSoBuwCH6JWgUTyGO36TTHXh39exUjxOnmc3pg7C8QmP4TDm4lP5gy4l
         NRbt97VYMfIbcb2ZS27Phgy3hfqQVmwaaSxYEwpx7BAf+3cSwQYNTn5MLsRlrPPmrgg9
         mq7G87AkEdoYfvuJtZDbe6Y/KOtukpnYYQe/cM019OL4Un4FyhHvQPe8VI9sH8i+N6v2
         HpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=44P12RKWdQX18sviRtm2apZKLaBKeSV/dpl9aTXKdgw=;
        b=j+kJEsBxALrv27LFHCklWOHyXU2cHx02fdBDsbvHF6CC8Ft4ObapWHuLzgcT65NM+g
         YQGentZKuuRdG5XVZG6OA5aAc7IQPrR1Lva0B9Vlf7aQJWNqqp3x0cNujnTjPt1Gd28Q
         bFw/bxwvF1YxS4Wslj1V/NGLMY/X4zyQclxeXl5h9k+sOf0i29KJasXeO+5PonUVYjsM
         pyWMoajiRvDAYmSb0V1O2jKHI1NLqvMx/LFLeCym9/wPrUdixF4WvgRcNIaT9NnYMM2O
         Pz/KwCLQE4iBeE4nJXX0mcOyx1NfxPQXDQKQAwxLk6jFDDdqJ7h0pzaaamHpxrKryBuo
         XIqA==
X-Gm-Message-State: APjAAAU9F0Gb6h9sIqTUbrn0oVcF3mYMzXVHWPtyhxzAvBwqwLToD22l
        UnjuxCnh/fARA5qxaOY/OKydah6yDCAIFDUp/qY=
X-Google-Smtp-Source: APXvYqxZhe2D6wM8l9g/c0bSaA/miamlnKTejV71Z8rFteGsgSPPJRkQBpzqkizr2leeRER1fmKClKwKRfhyEBAeepI=
X-Received: by 2002:a24:6292:: with SMTP id d140mr2062708itc.12.1556599615383;
 Mon, 29 Apr 2019 21:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190423091837.50290-1-johnlinp@gmail.com> <CABURp0rSTT=8biNhBvsGP4fdEHBT4B5beVKsm=Mdp7Ei8Dw72w@mail.gmail.com>
In-Reply-To: <CABURp0rSTT=8biNhBvsGP4fdEHBT4B5beVKsm=Mdp7Ei8Dw72w@mail.gmail.com>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Tue, 30 Apr 2019 12:46:44 +0800
Message-ID: <CAKO26MswBM5sjuVSnxssOc4jd+hqXiko=+6ROatOm2H7jndujA@mail.gmail.com>
Subject: Re: [PATCH] status: add an empty line when there is no hint
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phil,

Thank you for the review! I will fix the test cases and submit a new
version of my patch.

Best,
John Lin

Phil Hord <phil.hord@gmail.com> =E6=96=BC 2019=E5=B9=B44=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> You should probably add some test that demonstrates what your change
> intends to do.  For that matter, though, your test already breaks at
> least two tests in t7508-status.sh:
>
> not ok 14 - status (advice.statusHints false)
> not ok 23 - status -uno (advice.statusHints false)
>
> Phil
>
> On Tue, Apr 23, 2019 at 2:21 AM John Lin <johnlinp@gmail.com> wrote:
> >
> > When typing "git status", there is an empty line between
> > the "Changes not staged for commit:" block and the list
> > of changed files. However, when typing "git commit" with
> > no files added, there are no empty lines between them.
> >
> > This patch adds empty lines in the above case and some
> > similar cases.
> >
> > Signed-off-by: John Lin <johnlinp@gmail.com>
> > ---
> >  wt-status.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/wt-status.c b/wt-status.c
> > index 445a36204a..0766e3ee12 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -175,7 +175,7 @@ static void wt_longstatus_print_unmerged_header(str=
uct wt_status *s)
> >         }
> >
> >         if (!s->hints)
> > -               return;
> > +               goto conclude;
> >         if (s->whence !=3D FROM_COMMIT)
> >                 ;
> >         else if (!s->is_initial)
> > @@ -193,6 +193,7 @@ static void wt_longstatus_print_unmerged_header(str=
uct wt_status *s)
> >         } else {
> >                 status_printf_ln(s, c, _("  (use \"git add/rm <file>...=
\" as appropriate to mark resolution)"));
> >         }
> > +conclude:
> >         status_printf_ln(s, c, "%s", "");
> >  }
> >
> > @@ -202,13 +203,14 @@ static void wt_longstatus_print_cached_header(str=
uct wt_status *s)
> >
> >         status_printf_ln(s, c, _("Changes to be committed:"));
> >         if (!s->hints)
> > -               return;
> > +               goto conclude;
> >         if (s->whence !=3D FROM_COMMIT)
> >                 ; /* NEEDSWORK: use "git reset --unresolve"??? */
> >         else if (!s->is_initial)
> >                 status_printf_ln(s, c, _("  (use \"git reset %s <file>.=
..\" to unstage)"), s->reference);
> >         else
> >                 status_printf_ln(s, c, _("  (use \"git rm --cached <fil=
e>...\" to unstage)"));
> > +conclude:
> >         status_printf_ln(s, c, "%s", "");
> >  }
> >
> > @@ -220,7 +222,7 @@ static void wt_longstatus_print_dirty_header(struct=
 wt_status *s,
> >
> >         status_printf_ln(s, c, _("Changes not staged for commit:"));
> >         if (!s->hints)
> > -               return;
> > +               goto conclude;
> >         if (!has_deleted)
> >                 status_printf_ln(s, c, _("  (use \"git add <file>...\" =
to update what will be committed)"));
> >         else
> > @@ -228,6 +230,7 @@ static void wt_longstatus_print_dirty_header(struct=
 wt_status *s,
> >         status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" =
to discard changes in working directory)"));
> >         if (has_dirty_submodules)
> >                 status_printf_ln(s, c, _("  (commit or discard the untr=
acked or modified content in submodules)"));
> > +conclude:
> >         status_printf_ln(s, c, "%s", "");
> >  }
> >
> > @@ -238,8 +241,9 @@ static void wt_longstatus_print_other_header(struct=
 wt_status *s,
> >         const char *c =3D color(WT_STATUS_HEADER, s);
> >         status_printf_ln(s, c, "%s:", what);
> >         if (!s->hints)
> > -               return;
> > +               goto conclude;
> >         status_printf_ln(s, c, _("  (use \"git %s <file>...\" to includ=
e in what will be committed)"), how);
> > +conclude:
> >         status_printf_ln(s, c, "%s", "");
> >  }
> >
> > --
> > 2.21.0
> >
