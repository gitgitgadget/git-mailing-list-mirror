Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51E920986
	for <e@80x24.org>; Tue,  4 Oct 2016 22:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbcJDWdp (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 18:33:45 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:55506 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672AbcJDWdp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 18:33:45 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1brYH4-0001oG-00; Tue, 04 Oct 2016 22:33:22 +0000
Date:   Tue, 4 Oct 2016 18:33:22 -0400
From:   Rich Felker <dalias@libc.org>
To:     James B <jamesbond3142@gmail.com>
Cc:     musl@lists.openwall.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
Message-ID: <20161004223322.GE19318@brightrain.aerifal.cx>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <20161005090625.683fdbbfac8164125dee6469@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161005090625.683fdbbfac8164125dee6469@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2016 at 09:06:25AM +1100, James B wrote:
> On Tue, 4 Oct 2016 18:08:33 +0200 (CEST)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > 
> > No, it is not. You quote POSIX, but the matter of the fact is that we use
> > a subset of POSIX in order to be able to keep things running on Windows.
> > 
> > And quite honestly, there are lots of reasons to keep things running on
> > Windows, and even to favor Windows support over musl support. Over four
> > million reasons: the Git for Windows users.
> > 
> 
> Wow, I don't know that Windows is a git's first-tier platform now,
> and Linux/POSIX second. Are we talking about the same git that was
> originally written in Linus Torvalds, and is used to manage Linux
> kernel? Are you by any chance employed by Redmond, directly or
> indirectly?
> 
> Sorry - can't help it.

I don't think the hostility and sarcasm are really needed here. But
what this does speak to is that users don't like feeling like their
platform is being treated as a second-class target, which is what it
feels like when you have to manually flip a switch to make git build.
This is especially unfriendly when the semantics of the switch come
across, at least to some users, as "your system regex is incomplete"
rather than "git can't use it because git depends on nonstandard
extensions".

Rich
