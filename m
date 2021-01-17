Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81468C433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517FD2076C
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 16:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbhAQQs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 11:48:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:58486 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbhAQQs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 11:48:26 -0500
Received: (qmail 21260 invoked by uid 109); 17 Jan 2021 16:47:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Jan 2021 16:47:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16099 invoked by uid 111); 17 Jan 2021 16:47:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Jan 2021 11:47:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 17 Jan 2021 11:47:41 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/11] git-svn tests: rewrite brittle tests to use
 "--[no-]merges".
Message-ID: <YARqLXG4diPxBKC0@coredump.intra.peff.net>
References: <20210114233515.31298-1-avarab@gmail.com>
 <20210116153554.12604-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210116153554.12604-7-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 16, 2021 at 04:35:49PM +0100, Ævar Arnfjörð Bjarmason wrote:

> From: Jeff King <peff@peff.net>
> 
> Rewrite a brittle tests which used "rev-list" without "--[no-]merges"
> to figure out if a set of commits turned into merge commits or not.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Commit-message-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Thanks for picking this up. I think it's a cleanup worth doing.

I didn't actually sign-off the original I sent, though. I'm quite happy
to do so now, and in general everything I send to the list as a
"something like this" patch will be done with the intent that it could
be contributed under the DCO. But I think in such a case, we should stop
short of forging the signoff. And ideally get an explicit signoff, or
lacking that just add your own to assert DCO's paragraph (b).

Anyway, this is most definitely:

  Signed-off-by: Jeff King <peff@peff.net>

-Peff
