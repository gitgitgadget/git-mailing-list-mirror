Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72268C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A86060FD7
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhGTUyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:54:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:55480 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231157AbhGTUxj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 16:53:39 -0400
Received: (qmail 5296 invoked by uid 109); 20 Jul 2021 21:34:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Jul 2021 21:34:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27842 invoked by uid 111); 20 Jul 2021 21:34:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Jul 2021 17:34:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Jul 2021 17:34:09 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH] pack-bitmap: clarify comment in
 filter_bitmap_exclude_type()
Message-ID: <YPdBUbiusnCfC84q@coredump.intra.peff.net>
References: <0d52628985bf4f499e0d5622ea40cdf499e73ebe.1626812121.git.me@ttaylorr.com>
 <YPc54AdUqD6T31ad@coredump.intra.peff.net>
 <YPc6p1lxX2AUggEu@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPc6p1lxX2AUggEu@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 05:05:43PM -0400, Taylor Blau wrote:

> On Tue, Jul 20, 2021 at 05:02:24PM -0400, Jeff King wrote:
> > Yep, this looks good. I wrote a near-identical patch while working on
> > [1], but that topic got stalled on "how is this part of partial clones
> > even supposed to work?". But there's no reason not to make this trivial
> > fix in isolation.
> 
> I'm not sure exactly which thread [1] is referring to, but I do recall
> the discussion now that you mention it.

Oops. :)

It was the one with: https://lore.kernel.org/git/YJ4mUJ+EEAnudI3G@coredump.intra.peff.net/

> I'm happy to add an "Original-patch-by" trailer or similar, although I
> suspect that you do not care ;).

Nah, mostly just thinking out loud since it seemed so familiar. :) And
hopefully producing the same patch independently is a form of
endorsement.

-Peff
