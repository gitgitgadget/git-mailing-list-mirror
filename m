Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7D5C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 05:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6F82070B
	for <git@archiver.kernel.org>; Fri,  1 May 2020 05:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgEAF7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 01:59:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:33272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726452AbgEAF7s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 01:59:48 -0400
Received: (qmail 1753 invoked by uid 109); 1 May 2020 05:59:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 May 2020 05:59:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15400 invoked by uid 111); 1 May 2020 05:52:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2020 01:52:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 May 2020 01:52:25 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v3 0/5] commit-graph: write non-split graphs as read-only
Message-ID: <20200501055225.GA23665@coredump.intra.peff.net>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588181626.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588181626.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 11:36:26AM -0600, Taylor Blau wrote:

> Here's a brief reroll to incorporate suggestions from Junio and Peff in
> the sub-thread beginning at [1]. Not much at all has changed since v2,
> with the exception of:
> 
>   * fixing the aforementioned issue by sprinkling in some 'umask 022's
>     in throughout the new tests
> 
>   * adding in a new final patch to apply the same treatment to
>     the 'commit-graph-chain' file

Thanks, this version looks good to me.

-Peff
