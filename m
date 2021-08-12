Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E79C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07836103A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhHLVWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 17:22:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:46104 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231270AbhHLVWL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 17:22:11 -0400
Received: (qmail 25168 invoked by uid 109); 12 Aug 2021 21:21:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 21:21:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25654 invoked by uid 111); 12 Aug 2021 21:21:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 17:21:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 17:21:44 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 00/25] multi-pack reachability bitmaps
Message-ID: <YRWQ6G/dYJC5Of1q@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 05:19:21PM -0400, Taylor Blau wrote:

> Thanks in advance for your review. I think Peff still wanted to read through
> patches 16-25, but that the first 15 or so should be in pretty good shape by
> now.

I think this is looking pretty close. There's the close_midx() thing
discussed in patch 9 that I think we need to deal with. In the tests, I
found some little nits. Nothing serious, but some of it at least is
worth fixing.

So I think with one more fairly trivial re-roll, we can think about
merging this to 'next'.

Thanks for your patience with my slow reviews, and for all your work on
this. It's really quite a complicated topic. :)

-Peff
