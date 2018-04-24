Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C531F404
	for <e@80x24.org>; Tue, 24 Apr 2018 10:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756587AbeDXKw4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 06:52:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:45795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756568AbeDXKwz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 06:52:55 -0400
Received: from [10.49.234.97] ([95.208.59.141]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lj25i-1eY0VZ44RK-00dH1W; Tue, 24
 Apr 2018 12:52:44 +0200
Date:   Tue, 24 Apr 2018 12:52:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Philip Oakley <philipoakley@iee.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v8 09/16] rebase: introduce the --rebase-merges option
In-Reply-To: <83137354138143FD962AF49D37F93E9E@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1804241105170.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de> <0c92bdd1829328544269722cbbd3edcd169bb148.1524306547.git.johannes.schindelin@gmx.de> <83137354138143FD962AF49D37F93E9E@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XEld/ADIPrduhJS/SuHyCSdFUW+u0OqvAZ+64cdeYXq4vSE1gHI
 A1ZZI2zVbD2h9ZuEBjx+mcLjekfkH42d3wiNb5ykg2K12n4YB4xQR9gEuV/8B5GArFTcsIW
 BBxTjLWRvv2cCO/gu1+csLJHdEb+LORdII2dKy3oEHdMlUZtpie4byo9GJ49iOQclEchyFY
 wn+1UhLgGlGerHq3QAhtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xrLyy20/SE4=:DVzPzGKGdGj04PxIYMjNNq
 S3c6UJKcUWmfShZjP/3P6fhMxzHbe9qPqzLzG0yIXnXtnh9XIx1ILYLZWe/eMfeMhXhbfw6Ur
 QjpbAg0SjMMOWL5Y4CsU5itdvkHyY67HoEFTzUDSXN9SOG2eEBNjXNHN5SBYjshsBLVMVlBSx
 YJoz2zSIQ3sahmBQgmBKeK2Wz9K64t2PwYuYEJUaKPJZmsrYm2str4j0/bOtvWrD6NOi2AKte
 g50vcBuNF6AFc4SJlbLYYMJw18koFFV2VMUbm41ibX2JZguyD53l+uOFV8JZbzWmSVVGv/CHx
 tjV95kvaeigPDFSfudfGevDqFAR4oKv8Lrwktm/vob8SV3s812o8Rwx/nmRMiG5Vbt9E15fWs
 5y0AkEW/tnKHQSmXCoR+oz8Lieo4UAFe3ROBgu0beZMQxj6eTT3lT36troP+Inm4/hm0Rh+v+
 m+FHkHFXaVIqjlgwAWQho4BUrgjV5QwTTm4QT1m3AGaZrf9oiU2Onk+ffm4bVISw4lDUlcTpS
 e46nzhkLaDvKnUjLuvgCOzWsJ1qhnN0xuL7iRQ8g3q8TGISTQfJKPQywP+DKKPIdhGm8zqEi8
 suvNwTbZcrRqv/G+9mSKWDK9yA0VuyjVurdk3UgZRnUGqsy2X/yI8qYGyrAnH1FssPIQkGiA7
 dMGy3ZMzpGaoQUp3rpVwCYEmb7vnByoh2cBr1YOJcWnSMdJx0NGZyeCfhxA3v9T4fZXmis+2a
 8y9jAUkwTIy+6uWP/mtQG4ZGvbgWtQVSgzMzxG2jzP90RcgwvCGXmSCjshjqBgFSMrwX8lZ6C
 fjiiwsWRqx6u1Xn3m9mBtt3z0n0PKp+YUlYgv3KFwO1INhnMAg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sun, 22 Apr 2018, Philip Oakley wrote:

> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> > Once upon a time, this here developer thought: wouldn't it be nice if,
> > say, Git for Windows' patches on top of core Git could be represented as
> > a thicket of branches, and be rebased on top of core Git in order to
> > maintain a cherry-pick'able set of patch series?
> >
> > The original attempt to answer this was: git rebase --preserve-merges.
> >
> > However, that experiment was never intended as an interactive option,
> > and it only piggy-backed on git rebase --interactive because that
> > command's implementation looked already very, very familiar: it was
> > designed by the same person who designed --preserve-merges: yours truly.
> >
> > Some time later, some other developer (I am looking at you, Andreas!
> > ;-)) decided that it would be a good idea to allow --preserve-merges to
> > be combined with --interactive (with caveats!) and the Git maintainer
> > (well, the interim Git maintainer during Junio's absence, that is)
> > agreed, and that is when the glamor of the --preserve-merges design
> > started to fall apart rather quickly and unglamorously.
> >
> > The reason? In --preserve-merges mode, the parents of a merge commit (or
> > for that matter, of *any* commit) were not stated explicitly, but were
> > *implied* by the commit name passed to the `pick` command.
> >
> Aside: I think this para should be extracted to the --preserve-merges
> documentation to highlight what it does / why it is 'wrong' (not what would be
> expected in some case). It may also need to discuss the (figurative) Cousins
> vs. Siblings distinction [merge of branches external, or internal, to the
> rebase.

Quite honestly, I'd much rather spend time improving --rebase-merges than
improving --preserve-merges documentation. In my mind, the latter is
pretty useless, especially once the former lands in an official Git
version.

Of course, feel free to disagree with me by sending a patch to improve the
documentation of --preserve-merges ;-)

> "In --preserve-merges, the commit being selected for merging is implied by the
> commit name  passed to the `pick` command (i.e. of the original merge commit),
> not that of the rebased version of that parent."

It is much, much worse:

	In --preserve-merges, no commit can change its ancestry. Every
	rebased commit's parents will be the rebased original parents.

Or some such. But really, why bother describing something *that* broken?
Why not work toward a solution that makes that broken option obsolete?
Like, say, --rebase-merges? ;-)

> A similar issue occurs with (figuratively) '--ancestry-path --first parent'
> searches which lacks the alternate '--lead parent' post-walk selection. [1]. I
> don't think there is a dot notation to select the merge cousins, nor merge
> siblings either A.,B ? (that's dot-comma ;-)

I actually had missed `--ancestry-path`... I should probably use it in the
description of the "cousins".

> [... lots of quoted text...]

Could I ask you to make it easier for me by cutting quoted text that is
irrelevant to your reply? The way I read mails forces me to scroll down
(sometimes on a phone) all the way to the end, just to find that that time
was spent in vain.

Thanks,
Dscho


