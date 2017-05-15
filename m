Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0534201CF
	for <e@80x24.org>; Mon, 15 May 2017 08:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbdEOImc (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 04:42:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:51530 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933113AbdEOImc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 04:42:32 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lfolq-1dmFLc0Q5S-00pLn5; Mon, 15
 May 2017 10:42:26 +0200
Date:   Mon, 15 May 2017 10:42:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/
 for good
In-Reply-To: <xmqq7f1l6as6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705151022160.146734@virtualbox>
References: <cover.1494509599.git.johannes.schindelin@gmx.de> <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com> <xmqqfuga5lp2.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1705121617420.146734@virtualbox> <xmqq7f1l6as6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LtItpw+EdZBHEjqSxt+gt/m9WvBrXOaAP0BLekvvuLiq7Fj9lWc
 oD3VXm7X7ZCvkBQM15y5bLZGjepc/y7A38H9aTWOLxi34TBb1U4ZaakCmANuXG9K1evOo/f
 TppfcH9grgKoTRf6u9Amwq3ntd3whg2x2pyygxgEg36AruBtRQjbzRopWhgjpLDvQq+ijwB
 FuQX5iW4jtiLtUDguZfPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RFf76Lar1Wg=:D6WJjOJMSRfs1dR5zct50+
 UTlRFUc2Gmsq4d0n4QNM3Zc3KAmYd5DhZ69RoVw6ei+cgGKRGV4/FCc5SUg+0nh0khYOuiB2u
 lyJn8tS7SWBFGCRJGj3wBPT8RAPix+WN6BNmWsFdVwOq5o6/eyX536RqUQS72MadqztX0umhH
 MNxwtI0OBQUMg1aQi3D2yGTZQg0LRCuzd36xpfaUI0TKsvEcHB2qmUpBqV7IuwsI9UNbhdJ0v
 8lbMZ+Cg098NFGZCtoVEct6f7F8xBI4tfAMHegykkNVXCkvuUiAjr05j2N57PlkRYpCDJjJdt
 nkvOmPDGo+vcUFUYx/zhjcUCi6C2ql88NZkigacizj8icAL8UhtE0rMTIWclN2B5cCAA2QKGR
 UcNfxCfLIb9xVw6J7+GVALkKlgGGfCCmXbN7+gGNmIptpUfs+NvGd5QSlPo3/mNoe0HZrvinE
 pb6ucIsMBn4NKf1c4m0scnm5M/E8mZixw5XZ3dkEjn6EN2LqYgePvD8sSl/D1RV8EU04n2gjF
 yfeS50qf/G63Y6NyKLzmBEJnRZl5n3w8imOLFgY3J7TSrOV+0yH92OVYCpfqwmSS/VQ6y+iMt
 FsjXstB8U/hWyowH/2NIXqVibgLfoGM01H390n2lI2+UyMXbum0joN0mFwlXN2tzky3DsrPrN
 VcIc1E04saM4wgzzJVU5nxbn7b2K3fBeo/B4Z8wT4YHopB9hv5seTPXPJAq0/7vuDOeo1WOGf
 xo3cIT1sKSlt20KAh6quSA5r4pbxBntbplJG7Id4vd7KtMagdYRz5rCpnqRJeNbgZfm+4YpQ7
 +Shsvv1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 13 May 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 12 May 2017, Junio C Hamano wrote:
> >>  ...
> >> FWIW, I do not think there is any reason for people to be using
> >> .git/remotes/, but for .git/branches/, I do not think I can offer a
> >> more efficient and easier to use alternative based on .git/config to
> >> do these things:
> >> 
> >>  $ grep <substring> .git/branches/* ;# what did I call that remote?
> >>  $ cat .git/branches/$name ;# where do I get that from?
> >>  $ echo "$URL#$branch" >.git/branches/$name ;# I just learned a new src
> >>  $ rm .git/branch/$name ;# I no longer need it
> >> 
> >> without having to learn things experienced CLI/UNIX person already
> >> knows.
> >
> > I do not understand what you want to tell me with that example. It is
> > confusing me utterly.
> 
> They show how it helps a user, whose primary use of Git is to fetch
> from many places, to keep the the old "branches" machinery.

M'kay. Not quite sure how that differs from my use case, which works quite
well with the "config" way. My `git remote | wc -l` says 21.

Let me re-format what you said next.

> It is not "hard" to migrate in the sense that there is a way to
>
> (1) find the short-name you gave to a remote from a part of URL etc.,
>
> (2) find the exact attributes of the repository a short-name refers to,
>
> (3) update an existing or add a new short-name and
>
> (4) remove an existing one.
>
> The remotes.*.{url,fetch} configuration are expressive enough to
> represent these operations.  It however is more work and I couldn't
> think of alternatives.

So if I understand correctly, you want to do

(1) `git remote -v | grep <part-of-the-url>`

(2) `git remote show <shortname>`

(3) if (1) did not find it:
	`git remote add -f <short-name> <URL>`,
    otherwise:
	`git fetch <shortname>`

(4) `git remove rm <shortname>`

I have to admit that I used `git remote -v | grep ^<shortname>` for (2)
all the time, until I had a quick look at builtin/remote.c so I would not
make a complete fool out of myself in this reply, and I will use `git -p
remote show <shortname>` henceforth.

As to (1), I really do not use this myself, as my remotes pretty much
always have names that I remember very well. And if I don't, neither do I
remember the URL, so I have to sift through the output of `git -p remote
-v` manually anyway.

> >> We simply cannot beat the above with anything like 
> >> 
> >>     $ git config remote.$name.fetch refs/heads/$branch
> >> 
> >> even though the config based remote definition may be infinitely
> >> more powerful.
> >
> > Then maybe we need to teach, say, `git remote` to be that powerful?
> 
> Ah, after all, you weren't confused utterly.

No, I was, and I am still at least partially confused. I just read your
"We simply cannot beat ..." as a round-about way to say "I wish we had an
easy way to do XYZ" without stating the XYZ in a way that even dimwits
such as myself can understand.

> Not necessarily "that powerful", but yes, if we had something that
> is quick and easy to use as a replacement, I do agree we can plan
> .git/{branches,remotes}'s removal.  The point of "branches" thing to
> existing users, I think, is not its expressive power (it is much
> much simpler and can do only one thing) but its simplicity.

Okay, so my quest at removing maintenance burden is not entirely pointless
an exercise and a waste of my time.

Good. I will continue to work on that front, then, among other things.

Ciao,
Dscho
