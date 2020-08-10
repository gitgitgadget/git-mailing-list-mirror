Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A1AC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 10:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EEF20709
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 10:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgHJKCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 06:02:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:53906 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgHJKCu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 06:02:50 -0400
Received: (qmail 20299 invoked by uid 109); 10 Aug 2020 10:02:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Aug 2020 10:02:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4254 invoked by uid 111); 10 Aug 2020 10:02:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Aug 2020 06:02:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Aug 2020 06:02:49 -0400
From:   Jeff King <peff@peff.net>
To:     Emma Brooks <me@pluvano.com>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
Message-ID: <20200810100249.GC37030@coredump.intra.peff.net>
References: <20200808213457.13116-1-me@pluvano.com>
 <20200809230436.2152-1-me@pluvano.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200809230436.2152-1-me@pluvano.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 09, 2020 at 11:04:37PM +0000, Emma Brooks wrote:

> Add an option to map names and emails to their canonical forms via a
> .mailmap file. This is enabled by default, consistent with the behavior
> of Git itself.
> 
> Signed-off-by: Emma Brooks <me@pluvano.com>
> ---
> 
> No code changes. I just fixed a typo in the commit subject (made "map"
> lower-case).

There was a little discussion in response to v1 on whether we could
reuse the existing C mailmap code:

  https://lore.kernel.org/git/20200731010129.GD240563@coredump.intra.peff.net/

Did you have any thoughts on that?

-Peff
