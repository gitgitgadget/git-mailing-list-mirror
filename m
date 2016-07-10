Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F721F744
	for <e@80x24.org>; Sun, 10 Jul 2016 10:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbcGJK7b (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 06:59:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:64894 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbcGJK7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 06:59:30 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MJWAZ-1bO7CE3bAZ-0032kq; Sun, 10 Jul 2016 12:59:22
 +0200
Date:	Sun, 10 Jul 2016 12:59:20 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Josh Triplett <josh@joshtriplett.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
In-Reply-To: <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607101255300.6426@virtualbox>
References: <20160708025948.GA3226@x> <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com> <20160708064448.GA18043@x> <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607090928500.6426@virtualbox> <20160709140931.GA3185@x>
 <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MmgIKs/abKD6VpPvFkdPdIjcTmUvPig3HUpRSqrPqTkm6w4IMme
 0E3RlncOEl6HtE97hbUVKXFP8osNdlfN37L8oEwOkNuHq41vyyC9ngAVfc+FKowGST9mgcj
 wJssHBbe2DpWcpKxwaOhJiE4m+ZpodY2E/GvCMxYX2/zeHGJv/nFcCWCqK2JewMLicvSOAW
 mY3Do94kftZxW6xOgmraQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:RgJbW5qeyP4=:V3qj5waIf5K6jHp7ibbb7b
 yyfUtyZph8JRkY1O2lPqor3+wrc4wkgKVZuV1qOhznrueIPnlRLETMS4edXxX1XP3iFb2bETW
 avT4dhhLASSRz45kEA/BULXP7WXIS4KKGawY73DM1pgWlIXhDCMr9gs0joEg0z5DM7g2JUVmI
 J0XjHNpCByeUPt7VkZ5+/5rcZSsRQt7GO5N3B9yXWYl8dRbP7XbZlkHex8XsDvix+8FTrZUmv
 BtA9EUGyti8PLjXdilBALBEbZ12tYkHIcMEW20GSO1Bxd1l0ef5oqOzfx6ZzolwQ/krGGSv0J
 F95s+NrBQOYPM2Jk7LnVX9UosHV6u+cNuOhA5xl1Fv3Ht7mceS7eYEK8j8KUwRQ8RZEJaJBdL
 VT6U+1V+j8HRsIYx37DNnVNL5hnmpXmNuBG2J7aZ+EARM4tlMit57Y0iMXk7heILb4y9maUzO
 qj7IAd+dvfzoLxRfir4D/uMGSWNj3x7nfu3aCBBT7NKL6duGBiIVXSHYx6PGVhvGjX8EgCbsd
 OYOqdkv+mg4XfJfC5zvoUzQ0LRQXfnlKF8wq9sF86nlrZ5GG3tblmbwhfcHr4rkX6LSlBEPxE
 4wodr/9UPm5Y+b4MArF1XcALmX1cXtPdUAAhtP2CIwgL0lnPalfMgc7iNbiLmfXevcpRMk5LA
 lmfvjCGP4yvajupvLDM+so4gPQEE9f8emRl8P/W54+xY9MxesrsdZT8EAgokumzY+VJyJGGsi
 f4ppK2nyYhL3GQhldypCVVs2b0mhgh2IYH94uhtpckyINJgbtLF6euvc16INv0xee1x+HIejG
 a3pkEwg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Sat, 9 Jul 2016, Duy Nguyen wrote:

> On Sat, Jul 9, 2016 at 4:09 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > On Sat, Jul 09, 2016 at 09:35:24AM +0200, Johannes Schindelin wrote:
> >> On Fri, 8 Jul 2016, Junio C Hamano wrote:
> >> > Josh Triplett <josh@joshtriplett.org> writes:
> >> >
> >> > > That sounds reasonable.  And if they *do* end up taking any time to
> >> > > traverse, it's because they weren't reachable from other anchoring
> >> > > points, so taking the extra time to traverse them seems fine.
> >> >
> >> > The only thing that is hard is to clearly define _what_ are the new
> >> > anchoring points.
> >> >
> >> > It cannot be "anything directly under .git that has all-caps name
> >> > that ends with _HEAD".  The ones we write we know are going to be
> >> > removed at some point in time (e.g. "git reset", "git bisect reset",
> >> > "git merge --abort", etc.).  We do not have any control on random
> >> > ones that the users and third-party tools leave behind, holding onto
> >> > irrelevant objects forever.
> >>
> >> Please note that bisect already uses the (transient) refs/bisect/
> >> namespace. So I do not think we need to take specific care of the
> >> BISECT_* files.
> >>
> >> If we had thought of it back then, we could have used such a transient
> >> namespace also for FETCH_HEAD, CHERRY_PICK_HEAD and also for detached
> >> HEADs (which we should have called "unnamed branches").
> >>
> >> Now, how about special-casing *just* these legacy files in gc: HEAD,
> >> FETCH_HEAD, MERGE_HEAD and CHERRY_PICK_HEAD? Any new transient refs should
> >> live in the refs/ namespace, which is already handled.
> >
> > That seems workable as well; in that case, we should also document this
> > (in the git-gc manpage at a minimum), and explicitly suggest creating
> > refs in refs/ but outside of refs/heads/ and refs/tags/, rather than
> > directly in .git/.
> 
> Not just outside refs/heads and refs/tags. It has to be in a specified
> namespace like refs/worktree/ or something (we are close to be ready
> for that). We could update the man page about git-gc shortcomings now,
> but I think we should wait until refs/worktree (or something like
> that) becomes true before suggesting more.

We have a precedent for a ref that is directly underneath refs/:
refs/stash.

IMO that is okay: depending on the use case, we would need multiple refs
(like refs/notes/*) or a single ref (like refs/stash).

The important part is that the new refs start with refs/, and if they are
to be transient, start neither with refs/heads/ nor with refs/tags/.

Ciao,
Dscho
