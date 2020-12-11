Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD45C49EC9
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED2623A33
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 01:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406059AbgLKOWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 09:22:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:58236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406046AbgLKOWX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 09:22:23 -0500
Received: (qmail 9096 invoked by uid 109); 11 Dec 2020 14:21:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Dec 2020 14:21:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7053 invoked by uid 111); 11 Dec 2020 14:21:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Dec 2020 09:21:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Dec 2020 09:21:38 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
Message-ID: <X9OAcgPxyYIJo+J/@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
 <871rfzxctq.fsf@evledraar.gmail.com>
 <X9D6IyPchkGkYgeB@coredump.intra.peff.net>
 <X9NzEfzjvdnvnX42@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X9NzEfzjvdnvnX42@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 02:24:33PM +0100, Patrick Steinhardt wrote:

> Do you want me to adopt your patches as part of this series?

Yeah, if you're willing to. I don't mind spinning it off into its own
series if you don't want to (the tricky part is that we're touching a
couple of the same spots, though, so if you're willing to pick them up,
I think that makes coordination easier).

-Peff
