Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A131B1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 14:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbcHPOtN (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 10:49:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:56238 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752021AbcHPOtM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 10:49:12 -0400
Received: (qmail 11774 invoked by uid 109); 16 Aug 2016 14:48:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 14:48:24 +0000
Received: (qmail 26787 invoked by uid 111); 16 Aug 2016 14:48:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 10:48:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 10:48:22 -0400
Date:	Tue, 16 Aug 2016 10:48:22 -0400
From:	Jeff King <peff@peff.net>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/3] limit the size of the packs we receive
Message-ID: <20160816144821.tbktj3l7agnsqddw@sigill.intra.peff.net>
References: <20160816081701.29949-1-chriscool@tuxfamily.org>
 <20160816131145.apq77nc2x7wb7lba@sigill.intra.peff.net>
 <CAP8UFD0mhhfNbcsiOpLqJ-4ZWOkKwcoJ9k3yQyO4jTem=s+yBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0mhhfNbcsiOpLqJ-4ZWOkKwcoJ9k3yQyO4jTem=s+yBg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 04:44:01PM +0200, Christian Couder wrote:

>> [sizes and signedness of off_t]
> I can add something along your explanations in the commit message if
> it is prefered.

I think it's probably OK without it.

-Peff
