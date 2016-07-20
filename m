Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 279C41F744
	for <e@80x24.org>; Wed, 20 Jul 2016 12:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbcGTM3L (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 08:29:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:63084 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527AbcGTM3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 08:29:09 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MBnvD-1bWgMh1B8J-00ApSa; Wed, 20 Jul 2016 14:28:32
 +0200
Date:	Wed, 20 Jul 2016 14:28:07 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	David Lang <david@lang.hm>, Herczeg Zsolt <zsolt94@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <CACsJy8D1RtwVF4ZtRHV2Z=huTqRBp8Du5GMZq9qxwXDZezBF2g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607201428030.14111@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com> <20160717154234.GC6644@vauxhall.crustytoothpaste.net>
 <20160717162349.GB11276@thunk.org> <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com> <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
 <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com> <alpine.DEB.2.20.1607190910370.3472@virtualbox> <CACsJy8CSUu=AemQ-7uxth_2M=ko_KDGsdObwYdiE=L4OMKcVZw@mail.gmail.com>
 <alpine.DEB.2.02.1607191032270.25425@nftneq.ynat.uz> <CACsJy8Bvqt9r2dRtRfx1C-3Fp16z3SJ=hp0i7-itwFwfEfZwTw@mail.gmail.com> <alpine.DEB.2.02.1607191057170.25425@nftneq.ynat.uz> <CACsJy8D1RtwVF4ZtRHV2Z=huTqRBp8Du5GMZq9qxwXDZezBF2g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M5K3i3oDP9VZq8Ct7jdgJ8YjljujsLMmFUzNLhHDEgUHOkcpeew
 vi7trcmFms6f2xYx0gHj0KLYOhzgGQ5o7peorZI3LLEkg9v++uJ1OosjAl+fthuB5/cAMU0
 UvP9sysi6kwpyDMTyfOkQ4cL0/5x+U7YxxiRVNxAqxldVoWYodfAgVBzrZN8jySJ3WYLEE2
 MMlDFF8DWwajvcbvtCDsg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:LzJIfdWBCpI=:/N7P7wX2t6i3NBJ3qTBuFC
 tlpzlZoCXF+GCp8vKt9b7mVoaEcYdfWDsJfzy4Bx0Mtq3MArxIYcZvfrw2SavlZHlB1ZQHJjs
 Zi5FMcqqkKjGuLhKpsRQsw8/Hb+U/In3SL+43yDIVf/A+bW567zAY4uRmFDUltILki6MTkbmD
 NYaTqIK5ewIO89Uzw/hd6J3Vzk8oCAg5hVxJ4wlLs3mzvkVLTHM0sCxn60josAM5ZWyWCZYK4
 8ZhmZcY9YDo7q1htcZSI27FJD9s26iLKOG6w3/gKrL5LhCvX0Cgep32HGyTwdMbELJZBFufqF
 02/t9tM7bT7C+YsZC/fVPe0kFa5MZiK6RMRwF3sTcGaWdw9QST1RRA0AtuvT114O5tLczA6tN
 gidq4BFQ3cK4DxgQJqyhOueN12j5IQHOPalUqz1nSBiVVmnHPZ3edRg7ljk0dYWw6guanm+WD
 qHz59/W+e2BjiZDnUObKTGf6jp6KS0vybtY0s7Gs/1ftPzNRDjU77IaDmMRdlf41+8jOy0qDW
 4+lF4SD9TLpeXqzpP7o9+Lvf8RUJ8OtXFRC2xkP2KqXbeBtBmpK+13ex+oQN9a6BBfHsQcMHh
 xkEmfx2rdJXg0USLGHMT1pG+E+pvSruEyWDVxpaa72FtqB5JVoJLcdAWeyGmHrdWKnAD/l+Y7
 CfM+IVv9V6+Bh4PB/2BcuOm9PAkkoMwaDE0aIAgFkLoGGBu7doYIEjEPYzNFiiBMTSwKMDC3S
 ykkhKH9O0CCq5MEssvw9fWJHZp5t7NJtZ2mIeKdv3+xi+8g22NziUuTAv14TJ0IyKhrngEbwq
 7tTm9RD
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Tue, 19 Jul 2016, Duy Nguyen wrote:

> On Tue, Jul 19, 2016 at 7:59 PM, David Lang <david@lang.hm> wrote:
> > On Tue, 19 Jul 2016, Duy Nguyen wrote:
> >
> >> On Tue, Jul 19, 2016 at 7:34 PM, David Lang <david@lang.hm> wrote:
> >>>
> >>> On Tue, 19 Jul 2016, Duy Nguyen wrote:
> >>>
> >>>> On Tue, Jul 19, 2016 at 9:18 AM, Johannes Schindelin
> >>>> <Johannes.Schindelin@gmx.de> wrote:
> >>>>>>
> >>>>>>
> >>>>>> But we can recreate SHA-1 from the same content and verify GPG,
> >>>>>> right?  I know it's super expensive, but it feels safer to not
> >>>>>> carry SHA-1 around when it's not secure anymore (I recall
> >>>>>> something about exploiting the weakest link when you have both
> >>>>>> sha1 and sha256 in the object content). Rehashing would be done
> >>>>>> locally and is better controlled.
> >>>>>
> >>>>> You could. But how would you determine whether to recreate the
> >>>>> commit object from a SHA-1-ified version of the commit buffer?
> >>>>> Fall back if the original did not match the signature?
> >>>>
> >>>> Any repo would have a cut point when they move to sha256 (or
> >>>> whatever new hash), if we can record this somewhere (e.g. as a tag
> >>>> or a bunch of tags, or some dummy commits to mark the heads of the
> >>>> repo) then we only verify gpg signatures _in_ the repository before
> >>>> this point.
> >>>
> >>> remember that a repo doesn't have a single 'now', each branch has
> >>> it's own head, and you can easily go back to prior points and branch
> >>> off from there.
> >>>
> >>> Since timestamps in repos can't be trusted (different people's
> >>> clocks may not be in sync), how would you define this cutoff point?
> >>
> >> The set of all heads at the time the conversion happens (maybe plus
> >> all the real tags). We can make an octopus merge commit to cover all
> >> the heads, then it can be the reference point.
> >
> > so to make sure I'm understanding this, anything not reachable from
> > that merge must be the new hash, correct? Including forks, merges, etc
> > that happen from earlier points in the history.
> 
> Yes everything except that merge and everything reachable from it, the
> whole old clone, basically.

But that strategy *still* ignores the distributed nature of Git. Just
because *you* make that merge at a certain point does not necessarily mean
that I make it at that point, too.

Any approach that tries to have one single point of conversion will most
likely fall short of a solution.

To be honest, I am less concerned about the GPG-signed commits (after all,
after switching to a more secure hash algorithm, a maintainer could
cross-sign all signed commits, or only the branch tips or tags, as new
tags, to reinstitute trust).

I am much more concerned about references to commits, both inside and
outside the repository. That is, if I read anywhere on the internet about
Git having added support for `git add --chmod=+x <file>` in 4e55ed3 (add:
add --chmod=+x / --chmod=-x options, 2016-05-31), I want to find that
commit by that reference.

And I am of course concerned what should happen if a user wants to fetch
from, or push to, a SHA-1-hashed remote repository into, or from, a
SHA-256-hashed local one.

Ciao,
Dscho
