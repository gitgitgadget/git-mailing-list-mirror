Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1821F404
	for <e@80x24.org>; Fri, 13 Apr 2018 22:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeDMWfs (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 18:35:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:35891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752258AbeDMWfr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 18:35:47 -0400
Received: from [192.168.0.129] ([37.201.203.18]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lz3rc-1eKsFI3axk-014Abu; Sat, 14
 Apr 2018 00:35:40 +0200
Date:   Sat, 14 Apr 2018 00:35:39 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Deprecate support for .git/info/grafts
In-Reply-To: <CAGZ79kbEec_U5wL_aOS5O_3+ZOshGwARALpjz801h-fRx-zotA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804132339130.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <CAGZ79kbEec_U5wL_aOS5O_3+ZOshGwARALpjz801h-fRx-zotA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Yokldv6bcA86PN8P3B5GlILxbrFG6UzBG1DdMNVrHRtAJJkY4al
 xZIAJFkRhTzWE1bmljp4Be+3VKqoF1/lsLCuygucmciHVbdh8AABFbvzaQpHHdDqYrhmKHo
 SVsehtMLY06R444dtgKF37l4dcEkFVvoCi2H+FI31Mz2+BColgzWtykFe/XY51lnFBotUDU
 SHv8GUHo2J6Xytzho/q1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7B8ezv1oa20=:6+y8oUgdfbnFfgBjtI7Udq
 G62OLgaW+PotVw44GIOUiJDQMPi4yyWdXuFWeggjdPObhWiVCIbtD/YjBB5e7rFcw4ntr+N+A
 xWFe2xvrFBAeN5Z2986b+CqQLF/NuPCWCACS2PooRV/ndTOqsbP8MfeynBa4HtuLjtmZjIBbS
 I/APp5AaSajrBc2tEGteGERLwl6Jgo1FxUNjEYEN3z6bKr3le0gRUU4z+n1wIg9k1H0QL+vzv
 Jav3OO3UROoqMwWJH0mzGKbkwnvQP49wwHmHqIxnnIv+5GepBCQYvrHVv5i6Ok+KdpT97xHTa
 uDN/UzqXCwd3Uy1xZp994Uj77zn6B95cc5S5ozY6a5EOBPREqeHt14jNj9j4z4zxjBO3mnBrJ
 iHkaGp/i9PiFdg69Xvn08FtCSK/Fp8YOL2Y4TMNya6fO6QhapY6jxoZNtjq2VgRsWkaZUGQJ7
 GNus3WHcZQkAopNdvTTJ5zw6/U1NsJmRWTfISUYV8BaApj8ErFvcz/nXbbRir55lh5UuRh5H9
 s4E/x3g27V/9hYOYu0P2UgaXggmJVgbpjO64t2j7IXblpZu0Ci8IQeongQO85U9K0zPrMI8l2
 7g7LjwQzdu8yFsaIDApdinGgJgCijECLucdfEETbQNt+wXFYxZdC1zCRiuDGGzu6LO1iK7LMQ
 m6KLTe5W9V+JSfLfCtgOGgC/vsiy12VMD9BOhy1yFGcEZHt6B2KMFZfa+E6pUfveRyOcA1PF2
 cANogdhJfS0hyoJEBeqnn+U2VYR3YSEk8ldU4nsR7mGaUlEgLieXxLRtBiokFmv7CRrfmunzE
 G9YIWDDxBZgoh7d9AG0HI5ZB4Z6lGYvLuUlIhighvP1g4RNxdA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 13 Apr 2018, Stefan Beller wrote:

> On Fri, Apr 13, 2018 at 4:11 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > The grafts feature was a convenient way to "stich together" ancient
> > history to the fresh start of linux.git.
> 
> Did you mean: stitch?

Yes ;-)

> > Its implementation is, however, not up to Git's standards, as there are
> > too many ways where it can lead to surprising and unwelcome behavior.
> >
> > For example, when pushing from a repository with active grafts, it is
> > possible to miss commits that have been "grafted out", resulting in a
> > broken state on the other side.
> >
> > Also, the grafts feature is limited to "rewriting" commits' list of
> > parents, it cannot replace anything else.
> >
> > The much younger feature implemented as `git replace` set out to remedy
> > those limitations and dangerous bugs.
> >
> > Seeing as `git replace` is pretty mature by now, it is time to deprecate
> > support for the graft file, and to retire it eventually.
> 
> It seems that the maturity needed for this commit was reached in
> 4228e8bc98 (replace: add --graft option, 2014-07-19)

Right. I'll add that to the commit message.

> Reviewed-by: Stefan Beller <sbeller@google.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> >                 return -1;
> > +       if (advice_graft_file_deprecated)
> > +               advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
> > +                        "and will be removed in a future Git version.\n"
> > +                        "\n"
> > +                        "Please use \"git replace --graft [...]\" instead.\n"
> > +                        "\n"
> > +                        "Turn this message off by running\n"
> > +                        "\"git config advice.graftFileDeprecated false\""));
> 
> So the user would have to run:
> 
>   for line in <GIT_DIR>/info/grafts:
>       git replace --graft $line
>       # The order in the grafts file is the same as the arguments,
>       # but we'd have to pass each as its own argument
>   rm <GIT_DIR>/info/grafts
> 
> I wonder if we want to offer a migration tool or just leave it
> at this hint.

There is contrib/convert-grafts-to-replace-refs.sh.

I wonder whether we have to care enough to implement a `git replace
--convert-graft-file`...

Ciao,
Dscho
