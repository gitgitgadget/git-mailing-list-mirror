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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B09C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 18:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836A820810
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 18:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="qAGlqj4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgFPSxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:53:00 -0400
Received: from huan9.mail.rambler.ru ([81.19.78.8]:51100 "EHLO
        huan9.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgFPSxA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 14:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=O6PPrZMDx5H4QMi3W1GadqHfFDvVRX/P+e9QWPWusvY=; b=qAGlqj4P9fbDslxEgzw3WHu4M8
        3ug2tEJ2M8r4dmJ6v2AzgWdJKR+5frVqG1WOOK+dG5kdZKL+bj281PaGkBpblDXRJhlXEndNzPcWM
        bFDsb70nsaMupZxxHoP+QORSY2VfWpd7rGIpT4iHRHkI/NEj6gfFLOyDeufXmJDdneZ8=;
Received: from [UNAVAILABLE] ([194.190.114.28]:38740 helo=localhost)
        by huan9.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlGhe-00005Z-MA
        for git@vger.kernel.org; Tue, 16 Jun 2020 21:52:58 +0300
Date:   Tue, 16 Jun 2020 21:54:39 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616185439.GA27441@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
 <20200616145207.GA13998@legohost>
 <20200616160005.GB667151@coredump.intra.peff.net>
 <20200616171048.GA18874@legohost>
 <20200616173227.inexk4clqilojg36@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616173227.inexk4clqilojg36@chatter.i7.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 01:32:27PM -0400, Konstantin Ryabitsev wrote:
> On Tue, Jun 16, 2020 at 08:11:01PM +0300, Oleg wrote:
> > > question is whether the more abstract benefits to people are worth the
> > > potential costs.
> > 
> > Of course, not. This is obvious.
> 
> Oleg, that doesn't make it an invalid discussion point. If Git was 
> written in German and the lead branch was called "refs/heads/fuhrer" 
> (German word for "leader"), you'd be on the opposite side of the 
> barricades arguing that this needs to be changed because it's offensive 
> to many people whose immediate family members died in WW2.

No. You are wrong here :-). I'm adequate person and the case about which you
talk couldn't happen. The problems could be if instead of "fuhrer" be
"AdolfHitler". And these are completely different things. One side is the
recist and nazi whose people killed many, very many, people in the world.
And another side is a... m... "master"? What wrong with this word?

> why is this even a discussion topic -- isn't there something more 
> important everyone could work on?

Wow. I ask just the same question again and again! There are much of work, but
we do some strange changes. These changes will generate a lot of troubles to
me and other git users/admins. I don't understand why this is happening. And
why if some country have temporary internal problems all other world should
suffer and have long-term problems. If anybody can't sleep and want do some
meaningless action, they can just buy a t-shirt with the text "no masters, no
slaves" or "i'm not supporting masters" or something like this. This will be
meaningless like a default branch name change, but nobody will suffer.

> Yes, it's a politically motivated change, but it's clearly important to 
> quite a few people right now and their views should not be disregarded.

Ok. But why my and other views are disregarded? Why are this people better,
then we? Who decide this? Why do we have a such discrimination in 2020?

This is a stupid politically motivated change and in the future something
can happens again and somebody run to change something meaningless else.
That why software should stay away from politics. Software is just an
instrument. And we shouldn't break an instrument everytime something
not technically related happens.

But this is ordinary western chauvinism. And intresting thing. People which
try to looks like anti-racist behaves like a racist:

they just do something with public tool without discussion with anyone outside of
their elite circle.

At first nobody asked indians about their land and desires. First americans just
killed almost all of they. Then, americans went to Africa and made slaves from
locals. Europian countries went to Africa and Asia and made colonies with cheap
labor. Hitler didn't ask anybody about the desire to be killed - just did it.
And now the descendants of slaveholders break public tool without asking
somebody.

Years are coming, but nothing changes...


https://www.change.org/p/github-do-not-rename-the-default-branch-from-master-to-main
https://www.reddit.com/r/github/comments/h8u7fo/github_to_replace_master_with_alternative_term_to/

-- 
Олег Неманов (Oleg Nemanov)
