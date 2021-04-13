Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D36EC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CF3613B1
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhDMHeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:34:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:50838 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240151AbhDMHeG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:34:06 -0400
Received: (qmail 28670 invoked by uid 109); 13 Apr 2021 07:33:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 07:33:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23207 invoked by uid 111); 13 Apr 2021 07:33:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 03:33:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 03:33:44 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/3] config: allow overriding global/system config
Message-ID: <YHVJWKKPkjw0+n/u@coredump.intra.peff.net>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1618297711.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 09:11:37AM +0200, Patrick Steinhardt wrote:

> this is the fourth version of my patch series to provide a way of
> overriding the global system configuration.
> 
> Compared to v3, I only dropped the special-casing of `/dev/null`. As
> Junio rightly pointed out, the special-casing was incomplete and would
> have required more work to do the right thing for all cases. It can
> still be re-added at a later point if the usecase actually comes up.

This version looks good to me. Thanks for working on this!

-Peff
