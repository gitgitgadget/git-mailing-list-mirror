Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239F0C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFA360551
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhGULcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 07:32:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:53222 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232239AbhGULcB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 07:32:01 -0400
Received: (qmail 2476 invoked by uid 109); 21 Jul 2021 12:12:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 12:12:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4141 invoked by uid 111); 21 Jul 2021 12:12:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 08:12:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 08:12:37 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 00/24] multi-pack reachability bitmaps
Message-ID: <YPgPNVfwedWFGqcd@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <87lf6yxqeh.fsf@evledraar.gmail.com>
 <YPBIBXUB53b0Hixx@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPBIBXUB53b0Hixx@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 10:36:53AM -0400, Taylor Blau wrote:

> I know that reviewing this is on Peff's list of things to do, but there
> are competing priorities (and we have all-company meetings this week, so
> I would not be surprised to see a lack of movement until at least next
> week).

I made it through a very careful read of all of the actual code changes,
through patch 14. After that, it looks like it's all tests, but my brain
is now effectively fried. I had some comments, but nothing
earth-shattering.

I'll pick up on 15-24 later, though I think between my comments and
Ævar's there's some light changes to be made. So don't hesitate to post
a new version in the meantime, which can save us a round-trip.

-Peff
