Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57A261F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 12:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945890AbcHRMnd (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 08:43:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:62386 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbcHRMnG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 08:43:06 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M5a9E-1bGVRj3x8K-00xcN8; Thu, 18 Aug 2016 14:42:36
 +0200
Date:	Thu, 18 Aug 2016 14:42:34 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Stefan Beller <sbeller@google.com>
cc:	meta@public-inbox.org, "git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608181430280.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HmYpQvrJ9YE7XNmsS408xXv7UzKXn777N4CxRSeKAW8TaLJYfSm
 AmHEkbqxLe4zIF/Y1y/fcFadrcCK7zdmptKbPMsnX1WtEa4uej6yAfQHrPt7OcHzG1a6hyH
 QfsfGa4luXX+WqxC9HKSE/8Tv0lDDOIqEzf+qWQFJh8tobl2VAHWnO/94IBe6ZrJnIy93/s
 uVEDYWd16My+8e9Zv2nZw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:uqoeyKXrZHY=:vfCVa6v64j8p5t8R5CleZ+
 DMQQKXFslg0dmVyLEfjNsimfsuC/R68UMyby1jtWFHOf/J/xzw8ut7WZYUp/TRi2wfi+8MIPh
 pAbPA3l4vjQgo5DgLpX9HKf+buHGjPF9I4cIhFoTR5iEDohr4JRkrdZyI1JWOHmE+Rg42w5+p
 2A4nqZZxZPlHuH9koY+wfiMT/kf4UD1xRJ5ZhCLDHw0/rJAQuUXgbqOd9jJCHI3kRMuy2ipkr
 BYgm/DIbeREqIM1jACP+vNJiZVrX5zb5q6zQdTTaCtdF1Hj0bdNUIeMyaRNNfdsSdWJbOJGhX
 H2Z426WT0yRH91FNTvjgW0fmzykXU6s1pZ0vfe0r4vubB/LYSOhKVihP2r++eLuVzFT1OJu18
 Ovr5AUHhOxHfK+SPV9XF/azvJuocyTam9O3/dfjVRHyKYvVWfj6aKhYoaWuYvD5wcpFHuW/53
 M1NnwtVu2HcHP2SrO9AgCjxQY7dS19SyCv08bR4CNzSmUQPv97EVuqS9Z+730BgWgyyQflLZ2
 LT/E1EHgQgqqSqdqxz5v+2o1z/gnMflZ9yLImaIRGAeacPoeT7el9yhsWR639b3eKhxnw8Yks
 kLn1Gno+Jf//443x0h6AWNetOZOvF3ubypqgEqlfG7mT1C9N7fCGM4bcA+ulo7wNTJCt/DXe5
 HkP00SqsAAjrJCaI1fNPgj1CFJ9fGGQ2wdNVhxqCYgv96YhnNDcFsgR6MwhPb4wHHyK4BbiEC
 OfzHNONKTif7/8v9/WMW/5mftkI3BJwWNwNpm4rFQ51HJo3Rsv4/NBqdvMBQF1naWUCHO6vik
 jVwj64A
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Stefan,

On Tue, 16 Aug 2016, Stefan Beller wrote:

> > BTW in light of the discussion we are having elsewhere I just need to
> > point out that it was *dramatically* faster for me to edit run-command.c,
> > find "hooks/" and adjust the code manually than it would have been to save
> > the diff and apply it.
> >
> > That's because I do not have advanced tooling on top of email (and I also
> > could not handle mutt, so I am stuck with a not-really-scriptable email
> > client).
> >
> > Just sayin'.
> 
> I ran into the same problem, just for a larger patch, so I figured I can
> download that from the public inbox and git-am it locally.
> So I maneuvered to the cover letter of the patch series I am interested in[1]
> and downloaded the series as a mbox.gz[2].

Maybe you can adapt the script I had written to perform that magic for
gmane?

https://github.com/git-for-windows/build-extra/blob/master/apply-from-gmane.sh

The relevant part is the one between the lines 48--72, where it detects
0/N mails and then looks for the first children containing k/N for k=1..N.

BTW I take this thread as yet another proof that people are unhappy with
mail list-based review: if you have to build *that much* tooling around it
(and Peff & Junio certainly have a megaton of advanced and sophisticated
tooling around it, holy cow!) it is really incorrect to state that the
mail list-driven approach works for you. It is much closer to the truth to
say that the mail-list-plus-loads-of-custom-tools-driven approach works
for you.

I am really not a fan of this.

The theory "it's inclusive because everyone has access to mail" falls on
its face, badly, when even old timers have to build entire infrastructures
around it just to begin to be able to use it efficiently.

It reminds me of an old software developer I met long ago, who claimed CVS
works for him. He had written tens of thousands of lines of shell scripts,
is what allowed "CVS" to work for him.

Same here. Old dogs claim the mail list-approach works for them. Nope.
Doesn't. Else you would not have written all those custom scripts.

Ciao,
Dscho
