Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84947C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 17:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE7823B3E
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 17:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbgLHR5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 12:57:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:56672 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730203AbgLHR5L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 12:57:11 -0500
Received: (qmail 14010 invoked by uid 109); 8 Dec 2020 17:56:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Dec 2020 17:56:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2534 invoked by uid 111); 8 Dec 2020 17:56:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Dec 2020 12:56:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Dec 2020 12:56:29 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: New sharness/test vim syntax
Message-ID: <X8++TTnv95IAIkZL@coredump.intra.peff.net>
References: <CAMP44s1D-Zp3KDS+Hi74a=Lkc7Nc_0qiEzQEF0Pmj=bD8i+=JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s1D-Zp3KDS+Hi74a=Lkc7Nc_0qiEzQEF0Pmj=bD8i+=JQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 26, 2020 at 04:24:42AM -0600, Felipe Contreras wrote:

> It gets a bit tedious to see all the tests in the same color, so I
> wrote my own vim syntax file so that at least the body of
> test_expect_success is highlighted properly.

Thanks for sharing this. Over the years I've gotten used to the horrible
all-red view when editing our test scripts, but I'm looking forward to
leaving that behind. :)

-Peff
