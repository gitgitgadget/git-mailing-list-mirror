Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4DAC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BE461207
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbhIPWxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:53:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:49588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241276AbhIPWxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:53:35 -0400
Received: (qmail 8795 invoked by uid 109); 16 Sep 2021 22:52:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Sep 2021 22:52:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10170 invoked by uid 111); 16 Sep 2021 22:52:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Sep 2021 18:52:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Sep 2021 18:52:13 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 0/7] pack-bitmap: permute existing namehash values
Message-ID: <YUPKnd3jekNR80i4@coredump.intra.peff.net>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631657157.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 06:05:59PM -0400, Taylor Blau wrote:

> Here is a small-ish rerool of my series to carry forward values from an existing
> hash-cache when generating multi-pack reachability bitmaps.
> 
> Since last time, the performance tests in p5326 were cleaned up in order to
> produce timings for generating a pack when using a MIDX bitmap with the
> hash-cache extension.

I had seen most of these in prototype form before, but I hadn't yet
carefully looked at your cleanups for upstream. I gave them all a
careful read, and it all looks good to me.

I did have a few comments on patch 6 that I think are worth following up
on. We can also do so on top if you prefer.

-Peff
