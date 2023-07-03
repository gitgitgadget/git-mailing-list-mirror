Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C239EB64DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGCG33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCG31 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:29:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2EBA
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:29:26 -0700 (PDT)
Received: (qmail 12457 invoked by uid 109); 3 Jul 2023 06:29:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:29:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2494 invoked by uid 111); 3 Jul 2023 06:29:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:29:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:29:25 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 00/16] refs: implement jump lists for packed backend
Message-ID: <20230703062925.GK3502534@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 10:20:51AM -0400, Taylor Blau wrote:

> Here is another reroll of my series to implement jump (née skip) lists
> for the packed refs backend, based on top of the current 'master'.
> 
> Most changes are minor, limited to changing variable names, moving
> changes around between patches and tweaking commit messages for clarity.
> I think that the first 9 or so patches are stable, but we may want some
> more eyes on the remainder.

I had been avoiding reading this series too carefully, as I was involved
in many of the early patches. But now it's been long enough that I
mostly forgot everything, so I could look at it with fresh eyes. ;) Plus
the hidden-refs bits at the end were totally new to me.

It looks good to me overall. I left a few small comments, some of which
I think probably justify a re-roll.

-Peff
