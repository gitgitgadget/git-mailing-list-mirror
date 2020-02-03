Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF67C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946952087E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgBCVDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:03:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:51600 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725372AbgBCVDG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 16:03:06 -0500
Received: (qmail 4423 invoked by uid 109); 3 Feb 2020 21:03:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 21:03:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27052 invoked by uid 111); 3 Feb 2020 21:11:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 16:11:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 16:03:05 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: git-filter-branch.txt: wrap "maths" notation in backticks
Message-ID: <20200203210305.GA11902@coredump.intra.peff.net>
References: <20200203114549.GA4157558@coredump.intra.peff.net>
 <20200203203650.31914-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200203203650.31914-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 09:36:50PM +0100, Martin Ågren wrote:

> --->8---
> Subject: [PATCH v2] git-filter-branch.txt: wrap "maths" notation in backticks

Yep, this looks fine to me. Thanks.

(I'd consider it fine to also put the O(n^2) you found in backticks, but
if it renders fine in both places already, I'm happy either way).

-Peff
