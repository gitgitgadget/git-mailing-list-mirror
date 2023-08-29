Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DB4C83F13
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 01:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjH2BAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 21:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjH2BAE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 21:00:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A447124
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 18:00:02 -0700 (PDT)
Received: (qmail 3334 invoked by uid 109); 29 Aug 2023 01:00:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 01:00:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6692 invoked by uid 111); 29 Aug 2023 01:00:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 21:00:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 21:00:00 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/4] leak tests: mark remaining tests leak-free as such
Message-ID: <20230829010000.GC3876652@coredump.intra.peff.net>
References: <cover.1692902414.git.me@ttaylorr.com>
 <cover.1693263171.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693263171.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 06:52:52PM -0400, Taylor Blau wrote:

> Here is a reroll of my (I guess now mine and Peff's!) series to update
> our test scripts to accurately mark which ones are leak-free.
> 
> This is mostly unchanged from the previous round, modulo cleaning up the
> first (now second) patch's message, and inserting a new patch from Peff
> at the beginning to ignore noisy LSan output.

Perhaps needless to say, but this all looks good to me. :)

-Peff
