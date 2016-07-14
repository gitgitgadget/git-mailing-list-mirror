Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766F720196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbcGNSul (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:50:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:44829 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751161AbcGNSuk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 14:50:40 -0400
Received: (qmail 9994 invoked by uid 102); 14 Jul 2016 18:50:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:50:40 -0400
Received: (qmail 7337 invoked by uid 107); 14 Jul 2016 18:51:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:51:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 14:50:37 -0400
Date:	Thu, 14 Jul 2016 14:50:37 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dan Wang <dwwang@google.com>, Eric Wong <e@80x24.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv5 0/4] Push options
Message-ID: <20160714185037.GG16497@sigill.intra.peff.net>
References: <20160714173920.22001-1-sbeller@google.com>
 <20160714184146.GE16497@sigill.intra.peff.net>
 <CAGZ79kaj2vfvS3RXCWqkZNdF7UkjAuv_J00kENPjz7SNTUV7BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaj2vfvS3RXCWqkZNdF7UkjAuv_J00kENPjz7SNTUV7BQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 11:48:58AM -0700, Stefan Beller wrote:

> > Hmm. So that is a downside for people who have implemented separate
> > DoS protection only in that upgrading git will open a new "hole"
> > that they need to plug. But that is their problem, not upstream
> > git's.
> >
> > -Peff
> 
> But this is not specific to DoS protection, but like most features.
> Just look at the vendors using linux that think carrying patches out
> of tree for their special snowflake hardware is cheaper than getting
> it upstream.... (This is not to be read as a snarky comment, but
> rather as a pointer to the similarity of the mechanisms involved).
> Although I cannot tell offhand another feature that would easily break
> downstream customization.

Right. I was serious when I said "their problem, not git's".

Most features are a little better off in that they are not a possible
negative for somebody downstream to receive them. But again, I don't
think that needs to restrict what git releases.

-Peff
