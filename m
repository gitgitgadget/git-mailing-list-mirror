Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEAFEE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjHUVzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjHUVzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:55:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC916133
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:55:19 -0700 (PDT)
Received: (qmail 18447 invoked by uid 109); 21 Aug 2023 21:55:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 21:55:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20984 invoked by uid 111); 21 Aug 2023 21:55:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 17:55:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 17:55:18 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/4] commit-graph: fsck zero/non-zero generation
 number fixes
Message-ID: <20230821215518.GA1811034@coredump.intra.peff.net>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1692653671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692653671.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023 at 05:34:32PM -0400, Taylor Blau wrote:

> Here's a(nother) small reroll of a series that I sent which expanded on
> a patch that Peff sent earlier in the thread to remove a section of
> unreachable code that was noticed by Coverity in the
> `verify_one_commit_graph()` function.
> 
> The first few patches are the same, but the fourth (now final) patch is
> modified to track a single example of a commit with zero and non-zero
> generation to only emit the warning once at the end of processing.

The end result looks good to me. I probably would have squashed at least
2+4 into one, and probably just squashed 3 into that as well. But I am
OK with it as-is, too, and it is definitely diminishing returns to keep
polishing it.

Thanks for assembling it into a usable form.

-Peff
