Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C113C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CC9560FF3
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbhGUKnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 06:43:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:52990 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237539AbhGUJaO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:30:14 -0400
Received: (qmail 1884 invoked by uid 109); 21 Jul 2021 10:10:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 10:10:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2861 invoked by uid 111); 21 Jul 2021 10:10:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 06:10:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 06:10:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 04/24] Documentation: build 'technical/bitmap-format'
 by default
Message-ID: <YPfyqKdzB6HV5onf@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com>
 <87bl7uzvaf.fsf@evledraar.gmail.com>
 <YO8h0smhBPuIjFAa@nand.local>
 <87eec0zej2.fsf@evledraar.gmail.com>
 <YPfxH9RW6QGjZlQv@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPfxH9RW6QGjZlQv@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 06:04:15AM -0400, Jeff King wrote:

> The git-scm.com site doesn't use our Documentation/Makefile, so it has
> been building the bitmap-format page for a while. It doesn't look
> correct, though (it is missing everything before the "on-disk format"
> section).

Doh, nevermind. That nice header section does not exist before Taylor's
series. ;)

The git-scm.com page does seem to throw away the "GIT bitmap v1 format"
title entirely. And it suffers the same rendering problems I saw when
building with asciidoc locally.

-Peff
