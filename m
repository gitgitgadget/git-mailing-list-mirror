Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C2CC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF400611C5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhIJOzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:55:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:43970 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhIJOzj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:55:39 -0400
Received: (qmail 5951 invoked by uid 109); 10 Sep 2021 14:54:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:54:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25854 invoked by uid 111); 10 Sep 2021 14:54:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:54:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:54:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 2/8] INSTALL: mention that we need libcurl 7.19.4 or
 newer to build
Message-ID: <YTtxo/HKYDTOJBvh@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <patch-v2-2.8-4b653cee2d3-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-2.8-4b653cee2d3-20210910T105523Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 01:04:27PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Without NO_CURL=Y we require at least version "7.19.4" of libcurl, see
> 644de29e220 (http: drop support for curl < 7.19.4, 2021-07-30). Let's
> document this in the "INSTALL" document.

Makes sense.

> diff --git a/INSTALL b/INSTALL
> index 5c6ecf03c27..81f3a6cf018 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -141,6 +141,9 @@ Issues of note:
>  	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
>  	  the curl version >= 7.34.0, for git-imap-send.
>  
> +	  Git version "7.19.4" of "libcurl" or later to build. This
> +	  version requirement may be bumped in the future.
> +

s/to build/is needed &/ or similar?

-Peff
