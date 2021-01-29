Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F0C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3354964DED
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhA2BHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:07:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:42798 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231713AbhA2BGf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:06:35 -0500
Received: (qmail 20785 invoked by uid 109); 29 Jan 2021 01:05:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 01:05:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4505 invoked by uid 111); 29 Jan 2021 01:05:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 20:05:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 20:05:41 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 10/10] t5325: check both on-disk and in-memory reverse
 index
Message-ID: <YBNfZeRiHgQwSqGq@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <38c8afabf25a7f5e144850938cf00b53e9cf25fd.1611617820.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38c8afabf25a7f5e144850938cf00b53e9cf25fd.1611617820.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 06:37:51PM -0500, Taylor Blau wrote:

> Right now, the test suite can be run with 'GIT_TEST_WRITE_REV_INDEX=1'
> in the environment, which causes all operations which write a pack to
> also write a .rev file.
> 
> To prepare for when that eventually becomes the default, we should
> continue to test the in-memory reverse index, too, in order to avoid
> losing existing coverage. Unfortuantely, explicit existing coverage is
> rather sparse, so only a basic test is added.

Oh, I forgot to mention: if re-rolling, s/fortuan/fortuna/.

-Peff
