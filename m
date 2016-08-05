Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A213E2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 09:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbcHEJ7n (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 05:59:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59542 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759458AbcHEJ7m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 05:59:42 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81602018E;
	Fri,  5 Aug 2016 09:59:41 +0000 (UTC)
Date:	Fri, 5 Aug 2016 09:59:41 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] more archives of this list
Message-ID: <20160805095941.GA1875@dcvr>
References: <20160710004813.GA20210@dcvr.yhbt.net>
 <20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net>
 <20160805093544.scvl4yshkfg2l26p@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160805093544.scvl4yshkfg2l26p@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Fri, Aug 05, 2016 at 05:28:05AM -0400, Jeff King wrote:
> 
> > On Sun, Jul 10, 2016 at 12:48:13AM +0000, Eric Wong wrote:
> > 
> > > Very much a work-in-progress, but NNTP and HTTP/HTTPS sorta work
> > > based on stuff that is on gmane and stuff I'm accumulating by
> > > being a subscriber.
> > 
> > I checked this out when you posted it, and have been using it the past
> > few weeks. I really like it. I find the URL structure much easier to
> > navigate than gmane.

Thanks :>

> > I do find it visually a little harder to navigate through threads,
> > because there's not much styling there, and the messages seem to run
> > into one another. I don't know if a border around the divs or something
> > would help. I'm really terrible at that kind of visual design.
> 
> I took a peek at doing something simple like:

I'm trying to keep the visual design consistent across browsers
without CSS support (I mainly use w3m) and CSS scares me:

http://thejh.net/misc/website-terminal-copy-paste

(and JavaScript has me cowering in a corner behind a chair :x)

> but it looks like there's no HTML structure at all to the current
> output. It's just one big <pre> tag with various levels of indentation
> to represent the messages.
> 
> So I guess a potential first step would be actually representing a
> thread as:
> 
>   <div class="message">
>     parent message...
>     <div class="message">
>       reply...
>     </div>
>   </div>

The, <ul><li>... in the /$MID/t/ (as opposed to /$MID/T/) endpoint
might be what you're looking for.  See the "[flat|threaded]" links.

I run out of horizontal space with the giant fonts I like to
use, but it might be preferable for some folks.



And about the 2/38 tree structure; I am starting to avoid it
(for Xapian users, at least) but haven't performed the reindex
on all my servers, yet:

https://public-inbox.org/meta/20160805010300.7053-1-e%4080x24.org/

Of course, Xapian is only an optional dependency and won't
affect git internals.

I might end up having to nuke history occasionally anyways,
(in case somebody invokes the DMCA, or there's enough spam
 to warrant permanent deletion)

(Will try to digest the rest of your message later).
