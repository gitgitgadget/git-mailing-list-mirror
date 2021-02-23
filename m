Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DF1C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 03:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D449164E4B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 03:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhBWDke (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 22:40:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:41116 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230310AbhBWDkd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 22:40:33 -0500
Received: (qmail 23011 invoked by uid 109); 23 Feb 2021 03:39:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 03:39:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23057 invoked by uid 111); 23 Feb 2021 03:39:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Feb 2021 22:39:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Feb 2021 22:39:52 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v4 0/8] repack: support repacking into a geometric
 sequence
Message-ID: <YDR5CApT3xw4QKwd@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1614047097.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614047097.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 09:24:59PM -0500, Taylor Blau wrote:

> Here's a very lightly modified version on v3 of mine and Peff's series
> to add a new 'git repack --geometric' mode. Almost nothing has changed
> since last time, with the exception of:
> 
>   - Packs listed over standard input to 'git pack-objects --stdin-packs'
>     are sorted in descending mtime order (and objects are strung
>     together in pack order as before) so that objects are laid out
>     roughly newest-to-oldest in the resulting pack.
> 
>   - Swapped the order of two paragraphs in patch 5 to make the perf
>     results clearer.
> 
>   - Mention '--unpacked' specifically in the documentation for 'git
>     repack --geometric'.
> 
>   - Typo fixes.

Thanks, this all looks great to me.

-Peff
