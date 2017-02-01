Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54921F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 22:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbdBAWSW (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 17:18:22 -0500
Received: from mout.gmx.net ([212.227.17.20]:63563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbdBAWSV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 17:18:21 -0500
Received: from virtualbox ([217.136.241.150]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lz0aC-1cLwBd2mY4-014CLl; Wed, 01
 Feb 2017 23:18:10 +0100
Date:   Wed, 1 Feb 2017 23:17:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Handle PuTTY (plink/tortoiseplink) even in
 GIT_SSH_COMMAND
In-Reply-To: <xmqqr33hoetx.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702012311440.3496@virtualbox>
References: <cover.1485442231.git.johannes.schindelin@gmx.de>        <cover.1485950225.git.johannes.schindelin@gmx.de> <xmqqr33hoetx.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+RV4UHqBrjHznT7DOVENoWsNYMZM4G/OIewhPb92YrmbIe0RFzF
 OUgJ37xJHq2iY7l8bUEghSgXy8U4YccRfhWf4gI7nIv4/fH6Gqk1ukdnxIDxHeQMHIw507r
 3AaCNsXY8lMnCz3AeWrIVHAOpieNvUdekBXT8TmQi5rVwdTiVHYaLA07CkykVkO1X0FnSq1
 vNDq5BqIlkXvQA2/x9SFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G9wMI4retZM=:ikQPlUQ2Um7usRICZNhx0R
 cwVPQi0se3fzoGobGGnqLk08XBhgTXM6vQDwVMnyXvgEq/C5y+x+ltWAAMkUeeMmM0wAb9FvM
 0p2T4zzkITdEaTXTNJcNRiKcS9m7sB/kcrJ86XStV0yi19ovGORm4fVnCIyP0WtIoc+xbfJlF
 v1pqRarDrq73ihp6tdSjis5x78R+lX2i5jDqtLngCChWGC681YDemZUR7sdKeLsvnorBg1Wxu
 WBgfi14M6zNKg2Fdxvl4YacR3aGTHGK9wZzEUObl4a7bfy7jxB501ubAlWYABJk5xlf1jtf1G
 oMoYJVrJIUETUjZRhixC0WZgenNMHAkJ5sTdTRFNj3BFEzmDFdgdu3+ajxfuK29tWa9ly8exY
 I7f7+h/3lwA8poyf+GOzrJB2wKmwQBtL2SjEB/mokobkvSa/PAC3VWIearxI7+n3TOTI6DP+C
 245pMzEUGMFN8UVxTO8XVNgJIeYPw9K7nURxDTE+6YPbhq2V/TH/mwmCyDbi7LQtlKs2hi9Br
 ZEqiXDiJfcxwoLAq2j9Nkclej7sHIRWI2pSeEqHprqc2aYS2i9zDyru0lqVa7XUoSkhixspO5
 zdm11t3ltNXH88mJyyOUeOK65liFgdCIatFId+eoeSVqa4LQ1hpFLaGj7+pzftu+MxSATBDFQ
 +2Bm3VeGR1D0kWe3TWq/vwyyPx6tyCOnRmAtEDiugTVRuDPpIb0KhTQDIttmDDMH/MHXJdTpq
 g4LwsxGn8EGlQ/FSvwDA3JEg3lQNWbtA47/pmPr9uRNr/PouLpzfXojdSeXU2/fT7YcjPUwoB
 4D32o6T
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > It is quite preposterous to call this an "iteration" of the patch
> > series, because the code is so different now. I say this because I want
> > to caution that this code has not been tested as thoroughly, by far, as
> > the first iteration.
> >
> > The primary purpose of code review is correctness, everything else is
> > either a consequence of it, or a means to make reviewing easier.
> 
> You are utterly wrong here.
> 
> The primary purpose of code review is to spot and correct the
> problems the submitter has missed.  The problems can span from
> stupid bugs that affect correctness to maintainability, to design
> mistakes, to clarity of explanation for both end users and future
> developers.
> 
> Among them, correctness problems are, as long as the problem to be
> solved is specified clearly enough, the easiest to spot by the
> submitter before the patch is sent out.  The submitter is focused on
> solving one problem, and if the updated code does not even work as
> the submitter advertises it would, that can be caught by the
> submitter before the patch is even sent out.  
> 
> Of course, humans are not perfect, and catching correctness problems
> is important, but that is not the only (let alone primary) thing.
> 
> When a submitter has been focusing on solving one problem, it is
> easy to lose the larger picture and to end up adding something that
> may be "correct" (in the sense of "works as advertised by the
> submitter") but does not fit well with the rest of the system, or
> covers some use cases but misses other important and related use
> cases.  If the "does not fit well" surfaces to the end user level,
> that would become a design problem.  If it affects the future
> developers, that would become a maintainability problem.
> 
> Compared to the correctness issue, these are much harder to spot by
> the submitter alone, who focused so intensely to get his code
> "correct".  The review process is of greater value to spot these
> issues.

We will never agree on this.

From my perspective, design, explanation and maintainability are a
consequence of making it easy for reviewers to spot where the code is
incorrect.

And correctness is not covered by "the submitter tested this". Correctness
includes all the corner cases, where the "many eyes make bugs shallow"
really shines.

I'd rather have reviewers find bugs than users.

I will *never* be a fan of a review process that pushes correctness to a
back seat (yes, it is much harder than spotting typos or lines longer than
80 columns per row, but the ultimate goal is to deliver value to the end
user, not to make life easy for the maintainer).

Ciao,
Johannes
