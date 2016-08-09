Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1501F859
	for <e@80x24.org>; Tue,  9 Aug 2016 17:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbcHIRuW (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 13:50:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:52151 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932212AbcHIRuV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 13:50:21 -0400
Received: (qmail 16222 invoked by uid 109); 9 Aug 2016 17:50:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 17:50:21 +0000
Received: (qmail 22784 invoked by uid 111); 9 Aug 2016 17:50:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 13:50:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 13:50:18 -0400
Date:	Tue, 9 Aug 2016 13:50:18 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
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
Message-ID: <20160809175018.p3bwnqjwz44t2xnb@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
 <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
 <20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net>
 <xmqqh9atc0do.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh9atc0do.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 10:34:11AM -0700, Junio C Hamano wrote:

> >    The threading in GitHub comments and pull requests is also not great.
> >    Each PR or issue is its own thread, but it's totally flat inside.
> >    There are no sub-threads to organize discussion, and it's sometimes
> >    hard to see what people are replying to.
> 
> It may be a good UI that is optimized for drive-by contributors.  It
> is just that it is not very well suited (compared to mailing list
> discussions) to conduct high-volume exchange of ideas and changes
> efficiently.

I think that's something to ponder; can we have a workflow where
drive-by contributors can use something that has a lower learning/setup
curve, but long-term contributors might opt for something more powerful?

I think SubmitGit is a step in that direction. It does still require
switching to the mailing list for subsequent conversation, though. It
would be interesting to see something like SubmitGit that puts its own
email in the "From", and that processes email replies into PR comments,
and then subsequent PR comments into emails (i.e., part of my "dream tool"
from earlier). It's not clear to me whether the result would just end up
being irritating for both sides to use (because it doesn't _quite_
conform to the norms of each format). But it would be fun to find out.

-Peff
