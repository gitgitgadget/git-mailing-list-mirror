Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7F21F597
	for <e@80x24.org>; Tue, 24 Jul 2018 10:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeGXLaJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 07:30:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:57266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726270AbeGXLaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 07:30:09 -0400
Received: (qmail 9875 invoked by uid 109); 24 Jul 2018 10:24:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 10:24:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26011 invoked by uid 111); 24 Jul 2018 10:24:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 06:24:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 06:24:21 -0400
Date:   Tue, 24 Jul 2018 06:24:21 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 5/5] t: add t9930-delta-islands.sh
Message-ID: <20180724102421.GD3578@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-6-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180722054836.28935-6-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 07:48:36AM +0200, Christian Couder wrote:

> From: Jeff King <peff@peff.net>
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t9930-delta-islands.sh | 143 +++++++++++++++++++++++++++++++++++++++

For topics that I'm not immediately sending upstream, I usually stick
them in the t99xx range, so they don't conflict with upstream tests. But
for upstream, this should probably be in the t53xx range.

-Peff
