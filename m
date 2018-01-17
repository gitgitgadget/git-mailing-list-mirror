Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018D41F406
	for <e@80x24.org>; Wed, 17 Jan 2018 22:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeAQW34 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 17:29:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:47208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750816AbeAQW3z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 17:29:55 -0500
Received: (qmail 21868 invoked by uid 109); 17 Jan 2018 22:29:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Jan 2018 22:29:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6396 invoked by uid 111); 17 Jan 2018 22:30:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Jan 2018 17:30:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jan 2018 17:29:53 -0500
Date:   Wed, 17 Jan 2018 17:29:53 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, stolee@gmail.com
Subject: Re: [PATCH] packfile: use get_be64() for large offsets
Message-ID: <20180117222953.GB16031@sigill.intra.peff.net>
References: <20180117190823.209469-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180117190823.209469-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 02:08:23PM -0500, Derrick Stolee wrote:

> The pack-index version 2 format uses two 4-byte integers in network-byte order to represent one 8-byte value. The current implementation has several code clones for stitching these integers together.

Yeah, this seems like a no-brainer, and the patch itself looks obviously
correct.

Please wrap your commit messages a bit shorter, though (say, between
60-72 chars).

-Peff
