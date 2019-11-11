Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630B51F454
	for <e@80x24.org>; Mon, 11 Nov 2019 08:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfKKIk0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 03:40:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:44306 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726791AbfKKIk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 03:40:26 -0500
Received: (qmail 17990 invoked by uid 109); 11 Nov 2019 08:40:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 08:40:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3992 invoked by uid 111); 11 Nov 2019 08:43:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 03:43:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 03:40:25 -0500
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v6 0/9] sequencer: handle other encoding better
Message-ID: <20191111084025.GD17984@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573452046.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1573452046.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 01:03:33PM +0700, Doan Tran Cong Danh wrote:

> Change from v5:
> - claim t3434 instead of t3433
> 
> Doan Tran Cong Danh (9):
>   t0028: eliminate non-standard usage of printf
>   configure.ac: define ICONV_OMITS_BOM if necessary
>   t3900: demonstrate git-rebase problem with multi encoding
>   sequencer: reencode to utf-8 before arrange rebase's todo list
>   sequencer: reencode revert/cherry-pick's todo list
>   sequencer: reencode squashing commit's message
>   sequencer: reencode old merge-commit message
>   sequencer: reencode commit message for am/rebase --show-current-patch
>   sequencer: fallback to sane label in making rebase todo list

Thanks, these all look pretty sensible to me. I left a few small
comments on patch 9.

(I see you took my suggestion regarding the test quoting, too. Thanks!)

-Peff
