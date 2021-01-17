Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B6C433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6903E207B6
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 16:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbhAQQtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 11:49:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:58504 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbhAQQtl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 11:49:41 -0500
Received: (qmail 21286 invoked by uid 109); 17 Jan 2021 16:48:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Jan 2021 16:48:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16106 invoked by uid 111); 17 Jan 2021 16:48:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Jan 2021 11:48:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 17 Jan 2021 11:48:54 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] test-lib: add tests for test_might_fail
Message-ID: <YARqdkrxJEW79PYQ@coredump.intra.peff.net>
References: <YAFiFW7D1qD7ZJ8I@coredump.intra.peff.net>
 <20210116144147.14036-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210116144147.14036-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 16, 2021 at 03:41:47PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > The title confuses me. Isn't might_fail like "must_fail ok=success"?
> >
> > And certainly the code here shows us expecting the _opposite_ of what
> > "Must_fail ok=" does.
> 
> Yes, this made no sense. Here's a sensibe test.
> 
> Junio: This is a stand-alone patch now. I'm splitting this off from my
> WIP v2 of the "set -o pipefail" series.

OK, I'm glad I wasn't just missing something. :) This one makes sense to
me, and seems like a reasonable thing to be checking.

-Peff
