Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC71EC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 00:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJVAb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJVAbY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 20:31:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B4D22E8CD
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:31:19 -0700 (PDT)
Received: (qmail 15324 invoked by uid 109); 22 Oct 2022 00:31:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 00:31:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19122 invoked by uid 111); 22 Oct 2022 00:31:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 20:31:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 20:31:18 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v3 0/7] shortlog: introduce `--group=<format>`
Message-ID: <Y1M51qzvymXHp/kI@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666391136.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666391136.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 06:25:37PM -0400, Taylor Blau wrote:

> Here is a (likely final) reroll of my series to implement arbitrary
> pretty formats as shortlog `--group`'s, based on a suggestion from Jacob
> Stopak.
> 
> The changes are cosmetic, based on the latest round of review from Peff.
> There aren't any substantive changes from the last round.

I looked over the range-diff and gave another careful read of patch 4.
It mostly looks good, though I did find an oddity in patch 4. It's a
really subtle breakage that goes away by the end, so I'm not entirely
sure it's worth dealing with.

So I'd be happy enough with this version, or if you want to do a final
re-roll that addresses that, I'm happy to review it.

-Peff
