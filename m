Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5CC920248
	for <e@80x24.org>; Fri, 22 Feb 2019 15:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfBVPVM (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 10:21:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:54478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725892AbfBVPVM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 10:21:12 -0500
Received: (qmail 1741 invoked by uid 109); 22 Feb 2019 15:21:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 15:21:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28826 invoked by uid 111); 22 Feb 2019 15:21:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 10:21:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 10:21:10 -0500
Date:   Fri, 22 Feb 2019 10:21:10 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v2 4/6] Makefile: Move *_LIBS assignment into its own
 section
Message-ID: <20190222152110.GB21524@sigill.intra.peff.net>
References: <20190222105658.26831-1-avarab@gmail.com>
 <20190222144127.32248-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222144127.32248-5-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 03:41:25PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Now the only other non-program assignment in the previous list is
> PTHREAD_CFLAGS, which'll be moved elsewhere in a follow-up chang.

Hmm. I get why this organization might make sense. But it also might be
convenient to see all of the pthread-related flags/libs together.

I dunno. I guess we are not expecting people to touch these manually
anyway, so it may not matter.

-Peff
