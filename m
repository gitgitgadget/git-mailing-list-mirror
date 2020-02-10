Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE9AC352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7CD20838
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBJWZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:25:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:56920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727254AbgBJWZT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:25:19 -0500
Received: (qmail 3012 invoked by uid 109); 10 Feb 2020 22:25:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Feb 2020 22:25:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26783 invoked by uid 111); 10 Feb 2020 22:34:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Feb 2020 17:34:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Feb 2020 17:25:18 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] parse-options: simplify parse_options_concat() and
 parse_options_dup()
Message-ID: <20200210222518.GB623231@coredump.intra.peff.net>
References: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 09, 2020 at 04:53:46PM +0100, René Scharfe wrote:

> Reduce code duplication.
> 
> René Scharfe (4):
>   parse-options: use COPY_ARRAY in parse_options_concat()
>   parse-options: factor out parse_options_count()
>   parse-options: const parse_options_concat() parameters
>   parse-options: simplify parse_options_dup()

I read all 4 and they looked good to me.

-Peff
