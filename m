Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67265C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E09B60FF0
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhGLURk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:17:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:46996 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233478AbhGLURk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:17:40 -0400
Received: (qmail 21753 invoked by uid 109); 12 Jul 2021 20:14:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jul 2021 20:14:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2011 invoked by uid 111); 12 Jul 2021 20:14:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 16:14:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 16:14:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] add missing __attribute__((format))
Message-ID: <YOyiul2XXZfNrNXa@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 10, 2021 at 10:47:26AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Adds missing add missing __attribute__((format)) in various places,
> which improves compile-time checking.

Thanks, this is definitely worth doing. There were more of these than I
expected.

Patches 1-3 look obviously good. I didn't double-check all of your
parameter-numbers, but the compiler should make it painfully obvious if
you got any wrong. :)

I'm iffy on the strftime and compat things in the latter patches; I left
more detailed responses there.

-Peff
