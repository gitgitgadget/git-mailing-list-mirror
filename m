Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7AFC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1ADA6103A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhHLTYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:24:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:45560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232877AbhHLTYo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 15:24:44 -0400
Received: (qmail 24267 invoked by uid 109); 12 Aug 2021 19:24:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 19:24:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24793 invoked by uid 111); 12 Aug 2021 19:24:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 15:24:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 15:24:17 -0400
From:   Jeff King <peff@peff.net>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] list-objects.c: rename "traverse_trees_and_blobs"
 to "traverse_non_commits"
Message-ID: <YRV1YUEyaSn64VEV@coredump.intra.peff.net>
References: <cover.1628757762.git.dyroneteng@gmail.com>
 <cover.1628758416.git.dyroneteng@gmail.com>
 <8548aa8bb1ee89b9cce677c7fa35005fa15c5435.1628758416.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8548aa8bb1ee89b9cce677c7fa35005fa15c5435.1628758416.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 04:59:31PM +0800, Teng Long wrote:

> Function `traverse_trees_and_blobs` not only works on trees and blobs,
> but also on tags, the function name is somewhat misleading. This commit
> rename it to `traverse_non_commits`.

Thanks, this version looks good to me.

-Peff
