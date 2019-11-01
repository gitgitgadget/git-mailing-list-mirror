Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392B21F454
	for <e@80x24.org>; Fri,  1 Nov 2019 16:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfKAQyQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 12:54:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:36296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727327AbfKAQyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 12:54:16 -0400
Received: (qmail 27720 invoked by uid 109); 1 Nov 2019 16:54:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Nov 2019 16:54:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12336 invoked by uid 111); 1 Nov 2019 16:57:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Nov 2019 12:57:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Nov 2019 12:54:15 -0400
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] t0028: eliminate non-standard usage of printf
Message-ID: <20191101165415.GB26219@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1572596278.git.congdanhqx@gmail.com>
 <8b3002842537355c2387cb55f52c10ad8a7dd530.1572596278.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b3002842537355c2387cb55f52c10ad8a7dd530.1572596278.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 01, 2019 at 03:25:09PM +0700, Doan Tran Cong Danh wrote:

> man 1p printf:
>    In addition to the escape sequences shown in the Base Definitions
>    volume of POSIX.1‐2008, Chapter 5, File Format Notation ('\\',
>    '\a', '\b', '\f', '\n', '\r', '\t', '\v'), "\ddd", where ddd is a
>    one, two, or three-digit octal number, shall be written as a byte
>    with the numeric value specified by the octal number.
> 
> printf '\xfe\xff' in an extension of some shell.

Typo: s/in/is/

Other than that, this looks great to me. Thanks.

-Peff
