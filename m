Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F84A1FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 06:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753867AbcLaGrw (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 01:47:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:33503 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbcLaGrw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 01:47:52 -0500
Received: (qmail 12023 invoked by uid 109); 31 Dec 2016 06:47:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 06:47:51 +0000
Received: (qmail 2255 invoked by uid 111); 31 Dec 2016 06:48:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 01:48:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Dec 2016 01:47:46 -0500
Date:   Sat, 31 Dec 2016 01:47:46 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 00/23] Delete directories left empty after ref deletion
Message-ID: <20161231064746.6bvis76p5x5ubc2b@sigill.intra.peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 04:12:40AM +0100, Michael Haggerty wrote:

> This is a re-roll of an old patch series. v1 [1] got some feedback,
> which I think was all addressed in v2 [2]. But it seems that v2 fell
> on the floor, and I didn't bother following up because it was in the
> same area of code that was undergoing heavy changes due to the
> pluggable reference backend work. Sorry for the long delay before
> getting back to it.

I've read through the whole thing, and aside from a few very minor nits
(that I am not even sure are worth a re-roll), I didn't see anything
wrong. And the overall goal and approach seem obviously sound.

> Michael Haggerty (23):

I'll admit to being daunted by the number of patches, but it was quite a
pleasant and easy read. Thanks.

-Peff
