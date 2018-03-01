Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458EF1F576
	for <e@80x24.org>; Thu,  1 Mar 2018 07:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934917AbeCAHi6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 02:38:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:42320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933286AbeCAHi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 02:38:58 -0500
Received: (qmail 15976 invoked by uid 109); 1 Mar 2018 07:38:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Mar 2018 07:38:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12577 invoked by uid 111); 1 Mar 2018 07:39:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Mar 2018 02:39:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2018 02:38:56 -0500
Date:   Thu, 1 Mar 2018 02:38:56 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] roll back locks in various code paths
Message-ID: <20180301073855.GD31079@sigill.intra.peff.net>
References: <CAN0heSqmWAN=rCO8busGtb0xNPiB5H_jkL664qH8xasPq1Sy0A@mail.gmail.com>
 <cover.1519843916.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1519843916.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 08:07:53PM +0100, Martin Ågren wrote:

> This is v2 of my series to always release locks. As before, there's a
> conflict with pu, where the correct resolution is to take my version of
> the conflicting hunk.
> 
> The only difference to v1 is in patch 3. I'll follow up with a patch to
> address the confusing pattern which Peff mentioned and which fooled me
> when I prepared v1.

This looks good to me. And I'm glad my rambling helped find something
useful. ;)

-Peff
