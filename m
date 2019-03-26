Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E520202BB
	for <e@80x24.org>; Tue, 26 Mar 2019 16:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbfCZQYa (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 12:24:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:36734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731776AbfCZQY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 12:24:29 -0400
Received: (qmail 15399 invoked by uid 109); 26 Mar 2019 16:24:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 16:24:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20528 invoked by uid 111); 26 Mar 2019 16:24:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 12:24:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 12:24:27 -0400
Date:   Tue, 26 Mar 2019 12:24:27 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Asciidoctor-related formatting and CI fixes
Message-ID: <20190326162427.GB29627@sigill.intra.peff.net>
References: <20190324155219.2284-1-szeder.dev@gmail.com>
 <20190324215534.9495-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190324215534.9495-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 10:55:28PM +0100, SZEDER Gábor wrote:

> The first three patches fix formatting issues with Asciidoctor; they
> are the same patches that I sent earlier today, except some commit
> message updates (now they mention the Asciidoctor version which
> started to issue the warning, and I fixed that missing half-sentence
> in one of the commit messages).
> 
> The last three patches are a small cleanup and fixes to the
> documentation CI build jobs; notably patch 5 un-breaks the
> documentation build job on Travis CI in the era of Asciidoctor v2.0.0
> [1], and patch 5 fixes some forever-broken checks.
> 
> The formatting and CI fixes are not really related, but the check
> fixed in patch 6 would choke without the formatting fixes silencing
> warnings from Asciidoctor, that's why I send them in the same patch
> series.

Thanks, these all look good to me (I do agree with Dscho that the
"Documentation" subtlety in patch 4 might be worth calling out in the
commit message).

-Peff
