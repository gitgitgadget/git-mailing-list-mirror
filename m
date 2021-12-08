Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1C9C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbhLHT6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:58:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:46974 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239890AbhLHT6q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:58:46 -0500
Received: (qmail 11090 invoked by uid 109); 8 Dec 2021 19:55:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Dec 2021 19:55:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6529 invoked by uid 111); 8 Dec 2021 19:55:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Dec 2021 14:55:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Dec 2021 14:55:13 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 0/2] midx: prevent bitmap corruption when permuting pack
 order
Message-ID: <YbENofRtY0BPMEUd@coredump.intra.peff.net>
References: <cover.1638991570.git.me@ttaylorr.com>
 <bf100d0c-66c7-d402-4790-9c5797e8baf3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf100d0c-66c7-d402-4790-9c5797e8baf3@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 08, 2021 at 02:30:17PM -0500, Derrick Stolee wrote:

> > Taylor Blau (2):
> >   t5326: demonstrate bitmap corruption after permutation
> >   midx.c: make changing the preferred pack safe
> 
> Just chiming in to say that I reviewed an earlier version of this series
> and the version in this submission looks good to me.

Ditto. ;)

-Peff
