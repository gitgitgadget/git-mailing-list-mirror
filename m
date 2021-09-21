Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB991C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 14:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF3461211
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 14:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhIUORs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 10:17:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:51704 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232919AbhIUORr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 10:17:47 -0400
Received: (qmail 5643 invoked by uid 109); 21 Sep 2021 14:16:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 14:16:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 832 invoked by uid 111); 21 Sep 2021 14:16:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 10:16:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 10:16:18 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        liu.denton@gmail.com
Subject: Re: [PATCH v2] ls-files: use imperative mood for -X and -z option
 description
Message-ID: <YUnpMgw+GSM8I4DK@coredump.intra.peff.net>
References: <20210921111304.887605-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921111304.887605-1-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 06:13:05PM +0700, Bagas Sanjaya wrote:

> Usage description for -X and -z options use descriptive instead of
> imperative mood. Edit it for consistency with other options.

Thanks, this version looks fine to me.

-Peff
