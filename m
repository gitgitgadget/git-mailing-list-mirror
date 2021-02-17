Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B7AC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 00:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0DF64EAD
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 00:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhBQABz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 19:01:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:35218 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhBQABy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 19:01:54 -0500
Received: (qmail 15535 invoked by uid 109); 17 Feb 2021 00:01:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 00:01:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30934 invoked by uid 111); 17 Feb 2021 00:01:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 19:01:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 19:01:13 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/8] repack: support repacking into a geometric
 sequence
Message-ID: <YCxcyQcNO9LO2n9m@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612411123.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 03, 2021 at 10:58:45PM -0500, Taylor Blau wrote:

> The details of the new approach can be found in the third patch, but the gist is
> as follows:
> [...]

I think this turned out very nice (and less complicated than I feared it
might). I've read up through patch 5. I think the overall approach is
good, but I had various small-to-medium comments.

I'll try to pick up reviewing the rest tomorrow, though it may make
sense to resolve the earlier comments first.

-Peff
