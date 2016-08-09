Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E571FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbcHILhH (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:37:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:51930 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752597AbcHILhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:37:06 -0400
Received: (qmail 22390 invoked by uid 109); 9 Aug 2016 11:37:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 11:37:05 +0000
Received: (qmail 19872 invoked by uid 111); 9 Aug 2016 11:37:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 07:37:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 07:37:03 -0400
Date:	Tue, 9 Aug 2016 07:37:03 -0400
From:	Jeff King <peff@peff.net>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
 <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 01:20:05AM +0200, Michael Haggerty wrote:

> > but I
> > do not think it is sane to expect that the same quality and quantity
> > of reviews as we do here can be maintained with that thing.
> 
> Could you elaborate why you would expect quality and/or quantity of
> reviews to suffer? I'm really curious, and I'd be happy to pass your
> feedback along to my colleagues.

Having done a lot of review here on the mailing list, as well as in
GitHub PRs, I vastly prefer the mailing list.

Here's a random list of things that I think I would miss:

 - I really like the flow of having the commit message and diff dumped
   in my editor. I'm very efficient at slicing and dicing text, omitting
   uninteresting quoted bits, etc.

   Web text boxes feel like a straitjacket. I do have a browser plugin
   that opens them in vim. That helps, but it breaks the flow (I make a
   comment, save the file, click "comment", then read to the next place,
   click "+", then start a new vim instance for that comment).  Besides
   the tedium of clicking around, it loses the "unit" size of a single
   email, where I may make many comments, go back and revise earlier
   comments after reading more of the patch, etc.

 - I really like the flow of having conversations next to patches. I can
   look at the index of the mailing list folder and see what people are
   talking about, how big the threads are, etc, at a glance. Moving
   between messages and threads involve single keystrokes.

   Similarly, having local storage is _fast_. I think GitHub is fine for
   a web app. But when I'm reading a high-volume mailing list, I really
   want to flip around quickly. If there's even 500ms to get to the next
   message or thread, it feels clunky and slow to me. Obviously I spend
   more than 500ms _reading_ most messages (though for some I see the
   first paragraph and immediately jump away). It's just the latency
   when I've decided I'm done with one thing and want to move to the
   next.

 - For that matter, GitHub doesn't really have a good tool for random
   conversations. There are issues, which you can vaguely use like a
   thread, but it doesn't quite feel the same.

   I think part of it is that I can view the mailing list both as a
   series of threads _and_ as a stream of messages. So sometimes I mark
   a thread as "read", and then see the next day that there are a ton of
   new messages on it. Maybe those are uninteresting (and it's a single
   keystroke to mark the thread again), but maybe that's a hint that
   there's interesting discussion going on.

   The threading in GitHub comments and pull requests is also not great.
   Each PR or issue is its own thread, but it's totally flat inside.
   There are no sub-threads to organize discussion, and it's sometimes
   hard to see what people are replying to.

 - When I move between a discussion and patches on the list and my local
   git checkout, it's important to do so with minimal fuss. Which means
   I want to use _context_ in my workflow. If I'm reading a thread, I
   want there to be a keystroke for "jump to this thread in my
   checkout". That's (relatively) easy for me to script via mutt (grab
   these patches, apply them). It's a bit harder in the browser (the
   best I've got is to copy-paste the URL to a script that pulls out the
   PR number, then fetches and checks it out).

 - A sort-of feature: the mailing list is actually fairly decentralized,
   because of the "reply-to-all" convention. I don't know if anybody
   else noticed, but vger seemed to be down Friday evening and Saturday
   morning (at least my messages to the list got 400 SMTP codes, and no
   new messages were delivered to me). But I still had some
   conversations going with people, because our messages were mailed
   directly (and the list eventually caught up).

   Now that probably doesn't matter for GitHub, which seems to have
   fairly reasonable uptime. It would matter if we picked a centralized
   tool that didn't.

There are probably more, but I've run out of ranting steam for now. :)

> Here are some factors that I think will *improve* reviews:

I was going to respond point-by-point to a few of these, but I think I
covered most of it above. In short, I agree with many of the benefits
you list. In most cases, I've already reaped those benefits for my own
workflow (e.g., my "git am" workflow is pretty efficient now). But not
everybody has done so, and it's a lot to ask of casual contributors.

> Given that I work for GitHub, I'm uncomfortable doing any more advocacy
> here. If people have concrete questions, I'd be happy to answer them, on
> the list or in private.

Hopefully I provided some counterpoint. ;)

-Peff
