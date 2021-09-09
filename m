Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286D8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03DC0610F8
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbhIIT4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:56:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:43284 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhIIT4n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:56:43 -0400
Received: (qmail 722 invoked by uid 109); 9 Sep 2021 19:55:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Sep 2021 19:55:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16133 invoked by uid 111); 9 Sep 2021 19:55:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Sep 2021 15:55:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Sep 2021 15:55:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] -Wunused-parameter clenaups on tb/multi-pack-bitmaps
Message-ID: <YTpms9UnVsx+uu/2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that tb/multi-pack-bitmaps is in "next", my local -Wunused-parameter
topic noticed a few possible cleanups. Neither is a big deal, and I can
definitely hold them for a larger cleanup. But I thought it might be
worth doing them while they're fresh in our minds.

  [1/2]: pack-bitmap: drop repository argument from prepare_midx_bitmap_git()
  [2/2]: pack-bitmap: drop bitmap_index argument from try_partial_reuse()

 midx.c        | 2 +-
 pack-bitmap.c | 8 +++-----
 pack-bitmap.h | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

-Peff
