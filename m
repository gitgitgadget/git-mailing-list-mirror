Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D27FC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 19:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiKUTFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKUTE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 14:04:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF17450B5
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:04:57 -0800 (PST)
Received: (qmail 12402 invoked by uid 109); 21 Nov 2022 19:04:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 19:04:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26459 invoked by uid 111); 21 Nov 2022 19:04:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 14:04:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 14:04:55 -0500
From:   Jeff King <peff@peff.net>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 0/4] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y3vL1zWa99z/Liy7@coredump.intra.peff.net>
References: <cover.1667470481.git.dyroneteng@gmail.com>
 <cover.1669032425.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1669032425.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 08:16:11PM +0800, Teng Long wrote:

> Diff since v3:
> 
> I picked Peff's two new constructive patches[1] which I think are meaningful.
> Peff also mentioned whether to design a "GIT_TRACE2_BITMAP" ENV to help
> debugging bitmap, and I think it's very interesting but maybe it's a bigger
> scale on current patchset, so I prefer to do it in another series.

I think the first two are already in 'next', so they aren't eligible for
re-roll, though from the range diff it looks like those changes are
already there?

-Peff
