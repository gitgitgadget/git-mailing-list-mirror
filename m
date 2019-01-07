Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81B61F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfAGItI (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:49:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:56438 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726496AbfAGItI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:49:08 -0500
Received: (qmail 2672 invoked by uid 109); 7 Jan 2019 08:49:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:49:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 928 invoked by uid 111); 7 Jan 2019 08:48:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:48:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:49:06 -0500
Date:   Mon, 7 Jan 2019 03:49:06 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 0/8] test-lib: add the '--stress' option to help
 reproduce occasional failures in flaky tests
Message-ID: <20190107084906.GA30186@sigill.intra.peff.net>
References: <20181230191629.3232-1-szeder.dev@gmail.com>
 <20190105010859.11031-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190105010859.11031-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 05, 2019 at 02:08:51AM +0100, SZEDER Gábor wrote:

> To recap: this patch series tries to make reproducing rare failures in
> flaky tests easier: it adds the '--stress' option to our test library
> to run the test script repeatedly in multiple parallel jobs, in the
> hope that the increased load creates enough variance in the timing of
> the test's commands that such a failure is eventually triggered.

Thanks, I looked over this version (glossing over the bits that hadn't
really changed since v2) and it all looks good to me.

-Peff
