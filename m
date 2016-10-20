Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ADC620987
	for <e@80x24.org>; Thu, 20 Oct 2016 10:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756732AbcJTKRr (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 06:17:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:52475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755935AbcJTKRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 06:17:46 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MS0c2-1cM0oh48E6-00TDpF; Thu, 20 Oct 2016 12:17:34
 +0200
Date:   Thu, 20 Oct 2016 12:17:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: Drastic jump in the time required for the test suite
In-Reply-To: <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610201154070.3264@virtualbox>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox> <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zr24kLUKZ0HVa9eb+9yZk6Q5sBHCvlnH80t1qpQyxKiI4rlDdie
 1qD/5mWlbYnVujH3IJsfFpJKKVg/0lIEThLYFcFCS7ttCo2yPL8ZFNZMZKrgV0s3JgKlPwk
 fIuowcW/Lka/VW276hZLKgDaDWRkxI79nDSqr8T3Ag6e6SUCYnZzelWtwHwwys7uKmgA2Pf
 2pUnYLEHoENbQcdwCoCMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4XcRNzB3Cr8=:M2EdFtx/NEEWhLoYS1YwPB
 Y//RNQXaPfn1Bq2Zdf2nxWgX2Qu/h6mnXWg2KK94WNRBWo1Bw7Gl5ZqS9qVOc7M8UupNoWqIg
 mXh+bVPcDDf7Zk8uoVRowxEBAKGbry0RQeu2jNKT6YHUGH45mFOqldN8E+DfEQhtZqf3I5XWk
 jpciNsDqVntWl2Vqjp7qLqIBdwPVmn3TMAJe7jhcTV+VMLgEnL5BzWK84n/7Hp1ztkexnsPEh
 IgFRtqLREAa9KKCHCd1NpqjHRGMxePVA/kr499DvrW+Exx/rpwMXhqXbDy1A2LpExZeswM5nY
 heINKV6SUSL06PX6Ndo3BRRXNJY96HVyZx8qsKtQ8S5tVnAtA2ZyouQLkVHzWLPMbggnkX8X1
 vJj+eP/bMKvYpvzZR4SI2y3U1W0xJ4WB7b5z/CAgOD/PFeSFmuNytfVtuQxQqS00vTeh5thqR
 P17LogT+UioaE04l/mRmE+6M1VgrbtujqSPOWyvdILQT/FulrbE1RUa5Dlu6NAOY2ZNIXdO4O
 VJPNAeB+OCjbK7Z4iENA+aKTIupiz6oTYAtRLmtd9EFDLzNVEKvA6DjF96Jb8uwgRcjG+ekSi
 V6HAiOPzRaK2X7RWJoqcDTqi919zreX/nzTBCHRibGYyyObTdM9C3UYkioBCI/+t5176Qt55F
 /+mSvgM+wkaMNDkqR2AgnDAuhj/b0VQywXMo9bVezHlxQ+EJNXEAfVMkowMTIfAf321xm2+GU
 Wg16gQQWGmpbspVLgD7Agi6zY2vqJiTX9uhMIUb487dGLNrek7VkKQ+TcwTIutHU7tdtmZM//
 h/u14bn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 19 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > What I can also say for certain is that the version from yesterday (commit
> > 4ef44ce) was the first one in a week that built successfully and hence
> > reached the test phase, and it was the first version of `pu` ever to time
> > out after running for 3h.
> 
> I am sympathetic, but I'd be lying if I said I can feel your pain.

Obviously.

> Admittedly I do not run _all_ the tests (I certainly know that I
> exclude the ones behind EXPENSIVE prerequisite), but after every
> rebuilding of 'jch' and 'pu', I run the testsuite (and also rebuild
> docs) before pushing them out, and "make test && make doc && make
> install install-doc" run sequentially for the four integration
> branches finishes within 15 minutes, even when I run them after
> "make clean".

You have the luxury of a system that runs shell scripts fast.

Or maybe I should put it differently: you set up the test suite in such a
way that it runs fast on your system, exploiting the fact that shell
scripts run fast there.

If you want to know just how harmful this reliance on shell scripting is
to our goal of keeping Git portable: already moving from Linux to MacOSX
costs you roughly 3x as long to run the build & test (~12mins vs ~36mins
for GCC, according to https://travis-ci.org/git/git/builds/159125647).

Again, I have to repeat myself: this is not good.

> Perhaps the recent change to run the tests in parallel from slower
> to faster under prove may be helping my case.

No, you misunderstand. The tests are *already* run in parallel. And
running them from slower to faster would only make a difference if the
last tests were not requiring roughly the same time to run.

Also, I cannot use prove(1) because it proved to be unreliable in my setup
(it does hang from time to time, for no good reason whatsoever, which
would only make my situation worse, of course).

> > Maybe we should start optimizing the tests...
> 
> Yup, two things that come to mind are to identify long ones and see
> if each of them can be split into two halves that can be run in
> parallel, and to go through the tests with fine toothed comb and
> remove the ones that test exactly the same thing as another test.
> The latter would be very time consuming, though.

Again, you misunderstand.

The problem is not whether or not to run the tests in parallel.

The problem is that our tests take an insanely long time to run. That is a
big problem, it is no good, tests are only useful if they are cheap enough
to run all the time.

So the only thing that would really count as an improvement would be to
change the test suite in such a manner that it relies more on helpers in
t/helper/ and less on heavy-duty shell scripting.

Of course, if you continue to resist (because the problem is obviously not
affecting you personally, so why would you care), I won't even try to find
the time to start on that project.

Ciao,
Dscho

P.S.: After increasing the time-out to 240 minutes, the test suite still
times out. I investigated a little bit and it appears that
t6030-bisect-porcelain.sh now hangs in the `git bisect next` call of its
"2 - bisect starts with only one bad" test case. This is specific to
Windows, I cannot reproduce that problem on Linux, and I will keep you
posted on my progress.
