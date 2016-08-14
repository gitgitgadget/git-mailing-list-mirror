Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAFB1F859
	for <e@80x24.org>; Sun, 14 Aug 2016 08:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbcHNIgy (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 04:36:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43760 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbcHNIgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 04:36:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA732018E;
	Sun, 14 Aug 2016 01:27:06 +0000 (UTC)
Date:	Sun, 14 Aug 2016 01:27:06 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer
Message-ID: <20160814012706.GA18784@starla>
References: <xmqq1t1twymf.fsf@gitster.mtv.corp.google.com>
 <20160812224255.GA16250@dcvr>
 <20160813081012.p46i4jcvkkfqch7m@sigill.intra.peff.net>
 <20160813090432.GA25565@starla>
 <20160813111449.vkoo3fmlfd65loh5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160813111449.vkoo3fmlfd65loh5@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> I collected the message-ids from my archive. Interestingly, I had a
> dozen or so that did not have message-ids at all. I think most of them
> are from patches that put the "From " line in the body, like this one:
> 
>   http://public-inbox.org/git/20070311033833.GB10781@spearce.org/
> 
> and then they got corrupted on a round-trip through one of the bad mbox
> formats (probably downloading from gmane, I'd guess; the export there
> uses mbox, and I use maildir myself, so it probably got split badly
> years ago). Anyway, public-inbox seems to get this case right, which is
> good.

Yes, I was somewhat careful to check for proper mboxes from gmane;
I just missed entire ranges :x

What's also interesting about the thread you highlighed is the
extra '<>' when you started that thread; and I have a bug where
I strip off an extra '>' which needs to be fixed...

I wonder if I should make "editorial" changes to fixup user bugs,
but then there's also bunch of messages which are replies to <y>
because git-send-email had usability problems back in the day...

> I had several hundred message ids that you didn't. About half of them
> were spam or other junk. I weeded them out manually (mostly by picking
> through the subjects, so possibly there's some error). The end result is
> 279 messages that I think are legitimate that you don't have.
> 
> I'll send them to you off-list, as the mbox is about 300K, which the
> list will reject.

Thanks, should all be imported.

The one which started the thread belonging to
<loom.20100716T103549-783@post.gmane.org> was really iffy,
but I kept it; as well as an "unsubscribe" one; I guess those
people are shamed for life :)


  git cat-file blob HEAD:b7/5bb577d76487bc9aebf0656d4e03eff22049f4

is totally legit, but doesn't seem to show up properly,
so there's another bug I need to fix.  For the moment, the
following also works:

	public-inbox.org/git/b75bb577d76487bc9aebf0656d4e03eff22049f4/
(but I guess it was reposted as <26299.4828321554$1213013668@news.gmane.org>
