Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97C71F462
	for <e@80x24.org>; Wed, 19 Jun 2019 17:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfFSRsn (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 13:48:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:44268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727458AbfFSRsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 13:48:43 -0400
Received: (qmail 11133 invoked by uid 109); 19 Jun 2019 17:45:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 17:45:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7732 invoked by uid 111); 19 Jun 2019 17:49:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 13:49:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 13:48:41 -0400
Date:   Wed, 19 Jun 2019 13:48:41 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] a few more redundant system include cleanups
Message-ID: <20190619174841.GB27834@sigill.intra.peff.net>
References: <20190618064537.62369-1-carenas@gmail.com>
 <20190618155326.GA4014@sigill.intra.peff.net>
 <CAPUEspgRnGd4nT3yd2YTGMt8t4qQ=V3GGNeTih3cmjnZHNextw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspgRnGd4nT3yd2YTGMt8t4qQ=V3GGNeTih3cmjnZHNextw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 02:12:30AM -0700, Carlo Arenas wrote:

> > I did a quick grep for similar cases, and didn't find any that I think
> > would be problematic. There were a few cleanups, below.
> 
> would you mind if I add your 2 patches to a series and include that
> missing one?, that way I'll also have a chance to write a better commit
> message from my original change, including the other feedback I got
> as well

That's be fine with me. Thanks.

> PS. is there a recommendation on how to version a patch that move
> into a series that would be preferred?

I think you can just say "v2" on the whole thing, include all three
patches, and then write a note that the series supersedes what I sent.

-Peff
