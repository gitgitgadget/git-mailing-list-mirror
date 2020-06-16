Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3752BC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7AF2098B
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="osTHO2I2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgFPRJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:09:27 -0400
Received: from huan5.mail.rambler.ru ([81.19.78.4]:42760 "EHLO
        huan5.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgFPRJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 13:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=P2nwymF7nb6ZVFJUNCh3soLKr9Tvaf0s0HSO/3ucjOg=; b=osTHO2I2kDTU++ae0IJ1kRrCB9
        oVc4pbk68pN2UDrUIyVU6Kc21iMHXwYSuwp7LMUJCvRL+q/aMxuaSduykb24GsDqVJwBmKt2Xw7SN
        /F1XRxuBX6vQoU1+PcTZ0B8xwgqY/hzHyw4rEnyqyVd1/ptAReFzIdMFWcexSOVp7Rhc=;
Received: from [UNAVAILABLE] ([194.190.114.28]:48250 helo=localhost)
        by huan5.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlF5R-0005F6-13
        for git@vger.kernel.org; Tue, 16 Jun 2020 20:09:25 +0300
Date:   Tue, 16 Jun 2020 20:11:01 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616171048.GA18874@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
 <20200616145207.GA13998@legohost>
 <20200616160005.GB667151@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616160005.GB667151@coredump.intra.peff.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 12:00:05PM -0400, Jeff King wrote:
> On Tue, Jun 16, 2020 at 05:52:52PM +0300, Oleg wrote:
> > Jeff, where do you get your statistics? github, for example, have around
> > 100 million repos. How many of them want to do it?
> 
> Not statistics, but anecdotally, many major projects and communities
> have expressed interest in switching. Some of them are listed here:
> 
>   https://www.zdnet.com/article/github-to-replace-master-with-alternative-term-to-avoid-slavery-references/

This is not "many", Jeff :-D. There is info just about *few* major projects
(i counted not more than *15*!), that also politically biased and are
intimidated.

> I don't think 100 million is the right number to think about. Many of
> those aren't active, or aren't collaborative. A project like Chrome
> changing their branch name has a much bigger impact than somebody's
> homework repo with three commits.

Jeff, this is a discrimination ;-). And no. This isn't right. How many
repos on github is inactive? May be 20 millions? Add to 80 millions gitlab and
all another git repos from the world. I think we can easily collect around
150-200 million of active repos. Do you really think that count of developers of
these all projects be less than count of Chrome developers? Why do 15 projects
(politically biased) outweighs 200 millions of projects? Is this example of
democracy or rationale mind? May be some there is corruption :-)?

> I was curious about some raw numbers, though, so I picked a random
> sample of ~25k GitHub repositories that had been pushed to in the last
> 30 days.  About 6% have a default branch name besides "master". There's

I think if you get repos from, for example, february instead of *last* 30 days,
then you will get a yet little numbers. Because the last 21 days people are
insane, if you understand me.

And even so - 6% :-D. Jeff, this is really needed thing! :-D
This small numbers show just about one thing - this is useless feature.
Of course, i talk about normal people. In any time, there are a few "not
ordinary" persons and jokers.

> But it seems to me that with 6% non-master names, most tools are going
> to run into these cases sooner or later, and have to deal with it. I'd
> be much more worried about one-off scripts that see a small, non-uniform
> set of repositories.

Look, now this is a problem of rare "geniuses". Why do you want to bring
these problems to all of us :-)? What did we do you?

> I think it's clear that this _is_ a politically-driven change. It is not
> helping the software in any technical way to change the name. The

Yes. You are absolutely right.

> question is whether the more abstract benefits to people are worth the
> potential costs.

Of course, not. This is obvious.

> But I don't think anybody has been able to quantify the benefits in a
> meaningful way. Or at least a way that everyone agrees on.

Jeff, everything is simpler. You lie to youself about it :-). *Everybody*
adequate person will say you that there are *no* benefits at all. Only
troubles, troubles and troubles. And we are already seeing this. There is no
need for a time machine. This will helps nobody. This changes willn't materialize
food for homeless and willn't protect someone from humiliation. But in current time,
when people click "like" button instead of doing real things for others and think
that they do "everything right" and this helps somebody :-), this is hard to
understand. If you would find any slave which is offended by
"master" word, then this conversation was meaningful. But now it looks like
people who have never been masters appologize to people who have never been
slaves. And are doing this, note please, in very strange manner.

Look, if you really try to make somebody life better, just image that you
have no access to git code. How can you help? Search the better way that
will really helps somebody. Don't break git. And after several monthes,
when common sense will return to us, we will look again on this "useful"
change.

-- 
Олег Неманов (Oleg Nemanov)
