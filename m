Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4258320248
	for <e@80x24.org>; Wed, 13 Mar 2019 19:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfCMTk0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 15:40:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:49424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726396AbfCMTk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 15:40:26 -0400
Received: (qmail 21163 invoked by uid 109); 13 Mar 2019 19:40:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Mar 2019 19:40:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15178 invoked by uid 111); 13 Mar 2019 19:39:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 15:39:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 15:39:09 -0400
Date:   Wed, 13 Mar 2019 15:39:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
Message-ID: <20190313193909.GB3400@sigill.intra.peff.net>
References: <20190312213246.GA6252@sigill.intra.peff.net>
 <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 10:49:22AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > infrequent contributors. And there are a few reasons to prefer GGG:
> >
> >   1. submitGit seems to still have a few rough edges. E.g., it doesn't
> >      munge timestamps to help threaded mail readers handled out-of-order
> >      delivery.
> 
> Hmph, I had an impression that the recent "why aren't these sorted"
> topics were via GGG, not submitGit, though.

We did have one case a few months ago, but I think it was since fixed.
Whereas it cannot be fixed for submitGit without major re-architecting,
because the mails go out through Amazon SES, which writes its own
timestamp.

I could be wrong about GGG being fixed though. I haven't noticed the
problem lately, but we definitely had a submitGit-related one a few
weeks ago.

-Peff
