Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17B6C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFC161401
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhKSPAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:00:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:34910 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhKSPAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 10:00:45 -0500
Received: (qmail 8374 invoked by uid 109); 19 Nov 2021 14:57:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 14:57:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13338 invoked by uid 111); 19 Nov 2021 14:57:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 09:57:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 09:57:42 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/2] CI: rename the "Linux32" job to lower-case "linux32"
Message-ID: <YZe7ZhGbLIh4I18e@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
 <patch-2.2-9b8a3f0cdc4-20211119T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.2-9b8a3f0cdc4-20211119T135343Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 02:56:07PM +0100, Ævar Arnfjörð Bjarmason wrote:

> As a follow-up to the preceding commit's shortening of CI job names,
> rename the only job that starts with an upper-case letter to be
> consistent with the rest. It was added in 88dedd5e72c (Travis: also
> test on 32-bit Linux, 2017-03-05).

This makes sense, though I had to wonder...

>  .travis.yml                       | 2 +-

Is this travis file even still useful? With travis-ci.org shutting down
last summer, I would think nobody is triggering these builds anymore.

Not a blocker, obviously, but maybe a possible cleanup on top.

-Peff
