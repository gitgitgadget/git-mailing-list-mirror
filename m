Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845C2C433FE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F0661B6F
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhKSPG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:06:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:34924 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232110AbhKSPGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 10:06:25 -0500
Received: (qmail 8405 invoked by uid 109); 19 Nov 2021 15:03:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 15:03:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13419 invoked by uid 111); 19 Nov 2021 15:03:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 10:03:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 10:03:17 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/2] CI: use shorter names for CI jobs, less truncation
Message-ID: <YZe8tXc3rT18KF1M@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 02:56:05PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This changes the names used in GitHub CI to be shorter, because the
> current ones are so long that they overflow the pop-up tooltips in the
> GitHub UI.
> 
> New pop-up visible at: https://github.com/avar/git/tree/avar/ci-shorter-names
> 
> Full CI run at (currently pending, I had a trivial last-minute
> update):
> https://github.com/avar/git/runs/4264929546?check_suite_focus=true

Thanks for giving examples. I don't have a strong opinion on the first
patch, as I never look at those pop-ups anyway. ;) It does also shorten
the names in the main "runs" page, where we had room to show them fully.

To my mind, "linux-gcc", etc, are more readable than "regular
(linux-gcc, gcc, ubuntu-latest)", and that's a strict improvement. "w32"
versus "windows" is less obviously good, but I'm OK with it if the
shortness is important in some contexts.

-Peff
