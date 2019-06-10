Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BCA91F462
	for <e@80x24.org>; Mon, 10 Jun 2019 19:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbfFJTCY convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 10 Jun 2019 15:02:24 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:45504 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387674AbfFJTCY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 15:02:24 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id B11F02003F6;
        Mon, 10 Jun 2019 21:02:17 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, timcharper@gmail.com
Subject: Re: Inclusion of translated git manpages into the packaging systems
Date:   Mon, 10 Jun 2019 21:02:17 +0200
Message-ID: <1835964.yutTd2aTbA@cayenne>
In-Reply-To: <nycvar.QRO.7.76.6.1906101906140.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <1979608.xhrAu3A07H@cayenne> <nycvar.QRO.7.76.6.1906101906140.789@QRFXGBC-DHN364S.ybpnyqbznva>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, 10 June 2019 19:09:54 CEST Johannes Schindelin wrote:
> Hi Jean-Noël,
> 
> On Sun, 9 Jun 2019, Jean-Noël AVILA wrote:
> 
> > I took on the task of creating a project for the translation of man-pages 
at
> > https://github.com/jnavila/git-manpages-l10n
> >
> > Up to now, the translations have started for 3 languages:
> >
> > * German (2 pages)
> > * Brazilian Portuguese (6 pages)
> > * French (11pages)
> 
> Nice!!!
> 
> > In order to provide feedback to translators, it's time to have these
> > pages included with the distributions of git. Right now the process of
> > compilation of the man-pages is still a bit off-tree, because it relies
> > on a recent version of po4a (v0.56) which has not yet reached most
> > distros.
> 
> Maybe there is a way to skip the Makefile task when a too-old po4a is
> detected, with a warning?

The project is provided with a script that downloads the correct version of 
po4a from the root repo (this is needed for ci).

I can provide an archive comprising the precompiled manpages so that packagers 
don't need to mess up with po4a.

> 
> > I miss expertise in the process of packaging. Depending on the type of
> > distribution, the route to packaging might differ (for Mac OS and
> > Windows, maybe a direct inclusion, for Linux dists sister packages).
> > That's why I need your help to correctly perform this integration.
> 
> Historically, Git for Windows punts on translations, excluding any
> non-en-US documentation (to save on bandwidth for the installer, which did
> grow from <30MB to 44MB in the last four years alone).

It might not be the correct argument for now, but a tgz of the manpages 
presently weights 230kB.

> 
> There were a couple of motions to change that (maybe in the form of add-on
> packages/installers, maybe in the form of a "full" installer), but nothing
> came of it so far.

If there's any chance to get this move alive, who should I refer to? 
Otherwise, where can an additional package be built?

> 
> Therefore, as far as Windows is concerned, I hate to admit that my answer
> is "don't worry for now, we only include US-English documentation
> anyway"... :-(
> 
> Ciao,
> Dscho




