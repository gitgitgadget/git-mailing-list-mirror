Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0D4202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750810AbdJBFiY (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:38:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:57162 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750763AbdJBFiX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:38:23 -0400
Received: (qmail 7038 invoked by uid 109); 2 Oct 2017 05:38:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:38:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25813 invoked by uid 111); 2 Oct 2017 05:39:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:39:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:38:21 -0400
Date:   Mon, 2 Oct 2017 01:38:21 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/11] tempfile: fix documentation on `delete_tempfile()`
Message-ID: <20171002053821.itkkmi2png3m6gdw@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com>
 <17640b932b49cf86d53a0149300f65f01bff9135.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17640b932b49cf86d53a0149300f65f01bff9135.1506862824.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:56:05PM +0200, Martin Ågren wrote:

> The function has always been documented as returning 0 or -1. It is in
> fact `void`. Correct that. As part of the rearrangements we lose the
> mention that `delete_tempfile()` might set `errno`. Because there is
> no return value, the user can't really know whether it did anyway.

Right, your documentation change makes sense. Thanks for catching this.

I was curious if this inconsistency was introduced during review, but
even the initial version to the list returns void. So I guess it
happened sometime during the writing. :)

-Peff
