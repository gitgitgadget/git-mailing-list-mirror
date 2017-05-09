Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A7A1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 12:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbdEIMco (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 08:32:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:60842 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751873AbdEIMcn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 08:32:43 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfRnb-1dNnkz2nyV-00P7nP; Tue, 09
 May 2017 14:32:38 +0200
Date:   Tue, 9 May 2017 14:32:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Script to rebase branches
In-Reply-To: <20170509110249.eluxns2zz5jqh42k@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1705091418540.146734@virtualbox>
References: <8D018370-79F9-450F-97AF-31EF4C95BA44@gmail.com> <20170509040943.j3n5li7fapiuvgbj@sigill.intra.peff.net> <alpine.DEB.2.21.1.1705091244420.146734@virtualbox> <20170509110249.eluxns2zz5jqh42k@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:i420QHPzKoO+K22sb+gpVStbmP+b4ot4Snh4gm9kCfaQQw63DHX
 LZSEJ0TeeI9Ky2EvneANylu7clAaXCwLEkU60LaLfqqoElAK2vWxGOdibhI0SV+DpFJQOg0
 T0XMs7+HV8xOmWttNWFQTC8+5OWIbZU7fkwllETyg+LSIMpNjCbFMDm9adfMJzFMQYSlK4Y
 kk4vIgBXmF2xUvpaPLsSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:08A/5DFP4ao=:LGkYUDiGPF58qoFOR9Gn8u
 +z5qVHeTiM6WKZAVNVWArTMcqnRp2CthE+8eUF6dtXe6rOkp6KU8tZwmzXdSxG1bpgXop/WIx
 HmTuE9W1ZT6jUJrdO3qOAevAiNY1grXX7tutYxTBUWVCTq0X3rvRtZY3UZ3imIIdgq/YqLA7F
 mH5uch68O68/qErS2YXRkTfstf7NdJNd46sN8bxKjy2Raq4y9Hlz3+uwkL1fjhgGcMIF8Wkxr
 gsHU0WIZIzkowBTaXzBg4FzBQbM5DKRGXRz4iEizuGPM8/6IcDYhBd97aNkUJ5iMPw2+3+fS4
 oYdj2qIE00f3ZMqFwRqPCmzGlfvN3vuB9ni4DNscqiFoKIyoYv3GKZHcIuyy9uut87q53ar8f
 LQCMAGxAP8+Bddqr8Rxv60lJJsnc3snOzw28I96Hlkbv/1U5iVBE8im7Oxyk3DrYb3f6h2LMU
 Y7ITZrdIn9pjINGVLnXDfz4Hdm4jZmGhyto+gB95gsBJLku6JLT10eg96Ic5mEwqWhJ4uIuEP
 qhesA4dYrHzxUZOjuPRD8tOo37X/Bym4C2Fpj6Fi52xvkrHdMduFERyKhJILExEg55JOwxIHi
 Kk9jQi4MuToeOPsRbNsUL04r1qDxKV71Zdilvb7jAe2+PTcw+4CKMRySRjMV5OtFhSyTlyDI/
 3576vKxj9y0z+DiuKz/Qq46RDgDu8i4TwI53LwrpGTb3TdjjvkZjL5tcZNxhWa3CYesQNSOSv
 NImLw1duF2tPi50CeWTrbXhAYNGedycUUd98D+KHkITWs1bhVqhiX1xE8MagQfPPm0uSiLOoV
 4GoEBp8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 9 May 2017, Jeff King wrote:

> On Tue, May 09, 2017 at 12:50:22PM +0200, Johannes Schindelin wrote:
> 
> > > This is what I use:
> > > 
> > >   https://github.com/peff/git/blob/meta/rebase
> > > 
> > > There's no documentation in the script, but the commit message in its
> > > history should give a good sense of what each part does.
> > 
> > That requires Meta/ to be checked out and up-to-date. I'd bet there are
> > exactly two people who fall into that category.
> 
> Actually, it is not Junio's Meta that needs checked out, but rather the
> "meta" branch where you will find that "rebase" script.

Oh, okay, I misunderstood that part, indeed.

> If other people find them useful, the set of scripts could perhaps be
> transitioned to a namespace that is appropriate to go into people's
> $PATH.
> 
> I didn't really expect anybody to use it verbatim, though. I was
> providing it more for inspiration.

I deem it part of Git's mission is to avoid forcing everybody to write
scripts so specific to their own needs that they cannot be shared easily.

There are lots of parts in the interactive rebase, for example, that I do
not want to use myself. But enough users do to make it worthwhile to
support in Git proper.

Likewise, I assume that most developers work on one topic branch at a
time, until it is submitted as a Pull Request, and then move to the next
topic branch after the previous has been merged. But there are enough
users, I'd wager, including both you and me, who need to work on multiple
topics in parallel (for a plethora of reasons).

Certainly there will be more developers with the need to rebase multiple
branches at once than there are developers needing to send patches via
mail (and we support the latter operation with several top-level Git
commands).

And that makes me believe that there is enough need for multi-branch
operations that we should consider supporting them out of the box.

> > Also, I see that you do not use worktrees. Otherwise your script would
> > fail.
> 
> Yes, the script predates the invention of worktrees by several years. I
> have occasionally played with worktrees, but don't use them extensively
> (I'd usually use them for a one-off change, and then remove the
> worktree).

I assumed as much, and I did not mean to criticise you for it. I was just
pointing out, implicitly, that the script has room for improvement to make
it applicable to a broader audience.

Personally, I am a heavy user of worktrees, and once the vexing bug that
corrupts them by gc'ing in-use objects away.

I kind of use them not only for developing the topic branches (as you
know, my patch series frequently see many iterations and many weeks going
by before they hit home), but also as kind of a Pensive, where I keep
things I want to work on but do not have time right now. Some of my
worktrees are both: they are topic branches in flight, and also remind me
that a certain topic was not yet accepted.

> > When I still hoped to be able to get the rebase--helper related topic
> > branches in by August last year, I had grandiose plans to teach the
> > sequencer not only to perform the Git garden shears' trick (i.e.
> > recreate merges), but also to optionally update local branches
> > corresponding to the merge commits, including updates to the worktrees
> > that checked them out (if any).
> 
> I don't think I need anything that fancy. But simply checking "is this
> checked out in a worktree" for each branch and then doing "cd
> /path/to/worktree && git rebase" instead of just "git rebase $branch"
> would be enough, I think.
> 
> (I'm assuming the problem you see is just that the directory running
> Meta/rebase cannot check out a branch that is checked out in another
> worktree).

I understand that you do not need anything that fancy. And you probably
understand that I was not talking about your needs only, nor mine. I was
talking about a broader audience of power users with the need to work on
multiple branches in parallel, to automate things in order to make work
more fun.

Kinda like Git, you know?

Ciao,
Dscho
