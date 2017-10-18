Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1BBF1FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 04:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdJREBt (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 00:01:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:56174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750751AbdJREBs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 00:01:48 -0400
Received: (qmail 5990 invoked by uid 109); 18 Oct 2017 04:01:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 04:01:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28977 invoked by uid 111); 18 Oct 2017 04:01:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 00:01:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2017 00:01:46 -0400
Date:   Wed, 18 Oct 2017 00:01:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Minor man page weirdness?
Message-ID: <20171018040146.xuhchqtmzqzkzbgf@sigill.intra.peff.net>
References: <A4E5D8CC-19A7-442A-814C-FD5A46391982@gmail.com>
 <20171016225641.x76jwycb7mcpvrw3@sigill.intra.peff.net>
 <87zi8psli3.fsf@linux-m68k.org>
 <xmqq1sm1o5k5.fsf@gitster.mtv.corp.google.com>
 <xmqqfuahkwug.fsf@gitster.mtv.corp.google.com>
 <20171018032103.p6bz7wciiedokiyy@sigill.intra.peff.net>
 <xmqqbml5ktrk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbml5ktrk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 18, 2017 at 12:41:03PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It does make me wonder if there are other instances of the missing-space
> > problem lurking. Grepping for backtick followed by single-quote shows
> > only one more case in user-manual.txt. I have no idea if that one hits
> > the same problem on older docbook versions.
> 
> I had an impression that this is only for roff, but we do not
> produce user-manual.[0-9], do we?

Yeah, I think you're right. We do produce XML of it, but it goes to
other formats like texi and pdf (and if this is a docbook bug, it may or
may not be present in those other output formats).

-Peff
