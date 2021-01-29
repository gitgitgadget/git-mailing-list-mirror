Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595A1C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD9264DF1
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhA2BHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:07:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:42802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhA2BHA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:07:00 -0500
Received: (qmail 20799 invoked by uid 109); 29 Jan 2021 01:06:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 01:06:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4512 invoked by uid 111); 29 Jan 2021 01:06:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 20:06:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 20:06:11 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 00/10] pack-revindex: introduce on-disk '.rev' format
Message-ID: <YBNfgywXe5nr+96y@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611617819.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 06:37:09PM -0500, Taylor Blau wrote:

> Here is a third reroll of my series to introduce an on-disk format for the
> reverse index. Since the first series (to introduce a new API) has been merged
> to 'next', this series has been rebased onto 'next', too.
> 
> This version is largely unchanged from the previous, with the following
> exceptions:

Thanks, these all seemed like improvements to me. I hadn't read
carefully through the test patches yet, so I did so now (in addition to
checking out the changes in the earlier patches).

My comments range between "musings" and "suggestions". I wouldn't be too
torn up if they are all discarded and this applies as-is, but in
aggregate there may be enough to merit one more re-roll.

-Peff
