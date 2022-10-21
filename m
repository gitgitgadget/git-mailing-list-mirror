Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E7CC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJUFxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJUFxN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:53:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D67230831
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:53:12 -0700 (PDT)
Received: (qmail 10603 invoked by uid 109); 21 Oct 2022 05:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 05:53:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1967 invoked by uid 111); 21 Oct 2022 05:53:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 01:53:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 01:53:11 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 0/6] shortlog: introduce `--group=<format>`
Message-ID: <Y1Izx2Gw4C7dJEex@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666320509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 11:11:25PM -0400, Taylor Blau wrote:

> Here is a reroll of my series to implement arbitrary pretty formats as
> shortlog `--group`'s, based on a suggestion from Jacob Stopak.
> 
> The changes are somewhat minimal, including a rebase onto the current
> tip of master. Less minimal, however, is dropping the reimplementation
> of `--group=trailer:<key>` in terms of the format group, since this
> ended up being more trouble than it was worth.
> 
> There are also a handful of small tweaks throughout based on feedback
> from Peff.

Thanks. This mostly looks good to me, though I think there are a few doc
and test nits that make it worth one more reroll. I had various style
and ordering suggestions, too. I'll leave it to you whether you think
it's worth taking any of them during the re-roll, or just ignoring them. :)

-Peff
