Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A031F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162264AbeBNSst (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:48:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:52430 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1162207AbeBNSss (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:48:48 -0500
Received: (qmail 31519 invoked by uid 109); 14 Feb 2018 18:48:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 18:48:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31836 invoked by uid 111); 14 Feb 2018 18:49:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 13:49:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 13:48:46 -0500
Date:   Wed, 14 Feb 2018 13:48:46 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] minor test-hashmap fixes
Message-ID: <20180214184846.GA13369@sigill.intra.peff.net>
References: <20180214180322.GA9190@sigill.intra.peff.net>
 <CAGZ79kZ5a1-znO_efwVbrRpXwboZHeiC+4PqB0SDR2Xwv5P+8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ5a1-znO_efwVbrRpXwboZHeiC+4PqB0SDR2Xwv5P+8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:41:35AM -0800, Stefan Beller wrote:

> I have lost track of the hashmap improvements lately, but with
> such a good test helper, we could reduce the amount of
> commented code in hashmap.h and just link to the test helper?
> (as an extra step after this series, I thought we already had that)

Yeah, the example code in hashmap.h looks to be more or less the same
thing as what's here (it maps a long to a value, which simplifies the
FLEX_ARRAY bits, but I think it serves equally well as a reference).

I'd also be fine with drastically simplifying the example in hashmap.h,
and letting test-hashmap serve as a more fleshed-out example (we don't
need to see the main and scanf bits there).

-Peff
