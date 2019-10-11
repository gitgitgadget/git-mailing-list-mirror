Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175261F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 15:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfJKPr5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 11:47:57 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35889 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfJKPr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 11:47:56 -0400
Received: by mail-vs1-f67.google.com with SMTP id v19so6547293vsv.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bSpV/ki+HgQxUf0EBSkcUEJGNXZypPqjxFuK6rrR2WQ=;
        b=AngDtf7HRzH88uwvBKAEG/Kukr0D/QeDMKqS5D/rZT64ro/6KlpyYcgRQpOYu1UaiG
         m2jPVlcmCONpbQQy1xCSF/Ze5mdLYVAJD2eVXJhAIjx65vImPkr3HQVImM7fuxWfqzXm
         xKP+WsiPBlmMDUGoji5yyG4aEPu7GUcAECEemDFj4pJY1mxszMQIJ7TIPa9KUw2knBcV
         Us1Ejh96QVcHART90AdtOMXxZ7SbjMW5byNRsdeqgtl3xaG+VatDCKphDk0b9C8RA69n
         3IZE2JyBRdT7wrO81tLuFxvOxKVNa5d2NiMzaKqRAvOgTgPzy9GRbGspTA/pdehbrt2y
         z5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bSpV/ki+HgQxUf0EBSkcUEJGNXZypPqjxFuK6rrR2WQ=;
        b=tzESjeFfFECXSepHxsOIFVRHq8GtybMhCWgQzDYW4aXt+RWSYTUJHm78D3eKvQav19
         oeCaacGVdp3ZpERavoqtwb3eriKdtMd0+kaq4H8aBz2xT7wRQwxaPrIxLb79CkvG49a2
         OnuWd394qmBSmBq61Ot3hmHXtSDr+9kag6DUK+lG7rFBAaxqijAYI/cny66Bb7rMPxOq
         /NSwCDsp0QPKSYJ0yXWmOH2r2kyO3gYMatu4gx00wkKBjEnyIOA7/Ih68mXUiX1kj1xC
         tOGevsxEOB0wBezp/me/7vpdSUcX7K1McyiNlwHoEggAQM5dnHM6MLTR51wmkhdqSucq
         nmQA==
X-Gm-Message-State: APjAAAXD1rYQHntAr8ArXbWAF2oT7zJCbMEcLubtAX2pdS4LA3+TxurE
        n9CFDb37jdMjSUrYTeBL9U7twf8N5iB4dElK3sI=
X-Google-Smtp-Source: APXvYqws7CGCGwGaVDz0bgdT2QG3zIEcoVyWj8IedQdbR8BR/tvOaC85E9liK4CqMR3+1M5+yv8nsVX5D2voS+/DpoU=
X-Received: by 2002:a05:6102:232e:: with SMTP id b14mr8982255vsa.75.1570808875824;
 Fri, 11 Oct 2019 08:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <b172eba0b748c3f0f638786a5cfba905aca385cc.1570782773.git.bert.wesarg@googlemail.com>
 <20191011144650.GM29845@szeder.dev> <CAKPyHN0s8Rc8Sbp7ubyJ5cTDC5oh4Re+wqyTUWUo+3HgpKfECg@mail.gmail.com>
In-Reply-To: <CAKPyHN0s8Rc8Sbp7ubyJ5cTDC5oh4Re+wqyTUWUo+3HgpKfECg@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 11 Oct 2019 17:47:44 +0200
Message-ID: <CAKPyHN22-SnZ2_o1MO6EXuWk7S2AAWGQSjxu0OrhDq4pw=ap=g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] format-patch: create leading components of output directory
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 5:45 PM Bert Wesarg <bert.wesarg@googlemail.com> wr=
ote:
>
> On Fri, Oct 11, 2019 at 4:46 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> >
> > On Fri, Oct 11, 2019 at 10:36:41AM +0200, Bert Wesarg wrote:
> > > Changes in v4:
> > >  * based on dl/format-patch-doc-test-cleanup and adopt it
> >
> > Thanks...  but here I am nitpicking again, sorry :)
> >
> > > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > > index 72b09896cf..9facc3a79e 100755
> > > --- a/t/t4014-format-patch.sh
> > > +++ b/t/t4014-format-patch.sh
> > > @@ -1606,6 +1606,29 @@ test_expect_success 'From line has expected fo=
rmat' '
> > >       test_cmp from filtered
> > >  '
> > >
> > > +test_expect_success 'format-patch -o with no leading directories' '
> > > +     rm -fr patches &&
> > > +     git format-patch -o patches master..side &&
> > > +     count=3D$(git rev-list --count master..side) &&
> > > +     ls patches >list &&
> > > +     test_line_count =3D $count list
> > > +'
> > > +
> > > +test_expect_success 'format-patch -o with leading existing directori=
es' '
> > > +     git format-patch -o patches/side master..side &&
> >
> > The previous test case creates the 'patches' directory and leaves it
> > behind, and this test implicitly relies on that directory to check
> > that 'format-patch -o' can deal with already existing directories.  So
> > if the previous test case were to fail early or were not run at all
> > (e.g. './t4014-format-patch.sh -r 1,137'), then that directory
> > wouldn't exist, and, consequently, this test case would not check what
> > it was supposed to.
> >
> > I think it would be better to be more explicit and self-contained
> > about it, and create a leading directory in this test case:
> >
> >    mkdir existing-dir &&
> >    git format-patch -o existing-dir/side master..size &&
> >    ls existing-dir/side >list &&

one question: How about removing this directory first, just to be
sure, that mkdir does create a directory?

Bert

> >
>
> thanks. Your nitpicking is always appreciated.
>
> Bert
>
> > > +     count=3D$(git rev-list --count master..side) &&
> > > +     ls patches/side >list &&
> > > +     test_line_count =3D $count list
> > > +'
> > > +
> > > +test_expect_success 'format-patch -o with leading non-existing direc=
tories' '
> > > +     rm -fr patches &&
> > > +     git format-patch -o patches/side master..side &&
> > > +     count=3D$(git rev-list --count master..side) &&
> > > +     ls patches/side >list &&
> > > +     test_line_count =3D $count list
> > > +'
> > > +
> > >  test_expect_success 'format-patch format.outputDirectory option' '
> > >       test_config format.outputDirectory patches &&
> > >       rm -fr patches &&
> > > --
> > > 2.23.0.13.g28bc381d7c
> > >
