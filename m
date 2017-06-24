Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4020B20401
	for <e@80x24.org>; Sat, 24 Jun 2017 14:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbdFXOXE (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 10:23:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:51920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751055AbdFXOXD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 10:23:03 -0400
Received: (qmail 7477 invoked by uid 109); 24 Jun 2017 14:23:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 14:23:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24071 invoked by uid 111); 24 Jun 2017 14:23:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 10:23:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 10:23:01 -0400
Date:   Sat, 24 Jun 2017 10:23:01 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v5 0/5] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170624142301.c5jl7xxf4ici3cug@sigill.intra.peff.net>
References: <20170601082203.50397-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170601082203.50397-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2017 at 10:21:58AM +0200, Lars Schneider wrote:

> here is the 5th iteration of my "status delayed" topic. Patch 1 to 3 are
> minor t0021 test adjustments and haven't been changed since v3. Patch 4
> is a minor "extract method" refactoring in convert. Patch 5 is the new
> feature.

Yeah, patches 1-4 were pretty straightforward and obvious. I just left
some comments after a detailed read-through of patch 5. Overall the
direction looks good. I had a few minor comments on the code, but I
think with those addressed it will probably be ready for 'next'.

Note that I'll be offline all next week, so don't expect a timely
review on the next iteration (unlike this not-so-timely one ;) ).

-Peff
