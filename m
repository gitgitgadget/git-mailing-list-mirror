Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77C0207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 16:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753712AbcJLQYr (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 12:24:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:54040 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753422AbcJLQYq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 12:24:46 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LrqNe-1aqxRo2IVq-013gWS; Wed, 12 Oct 2016 18:24:38
 +0200
Date:   Wed, 12 Oct 2016 18:24:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Joshua N Pritikin <jpritikin@pobox.com>
cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: interactive rebase should better highlight the not-applying
 commit
In-Reply-To: <20161012132740.dvyofl36qtualxgk@droplet>
Message-ID: <alpine.DEB.2.20.1610121815160.197091@virtualbox>
References: <20161011190745.w2asu6eoromkrccu@droplet> <CAGZ79kZSQx7aOCgQ2dwzJeCLX-k-+x1SKabEBG7CktNfeXAbvg@mail.gmail.com> <20161012132740.dvyofl36qtualxgk@droplet>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mgZF0EOUJ6z6h1TA8HHJrO3nO+lEM+OXVH8xCOf8CfCemgnwwiA
 9rZR5ZBZu6cwzUU/AFAeHeGvWb3EUgoibCHgF2RPRBji2pv5P3P7tAtIjWxfeCKhOyrt/F8
 zb3k28e8NUVVr37XvSomLb7yTo5UT/WdXMQyUehou44wVqEW5MK/xrFd4d66bI+kqWe3k5D
 /Ht/C2kscDrXQKCek4kMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5Aq3u3FwBp8=:uTawJehYBr/kES4FeobX8q
 wHgfNspgAuBBuwpDnkKUJe12ck7h86rMWYDrhBb9+y83ak7i1t9SFahlz0AUAMrIJ3jnzCMWg
 svYpEcdvORHLo0PQ17bVT3sSawiWg8yVC08hAPTjDNG8Xzf6sUPSiEzOQJ+0HkG3SSbJFMeCP
 +2Sc6cQuwhBYgmYBvS0CZW+y57iSqjKCYiPitB/fxPOLCamCd4VtZXPONx0LQWhyFGXRZWcZo
 2DzcoEy5Of78FjXteVCGMV4WoHLsPkDDu7PtMKf27qkrS5Xy0puRHZOMLs3ho6ph9NNCDmAQ2
 z54mRQywJAMvMV+10T8NGh32a9oa71SZbC9gR8yaUFcxrIHHjYIMCckDbuev3IigTBVnNV+NR
 mCQWoCR9WO1LyGgL9lTnuwFFhQThIwDk3lj7kUH4QX1lRayk0kh7+0BUoOF0h/1xpMv3O2lyD
 uRwPukXpmrazW/qjF2DxRQ8RBtnpl6CuaPpYD224olZZx8DGGhitmZYlRXpfKZ6+j352kQqW2
 hVU6GR8ZsliwvY1uK635u7OfKg9Zyzqf3+KYdqOp7dfnZBEKzQ/GSC5bZOHkl/6ZIIhUlt7Yb
 4aw2ArxN4mKsFRQ/IO4T1ApX47G5i6nXfXk0R3n2O1khyIsj2gYGI1ybMWn2olwN3fFzh2Bzo
 H0AgK1Bw7MR3CFNJaB7kTaPUrxqD95JfjX6XI7BQoaacPurZJ3tA6/0vKzFZ2FCE1wZ/z6NBm
 Qfdma2opsZ2Iy9s7EaM5MI2M1SVWtGvq/DDiRVeeaq+aNLayX/b8y0Omu+xDmQMWIbI6TnZin
 kCi2wE4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joshua,

On Wed, 12 Oct 2016, Joshua N Pritikin wrote:

> On Tue, Oct 11, 2016 at 01:55:22PM -0700, Stefan Beller wrote:
> > On Tue, Oct 11, 2016 at 12:07 PM, Joshua N Pritikin <jpritikin@pobox.com> wrote:
> > > I assume somebody familiar with GIT's code base could make this
> > > change in about 10 minutes.
> >
> > Can you elaborate how you come to that estimate?
> 
> Hm, a false belief in the general awesomeness of GIT developers?

No, a false belief in your own shortcomings, as you thought it would be
easier to address your wishes for somebody else than you.

> On Tue, Oct 11, 2016 at 02:25:19PM -0700, Stefan Beller wrote:
> > On Tue, Oct 11, 2016 at 12:07 PM, Joshua N Pritikin <jpritikin@pobox.com> wrote:
> > > As of GIT 2.8.1, if you do an interactive rebase and get some conflict
> > > in the stack of patches then the commit with the conflict is buried in
> > > 4-5 lines of output. It is visually difficult to immediately pick out
> > > which commit did not apply cleanly. I suggest highlighting the 1 line
> > > commit summary in red or green or some color to help it stand out from
> > > all the other output.
> > >
> > > I decided to suggest this change after I realized that I probably
> > > skipped a commit during an interactive rebase instead of resolving the
> > > conflict. I knew I had to skip some commit so I assumed that I just need
> > > to skip without reading the commit summary carefully. Now it is 7-15
> > > days after I did the erroneous rebase. I had to spend a few hours today
> > > with GIT's archaeology tools to find the lost code.
> > 
> > Looking at the actual code, this is not as easy as one might assume, 
> > because rebase is written in shell. (One of the last remaining large 
> > commands in shell), and there is no color support in the die(..) 
> > function.
> 
> I'm sorry to hear that.
> 
> > However IIUC currently rebase is completely rewritten/ported to C 
> > where it is easier to add color support as we do have some color 
> > support in there already.
> 
> Sounds great. Is there a beta release that I can try out?

There is no release as such, unless you count Git for Windows v2.10.0.

But you can try the `interactive-rebase` branch of
https://github.com/dscho/git; please note, though, that my main aim was to
be as faithful as possible in the conversion (modulo speed, of course).

> Also, I have another wishlist item for (interactive) rebase.

Hmm. You know, I cannot say that I am a fan of wishlists for Git, unless
the originator of said wishlist takes on their responsibility as an Open
Source user to make their wishes come true.

But maybe I read it all wrong and you do want to make this happen
yourself, and you simply want a little advice how to go about it?

> Sometimes I do a rebase to fix some tiny thing 10-15 commits from HEAD.
> Maybe only 1 file is affected and there are no merge conflicts, but when
> rebase reapplies all the commits, the timestamps of lots of unmodified
> files change even though they are unmodified compared to before the
> rebase.

Well, they *were* modified, right?

A workaround would be to create a new worktree using the awesome `git
worktree` command, perform the rebase there (on an unnamed branch -- AKA
"detached HEAD", no relation to Helloween), and then come back to the
original worktree and reset --hard to the new revision. That reset would
detect that there are actually no changes required to said files.

> Since the modification times are used by 'make' to compute dependencies, 
> this creates a lot of useless recompilation that slows things down. It 
> would be great if rebase only changed the timestamps of files that were 
> actually modified.

Rebase will always have to change those timestamps. Because it really
changes those files. So the mtimes *need* to be updated. As far as rebase
is concerned, it does not matter that the final contents are identical to
*some* previous version...

Ciao,
Johannes
