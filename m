Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0BBC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 22:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC932075E
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 22:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFPWSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:18:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:33996 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgFPWSS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 18:18:18 -0400
Received: (qmail 27959 invoked by uid 109); 16 Jun 2020 22:18:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 22:18:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18179 invoked by uid 111); 16 Jun 2020 22:18:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 18:18:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 18:18:17 -0400
From:   Jeff King <peff@peff.net>
To:     Oleg <lego_12239@rambler.ru>
Cc:     git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616221817.GC685107@coredump.intra.peff.net>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
 <20200616145207.GA13998@legohost>
 <20200616160005.GB667151@coredump.intra.peff.net>
 <20200616171048.GA18874@legohost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616171048.GA18874@legohost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 08:11:01PM +0300, Oleg wrote:

> > Not statistics, but anecdotally, many major projects and communities
> > have expressed interest in switching. Some of them are listed here:
> > 
> >   https://www.zdnet.com/article/github-to-replace-master-with-alternative-term-to-avoid-slavery-references/
> 
> This is not "many", Jeff :-D. There is info just about *few* major projects
> (i counted not more than *15*!), that also politically biased and are
> intimidated.

I didn't count them. 15 who have already said they are interested does
seem like "many" to me, especially as I'd expect more to do so as the
issue gets more attention. I don't think it matters if they're
politically biased or not. I just said they expressed interest in
switching.

But anyway. You asked what I based my statement on. I told you.

> > I don't think 100 million is the right number to think about. Many of
> > those aren't active, or aren't collaborative. A project like Chrome
> > changing their branch name has a much bigger impact than somebody's
> > homework repo with three commits.
> 
> Jeff, this is a discrimination ;-). And no. This isn't right. How many
> repos on github is inactive? May be 20 millions? Add to 80 millions gitlab and
> all another git repos from the world. I think we can easily collect around
> 150-200 million of active repos. Do you really think that count of developers of
> these all projects be less than count of Chrome developers? Why do 15 projects
> (politically biased) outweighs 200 millions of projects? Is this example of
> democracy or rationale mind? May be some there is corruption :-)?

Please stop making strawmen. I never said that the number of Chrome
developers was higher than the number of other developers. The original
claim I made that started this portion of the thread was only that
projects have expressed interest in changing, so tools are going to deal
with seeing non-master branches (and in fact already have been).

> And even so - 6% :-D. Jeff, this is really needed thing! :-D

Again, my point wasn't that a majority of people have changed or even
would change.My point was just that a significant enough percentage of
repos use the non-default name that it's a thing tools will need to deal
with. Perhaps you think 6% isn't enough to say so, but we may just agree
to disagree there.

> > question is whether the more abstract benefits to people are worth the
> > potential costs.
> 
> Of course, not. This is obvious.

You're asserting your position without providing any argument here.
Clearly other people feel the opposite way.

To be honest, I am not sure if it the benefits outweigh the costs or
not, and I am skeptical that any kind of accurate data gathering (e.g.,
a poll of opinions) could be done at this point, both because of the
vagueness of the task and because the issue has become so charged (not
just within Git, but in the greater world). But I'm inclined to err on
the side of empathy, especially if we can keep the cost side relatively
low.

-Peff
