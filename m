Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A942018E
	for <e@80x24.org>; Tue, 12 Jul 2016 10:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbcGLKrQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 06:47:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:58950 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbcGLKrP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 06:47:15 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LlE86-1an2R332RC-00b0Wf; Tue, 12 Jul 2016 12:47:07
 +0200
Date:	Tue, 12 Jul 2016 12:47:06 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Duy Nguyen <pclouds@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
In-Reply-To: <xmqqinwc9fe2.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607121243470.6426@virtualbox>
References: <20160708025948.GA3226@x> <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com> <20160708064448.GA18043@x> <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607090928500.6426@virtualbox> <20160709140931.GA3185@x>
 <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com> <alpine.DEB.2.20.1607101255300.6426@virtualbox> <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com> <alpine.DEB.2.20.1607101602320.6426@virtualbox>
 <xmqqinwc9fe2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nVL51+nwFCqAb9cKTBuaqSmPGxu49WwO3F2wx2FekW1g5Ii7ikq
 sm8tdA/H1mynAej/dpj2vCBDq99qUlWOqi1eGgNllmrnpFn+SoIvRl5EYy7m20oC93f/a7i
 MucLPawh9ekYR7Ns68q1JBEbVm3nqHnzFmHNE1iCcXw2EOC5FdpxBBqrYpuu0iviNlH6BKp
 PvlHxe7rFtvEME+bDEUjA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ZfcUCG0Iq4s=:FBQyqt0uJBq2vAkjscSac1
 lK1d9ESI8KflNpoGpoqMEDXx+Of5Su95Cm9aKh+v9k1zwkM7+qSrbqLHdcmx5yFHWWJmME4Ke
 Pva1WnefhMtBy8AAjXZDL/ZbWlD/q28ImyCHcfzIAY9vyDC7SdXKKSQiVH2yc571TEPJTzT8l
 wqjeNzGu8SgHbR+vPhXTy1C9iW4AR2n6JSC3C4C4Z9LbB4raSKVKALajvoLAplLY6rUKmXebx
 6lzQSFhVT2kQbUGhjMfrZInpiSTMf7tmqalwkLlyKSS5ExEbGKezUNtbaTB3QSWsppNP65w89
 DmP79ihPQ6elHxMDaMoT/0r5/BHFu5YmtMRHDzoe9rwSmvm5oeoYKikahYgmb6zqMipjZRTO/
 ahM9E7uE1An5lLESNjrCX6IlyTcUhQshtokBoEKW22Nc00ekMNE913nr4S0LJwL8uIfa2sdyb
 YQ9yi0yB8FrCPZXknnjUUpz6o5tw15BS7dgEezcYGA+t9fY3ugsJo3sD+PORsklie9j+QdOUP
 vyIujN/whl9x4ZxhbMZx61iwM7YUa15rfMc7C7wL4Kxo2U3YUS43idNLQp14o981OSFurZTCJ
 0Orn+cIEeeAVqi8UmTjoKeObNBeImnLX9rpmuwlGVb3ZiblUuthcf+9CVFwP60dTqMcg1WGfo
 g/oegPGu44iE794+r/25jA6EcTLuwlR7segptMeZMyDMD1ZUl4+DvpmD7yXtkydCUv+cjE/Mk
 8hdO/OWLC3bcm/AHpkRnBhuIpHbuqrtreofRVizpAkSXDKqwUaudRGldAGq3OQaes1Qo9F/n2
 JCJ+6Ur
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 11 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> No, the point is, refs subsystem needs to know which refs is per-repo,
> >> which is per-worktree. So far the rules are  "everything under refs,
> >> except a few known exceptions, is per-repo" and "everything directly
> >> under $GIT_DIR is per-worktree", which work fine. But if you allow to
> >> move per-worktree to "refs" freely, then the "known exceptions" will
> >> have to be updated every time a new per-worktree ref appears. It'll be
> >> easier to modify the first rule as "everything under refs, except some
> >> legacy exceptions and refs/worktree, is per-repo".
> >
> > Given the substantial pain and suffering I have due to per-worktree
> > reflogs (and those are *just* HEAD's reflogs!), it appears to me that
> > per-worktree refs would be a particularly poor feature.
> >
> > I agree that HEAD needs to be per-worktree, but already the fact that the
> > HEADs of the worktrees, along with their reflogs, are *not* visible to
> > all other worktrees causes substantial trouble.
> 
> Not so fast; it cuts both ways.
> 
> People who want multiple worktrees with branches checked out to work
> in would want to do per-worktree things like bisection, which needs
> tons more state than we'd be comfortable having directly under
> $GIT_DIR (e.g. they may also want "git merge" or "git pull", which
> would use MERGE_HEAD and FETCH_HEAD that are per-worktree and not
> under refs/; "git bisect" would want to mark number of commits to
> denote the perimeter of the area of the history being bisected and
> they live refs/bisect/).

Sure, `git bisect` would need to realize that it is running in a worktree
separate from the original one and use a different ref.

> And when you are bisecting in the worktree dedicated for a topic,
> it is a feature that your other worktrees do not need to see how
> much history you narrowed down in that topic.

If you intentionally hide bisections from other worktrees, you will
invariably end up with the same problems I faced with auto-gc: in a
worktree, it is *much, much easier* to forget a bisect in progress.

In other words, your comments make me even more certain that per-worktree
refs are undesirable.

Ciao,
Dscho
