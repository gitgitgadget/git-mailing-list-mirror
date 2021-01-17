Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692EDC433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 16:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33559207AE
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 16:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbhAQQv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 11:51:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:58512 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbhAQQvW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 11:51:22 -0500
Received: (qmail 21315 invoked by uid 109); 17 Jan 2021 16:50:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Jan 2021 16:50:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16119 invoked by uid 111); 17 Jan 2021 16:50:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Jan 2021 11:50:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 17 Jan 2021 11:50:38 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/11] tests: add a bash "set -o pipefail" test mode
Message-ID: <YARq3v8DYEKO9zOM@coredump.intra.peff.net>
References: <20210114233515.31298-1-avarab@gmail.com>
 <20210116153554.12604-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210116153554.12604-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 16, 2021 at 04:35:43PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I've now ejected all of that, in favor of just fixing some of the
> tests instead as Jeff suggested. Jeff, I added your Signed-off-by to
> 06/11 which you're mostly the author of. Please Ack that you're OK
> with that (the original diff-for-discussin didn't have a SOB).

Oh, I just wrote my other response before reading this (reading emails
in order? Preposterous!). So you can soften my lecture on S-o-b while
reading that one. :)

And just to repeat what I said there: yes, my signoff is fine there.

-Peff
