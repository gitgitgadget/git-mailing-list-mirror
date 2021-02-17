Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648ADC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3208164E5F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhBQSTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:19:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:36030 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhBQSTh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 13:19:37 -0500
Received: (qmail 19384 invoked by uid 109); 17 Feb 2021 18:18:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 18:18:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6840 invoked by uid 111); 17 Feb 2021 18:18:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 13:18:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 13:18:55 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/8] repack: support repacking into a geometric
 sequence
Message-ID: <YC1eD+m5acCpyEf2@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <YCxcyQcNO9LO2n9m@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCxcyQcNO9LO2n9m@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 07:01:13PM -0500, Jeff King wrote:

> On Wed, Feb 03, 2021 at 10:58:45PM -0500, Taylor Blau wrote:
> 
> > The details of the new approach can be found in the third patch, but the gist is
> > as follows:
> > [...]
> 
> I think this turned out very nice (and less complicated than I feared it
> might). I've read up through patch 5. I think the overall approach is
> good, but I had various small-to-medium comments.
> 
> I'll try to pick up reviewing the rest tomorrow, though it may make
> sense to resolve the earlier comments first.

OK, I finished reading the rest and left a few more comments. The short
of it is that I really like the new direction, but I think there are
enough small comments to merit a re-roll, which I hope would probably be
the final.

-Peff
