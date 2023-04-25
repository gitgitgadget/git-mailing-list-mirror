Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A27C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 06:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjDYG1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 02:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjDYG1K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 02:27:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4047B46B
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 23:27:09 -0700 (PDT)
Received: (qmail 22061 invoked by uid 109); 25 Apr 2023 06:27:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 06:27:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1462 invoked by uid 111); 25 Apr 2023 06:27:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 02:27:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 02:27:08 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 0/6] banned: mark `strok()`, `strtok_r()` as banned
Message-ID: <20230425062708.GC4061254@coredump.intra.peff.net>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682374789.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 06:20:07PM -0400, Taylor Blau wrote:

> Here is another medium-sized reroll of my series to add `strtok()` (and
> `strtok_r()`!) to the list of banned functions.
> 
> Notable changes include:
> 
>   - Dropped `string_list_split_in_place_multi()` in favor of a
>     combination of `string_list_split_in_place()` and
>     `string_list_remove_empty_items()`.
> 
>   - `strtok_r()` is back on the banned list, with a more realistic sales
>     pitch.

This all looks good to me. I left two comments which are on the border
between "minor" and "philosophizing", so I'd be happy to see the series
go in as-is.

-Peff
