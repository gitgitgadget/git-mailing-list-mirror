Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67008C55186
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF8B20774
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 05:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDXFnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:43:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:38424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725554AbgDXFnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 01:43:11 -0400
Received: (qmail 19916 invoked by uid 109); 24 Apr 2020 05:43:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Apr 2020 05:43:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23392 invoked by uid 111); 24 Apr 2020 05:54:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Apr 2020 01:54:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Apr 2020 01:43:10 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 0/4] pack-bitmap: use bitmaps for traversals with
 '--filter=tree:0'
Message-ID: <20200424054310.GF1648190@coredump.intra.peff.net>
References: <cover.1587597151.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587597151.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 05:13:19PM -0600, Taylor Blau wrote:

> This series contains a handful of patches to make object traversals with
> '--filter=tree:0' be bitmaps-compatible. They have been kicking around
> in GitHub's fork for some time, and we use them on every
> '--filter=tree:0' fetch.

As an author of half the patches, you can take my review with a grain of
salt, but these all look good to me (modulo one typo fix in a commit
message).

-Peff
