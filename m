Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22DFC43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DD72073B
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgC2OdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:33:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:54894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727167AbgC2OdX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 10:33:23 -0400
Received: (qmail 2069 invoked by uid 109); 29 Mar 2020 14:33:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 29 Mar 2020 14:33:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8990 invoked by uid 111); 29 Mar 2020 14:43:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Mar 2020 10:43:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 29 Mar 2020 10:33:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] t/README: suggest how to leave test early with failure
Message-ID: <20200329143322.GA14670@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
 <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
 <20200326083519.GD2200716@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
 <20200327091004.GA610157@coredump.intra.peff.net>
 <xmqqr1xdhev8.fsf@gitster.c.googlers.com>
 <20200328105418.GA639140@coredump.intra.peff.net>
 <xmqqpncwca6k.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpncwca6k.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 04:49:07PM -0700, Junio C Hamano wrote:

> Over time, we added the support to our test framework to make it
> easy to leave a test early with failure, but it was not clearly
> documented in t/README to help developers writing new tests.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

With the exception of the typo-fix from Eric, this looks good to
me. Thanks for tying this up.

-Peff
