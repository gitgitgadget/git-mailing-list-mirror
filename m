Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75781C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2A160F9F
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbhIMRDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:03:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:46342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241629AbhIMRDk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 13:03:40 -0400
Received: (qmail 20619 invoked by uid 109); 13 Sep 2021 17:02:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Sep 2021 17:02:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11717 invoked by uid 111); 13 Sep 2021 17:02:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Sep 2021 13:02:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Sep 2021 13:02:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH v4 0/9] post-v2.33 "drop support for ancient curl"
 follow-up
Message-ID: <YT+EH1O+kPrf4T8j@coredump.intra.peff.net>
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 04:51:20PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This is a hopefully final re-roll with a small grammar improvement in
> 3/8. See range-diff, pointed out/requested at
> https://lore.kernel.org/git/YTzBUFY4p6obEqF+@coredump.intra.peff.net/

Well, I did say "no need to re-roll". :) But thank you for addressing
it. This version looks good to me.

-Peff
