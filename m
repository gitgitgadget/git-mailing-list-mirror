Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED021FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754351AbeARVOO (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:14:14 -0500
Received: from mout.gmx.net ([212.227.17.22]:52925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753956AbeARVOB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:14:01 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MS1g6-1eEj3R2Trm-00TCF3; Thu, 18
 Jan 2018 22:13:55 +0100
Date:   Thu, 18 Jan 2018 22:13:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <CA+P7+xozcQD2xuys6mh8MsfcYZ_nb2c9yxhDxkc7FTN2SfoofQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801182212210.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de> <CA+P7+xozcQD2xuys6mh8MsfcYZ_nb2c9yxhDxkc7FTN2SfoofQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2hTYAt4G7nv2ztDcyyAs+ACIwBF9wEw1BUKYRc9K1t6b/LRL4FW
 1p85zDe56MkiuGEzFLSdRslTRSXW5BwzzTYwvQhNrfx8sIbexNGMiQjSsUk0XGHFt6BckVY
 3+OGHoIsvFK6w3HO+O7gBw8P4JXVCFRPV98AumsEDHHJ3Q3sNdkwt9uI7zMKymLokR6Bik2
 RiQPDA+U+3jAoFvsgHkvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HwCS7k4jFq4=:IYyvu9dpJz9ZCJVIGqhjy8
 t0yUUOyGlzdItlonM6puUXJnMeJIoBfE2mUObqrS5C0HnJu2KKnzZyZDJj3MabyKfIh1dO8So
 GZvSk8xWHfeBGidyu2xGqjvpxA8/ekgRGu1KN6DwGA7VioH928Pnc/GE6RBEGYpD9Yltyd3Ee
 Pdz3bN2Yr4KhGmbzV2wgK6y7h61CFMkReGT9AfJPlx6t4BgB81bEsEvv6UIRU6LgQG50b6DDH
 f0OPwTb4MzQFa27WORxkrOJYG/8PtUMZ783RD4rC+vz6su73bi1QpeA2PN2eERvKq9Lf6tZGK
 /xmBJY7DCBisE73hlw8S92Jb6WJP8SfAwRRUQHcXiR80T0KDnOztlD2/GMGtoVWYSuEMIqdvA
 5hMkbSMsjSQCieXwByFiJwYk/byTEnZwYG7Rizy0ksA71/ggMJjGrReprNkwLGLL6gG8onjVq
 YzMFb37/ZvWSzIzm8PMyQQpr4ZdANJ767RKBoJYa4T2wOpcY1U6yclfGHSBe8g6ahJaj75Myv
 EGNVp+yyfEorKeWqPpQBITMcFK/2wdGr/f+b2a2JG/Ht1Vf3xmjUnx6Tf27sonuSpy6i8f0PY
 723tJfdwuNqyKHlSmzq214J5H40LAFbe7I1fq0pS35/n+H69CgLHa+XU9TuU8thAV2CXsZih0
 qi0gxCXWcDPkQXRRQTt83U0RoecKKA0SKnlO41B5LFz2ScM3Tve3kNo5j6/ZLleHC/V1OOsqQ
 oU1Bfgj++syptoWFumzdngZmz5bHYLlduKn9/B37z8txP5XmPYbzNzZhr8/6nIU33hYYvN5Ix
 hgqur5LuRKS84vFG//bVuD8pLkJTFaB/i5JzkuJeVB0uVVkRKw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Thu, 18 Jan 2018, Jacob Keller wrote:

> On Thu, Jan 18, 2018 at 7:35 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > This commit implements the commands to label, and to reset to, given
> > revisions. The syntax is:
> >
> >         label <name>
> >         reset <name>
> >
> > As a convenience shortcut, also to improve readability of the generated
> > todo list, a third command is introduced: bud. It simply resets to the
> > "onto" revision, i.e. the commit onto which we currently rebase.
> >
> 
> The code looks good, but I'm a little wary of adding bud which
> hard-codes a specific label. I suppose it does grant a bit of
> readability to the resulting script... ? It doesn't seem that
> important compared to use using "reset onto"? At least when
> documenting this it should be made clear that the "onto" label is
> special.

Indeed, `bud` helped me more in the earlier times of the Git garden shears
when I had to *introduce* branch structure into the long list of Git for
Windows' patches.

If there are no voices in favor of `bud` other than mine, I will remove
support for it in the next iteration.

Ciao,
Dscho
