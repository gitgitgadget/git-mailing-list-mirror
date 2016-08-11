Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3599820193
	for <e@80x24.org>; Thu, 11 Aug 2016 22:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbcHKWcv (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 18:32:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53370 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbcHKWct (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 18:32:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E7320193;
	Thu, 11 Aug 2016 22:32:49 +0000 (UTC)
Date:	Thu, 11 Aug 2016 22:32:49 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: public-inbox.org/git updates
Message-ID: <20160811223248.GB5607@starla>
References: <20160811194333.GA27387@starla>
 <xmqqr39vyr08.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr39vyr08.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > There'll be over 5000K injected messages from 2006 I missed from
> > the initial import :x
> >
> > I noticed this while adding gmane:NNNN mapping support to the
> > search engine:
> >   https://public-inbox.org/git/20160811002819.GA8311@starla/T/#u
> >
> > There will still be some missing messages because some are spam.
> > news.gmane.org remains up if you want to check my work
> > (please do, because I am careless)
> 
> Thanks for doing this.

No problem!

> I wanted to try out your NTTP service, but it took me a while to dig
> in my inbox to find your announcement of news.public-inbox.org that
> hosts inbox.comp.version-control.git "newsgroup".  Is it possible to
> make this a bit more discoverable, or there is not enough NNTP
> audience these days to warrant such an addition?  I first went to
> http://public-inbox.org/git as I expected there may be some pointers
> to other instances of the service, where you list the "git clone"
> URL of the archive.

Oops, I keep forgetting to do that :x  Should be easier to do
now since I cleaned up the footer generation a few weeks back.

> By the way, it felt quite strange to see messages from 8 years ago
> mixed with more recent messages when I gold Gnus to fetch the most
> recent 333 messages (and of course that fetches 333 messages with
> largest message numbers, not sorted by "Date:").  I am assuming that
> this is an artifact of "over 5k injected messages" bundle that was
> added out of order.

Yes, definitely an artifact of fixing that screwup.
For future inbox imports (maybe LKML), I may leave gaps in the
sequence along the way, but I'm not sure how big the gaps
should or could be.

I suppose one could assign NNTP article numbers like line
numbers in BASIC...
