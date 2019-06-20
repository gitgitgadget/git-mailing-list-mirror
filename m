Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4AF41F462
	for <e@80x24.org>; Thu, 20 Jun 2019 08:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfFTIuL (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 04:50:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:45618 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725925AbfFTIuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 04:50:11 -0400
Received: (qmail 17947 invoked by uid 109); 20 Jun 2019 08:50:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 08:50:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13752 invoked by uid 111); 20 Jun 2019 08:51:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 04:51:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 04:50:09 -0400
Date:   Thu, 20 Jun 2019 04:50:09 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] sha1-file: use OBJECT_INFO_NO_FETCH_IF_MISSING
Message-ID: <20190620085009.GC3952@sigill.intra.peff.net>
References: <20190620083026.14524-1-chriscool@tuxfamily.org>
 <20190620083026.14524-3-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620083026.14524-3-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 10:30:26AM +0200, Christian Couder wrote:

> Currently the OBJECT_INFO_FOR_PREFETCH flag is used to check
> if we should fetch objects from promisor remotes when we
> haven't found them elsewhere.
> 
> Now that OBJECT_INFO_NO_FETCH_IF_MISSING exists, let's use
> it instead to be more correct in case this new flag is ever
> used without OBJECT_INFO_QUICK.

I said earlier that this one would need to be tweaked for the new
upstream name. But actually, I think it is not necessary after Stolee's
patch.

-Peff
