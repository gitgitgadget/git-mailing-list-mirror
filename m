Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5123C1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932947AbeGIU1C (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:27:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:53343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932686AbeGIU1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:27:01 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAgzj-1fmqI80z0t-00BuVS; Mon, 09
 Jul 2018 22:26:55 +0200
Date:   Mon, 9 Jul 2018 22:26:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Paul Smith <paul@mad-scientist.net>,
        Daniel Jacques <dnj@google.com>, git@vger.kernel.org
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
In-Reply-To: <20180709195822.GA9000@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1807092225120.75@tvgsbejvaqbjf.bet>
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net> <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet> <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net> <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
 <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com> <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net> <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet> <20180709195822.GA9000@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:buYjsqCIYMMW/uyvNyAYta1BJYqF0LWX3Dpk+MITFhJ5UaaOXS1
 TovCUeyO1yuEq//S8CBDXWpMWP1IOtd5WQ0zdvs7Vr/O+M+kuX2xL9SSKJxNPcjZdpa8VmN
 kskHxMC3FvLcasZDU/SGpy5I/0P1Tj6QZxPi8dc35fzEH0pUZnE6vDbt66wpSENSnXgGX8J
 2JNe5V2SNyS7SkKvjkomg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EW/0zm0MZ5Y=:XsrTUgIL2T0iY7ZqwLbnQD
 0GcmQqefP1nWFojRzXlcK9NDJ6ilIDVhl1hi4vfCUWLRt8dZHAvpp3V2nzqSUuKt4nx9MBgeb
 IPPmFTTnDjdkThgnl5hMvTyzLN5eSCIuFhguHXjlCMwBzlLPORttULZyG1e2wSWcY1P5r+A86
 hWT2U/vVbA4xIUpKjlWnqIoh6fMDIrqnEcVk3D53iXgkoIBRXYW2+48d9dWMNRSHiz1R3TC7k
 s3NbU6OqLvuxV28ridOvMcBVehlCQcLZwm8PIwf45H5/PM21WN6B3dhcsED4x8iZ99sJNaF4C
 kURefm6QWFWpTciIFJI6dQCYmdeGgFQcOJwMVT9hO1T+566HGhWDaJ7/C3WYZqzcWlZUZMYsO
 w9o5M4Pmjaisr+NHjhSzJWzRr4j5lkYmNrKcbrfoF7aIma7aHYabTnVCGG1IoBdm1PWhVxJB+
 eKB+YUabvl5t0hAM2WTp6i7PpsRm81/OxsoFodW90pnNwMyzS4I0DurF6eTAdjVPgEj2uiZNy
 eNFOZ/8lQRPLBVr3Tux7I9KQ1yAznaCV5lVR849E4DxCajMJCmpDZB6VK88jF1mYC59fQGhzA
 BzfxgxjCCPHnzAo2MjIJ/n9Bm4C7udlperWTBHA8mksaoOZYX45H4D6yah2Ecn5/tZr8+vsTI
 AB/uJb0pWUQq4XGF2eSRjf1G+9aZk8rKQ9M3mmKAPRBQEZTuEiNZmJcq6vTZzs3FjtTCf/l7i
 hlA6/RCPRKCrTLPOEVikkzSWWHQ5r3sVP+/Wc4PBqs4VZSuYPNJFubJi+nZtqUEGB+mQwO57s
 xsC8lUF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 9 Jul 2018, Jeff King wrote:

> On Sun, Jul 08, 2018 at 11:52:22PM +0200, Johannes Schindelin wrote:
> 
> > Now, if you care to have a look at Dan's (and my) patches to implement
> > RUNTIME_PREFIX so that it looks for a directory *relative to the Git
> > binary*, you will see that it is far from portable. In fact, it is very
> > definitely not portable, and needs specific support for *every single
> > supported Operating System*. And while we covered a lot, we did not cover
> > all of them.
> > 
> > So unfortunately, it is impossible to make it the default, I am afraid.
> 
> Would it be reasonable to make RUNTIME_PREFIX the default on systems
> where we _do_ have that support? AFAIK there is no downside to having it
> enabled (minus a few syscalls to find the prefix, I suppose, but I
> assume that's negligible).
> 
> I.e., a patch to config.mak.uname (and possibly better support for
> _disabling_ it, though I think "make RUNTIME_PREFIX=" would probably
> work).

The obvious downside is that we would be a lot more likely to break one
side of the equation. At least right now, we have Git for Windows being a
prime user of RUNTIME_PREFIX (so breakages should be caught relatively
quickly), and macOS/Linux *not* being users of that feature (so breakages
in the non-RUNTIME_PREFIX code paths should be caught even quicker). By
turning on RUNTIME_PREFIX for the major platforms, the fringe platforms
are even further out on their own.

Ciao,
Dscho
