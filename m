Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEFAC433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE79F61076
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbhIQWOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:14:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:50278 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344531AbhIQWOM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 18:14:12 -0400
Received: (qmail 13652 invoked by uid 109); 17 Sep 2021 22:12:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Sep 2021 22:12:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23196 invoked by uid 111); 17 Sep 2021 22:12:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Sep 2021 18:12:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Sep 2021 18:12:48 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 0/7] pack-bitmap: permute existing namehash values
Message-ID: <YUUS4Mrh85KPucmi@coredump.intra.peff.net>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631913631.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631913631.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 05:21:11PM -0400, Taylor Blau wrote:

> Here is a very small reroll of my series to permute values from an existing
> hash-cache when generating multi-pack reachability bitmaps.
> 
> The only changes since last time are a slightly modified version of the
> performance tests which don't time generating the pack-bitmap. And the new test
> in t5326 no longer has a redundant `git config pack.writeBitmapHashCache` since
> it is true by default.

Thanks for picking up my suggestions. This all looks good to me!

-Peff
