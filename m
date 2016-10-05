Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87732207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 10:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbcJEKmT (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 06:42:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:57499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752319AbcJEKmS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 06:42:18 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LhwAY-1b5llQ19Ag-00nDGy; Wed, 05 Oct 2016 12:41:54
 +0200
Date:   Wed, 5 Oct 2016 12:41:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     James B <jamesbond3142@gmail.com>
cc:     musl@lists.openwall.com, Rich Felker <dalias@libc.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
In-Reply-To: <20161005090625.683fdbbfac8164125dee6469@gmail.com>
Message-ID: <alpine.DEB.2.20.1610051231390.35196@virtualbox>
References: <20161004150848.GA7949@brightrain.aerifal.cx> <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net> <20161004154045.GT19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <20161005090625.683fdbbfac8164125dee6469@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6UqjtsqO7Jrejb/mtkHff+EqZAwVEgBLBYbtS8t2chCrjiRMChU
 SYvEKLbgI2I9/kNLXViOHKTAWhp66bjp4jnCjYaBAA/sH2AFh7jGIguBL+ncvyIdWMZPnHE
 kMTBFA9wgF/KZHRjupDuR70c3GfodA+EwgCqvi0V0H+EZS0uB3NE0uc/ySK3i5oH9B+9pMs
 LgJ0RT5JL7JrC9Aafq4ww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0soL5ibVg8o=:0E19+iBgBL/RDnRIdFM67M
 VFQQNwopQ+wZdowzZiu6Mn+jt+FMThdI5xG+taiIAk618XH6s+TO4y3SfWHZfaKjaV+swIkqE
 sFkQO+tx1irsfpB8wh/FRfKg3G6HiZMFVj8XQkNOsvINCMY+eP+vttxrChcTOfNZipl+tjlRA
 f1hzZDSrjg3gujZcmvZRXMKFKX65KGN6uhrIwR/6WoCL7PL6fM0p+ywuPh1vW5nOICQzjf6BB
 302PsYG6QeJRxFU4kBjEhQ+HzAsEzWKBl7cSEgkW4FNjlEkkq7H5nlDnxv+RHJFCLxfenU7i4
 JS15ft+nl+fXNtk90+wmpneTUT2ucWEA4WR4sGkGx+9bzQTNtoi1Sc6SgeNh/bgHlBzvqArg7
 RjvfBjA8lMbtGdkm8yJ9H65wVIIJDPh1TTq+o+oZl8LMtoicBqvjCA3faVbqthoVGaje9FWh6
 hek1tNfXonOp1LEWUR/SlSaa4Uw6fKE1k68oMIf3Jg//TmJYTmTcgyJiOvmvaEkZ5nsnwTz25
 YCVdBlJpBcoLZy9amskQ6fRkG9peHWarZ3e73pJzgLV0D4wFRTmg5+HCFE3Bum2hryZu40w4I
 OoYobqtdzB4D1mghgIH5YIMIdEFDlQif0096JCk+ffKQFUTwAwpi0D0BLrnbZ5RqvCmfENTfA
 0fCIf6pvHykVgVpb+OSCPsWMXp7luqpV+b88P09lBRqInDOpLJmmGB10W3R7IiXVY0sWNaEwD
 2TKzF1aZVKhQmh9GLWTxnmwM0gsUT7Gd2hyJBXn7XUwqi27LL1FKQWfbe0LggT+lsBWVtwuOp
 7AQF5M/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi James,

On Wed, 5 Oct 2016, James B wrote:

> On Tue, 4 Oct 2016 18:08:33 +0200 (CEST)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > No, it is not. You quote POSIX, but the matter of the fact is that we
> > use a subset of POSIX in order to be able to keep things running on
> > Windows.
> > 
> > And quite honestly, there are lots of reasons to keep things running
> > on Windows, and even to favor Windows support over musl support. Over
> > four million reasons: the Git for Windows users.
> 
> Wow, I don't know that Windows is a git's first-tier platform now,

It is. Git for Windows is maintained by me, and I make as certain as I can
that it works fine. And yes, we have download numbers to support my claim.
The latest release is less than 24h old, but I can point you to Git for
Windows 2.8.1 whose 32-bit installer was downloaded 397,273 times, and
whose 64-bit installer was downloaded 3,780,079 times.

> and Linux/POSIX second.

This is not at all what I said, so please be careful of what you accuse
me.

What I said is that we never exploited the full POSIX standard, but that
we made certain to use a subset of POSIX in Git which would be relatively
easy to emulate using Windows' API.

> Are we talking about the same git that was originally written in Linus
> Torvalds, and is used to manage Linux kernel?

It was originally written by (not in) Linus Torvalds, and yes, the Linux
kernel is one of its many users.

Git is not used only for the Linux kernel, though, and I am certain that
Linus agrees that it should not cater only to the Linux folks. Git is used
very widely in OSS as well as in the industry. So we, the Git developers,
kind of have an obligation to make things work in a much broader
perspective than you suggested.

> Are you by any chance employed by Redmond, directly or indirectly?

I am not exactly employed by Redmond, but by Microsoft (this is what you
meant, I guess).

I maintained Git for Windows in my spare time, next to a very demanding
position in science, for eight years. In 2015, I joined Microsoft and part
of my role is to maintain Git for Windows, allowing me to do a much better
job at it.

Of course, I do not only improve Git's Windows support, but contribute
other patches, too. You might also appreciate the fact that some of my
colleagues started contributing patches to Git that benefit all Git users.

> Sorry - can't help it.

I do not know why you are sorry, and I do not believe that you have to be.

Ciao,
Johannes
