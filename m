Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95CCF1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 01:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfHMBNB (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 21:13:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:41392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726296AbfHMBNB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 21:13:01 -0400
Received: (qmail 31608 invoked by uid 109); 13 Aug 2019 01:13:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 13 Aug 2019 01:13:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28142 invoked by uid 111); 13 Aug 2019 01:15:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2019 21:15:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Aug 2019 21:13:00 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/2] path: add a function to check for path suffix
Message-ID: <20190813011259.GA18065@sigill.intra.peff.net>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-2-sandals@crustytoothpaste.net>
 <xmqq1rxrcjfp.fsf@gitster-ct.c.googlers.com>
 <20190812011054.GA9180@genre.crustytoothpaste.net>
 <xmqq7e7iba7j.fsf@gitster-ct.c.googlers.com>
 <20190812224021.GA229582@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190812224021.GA229582@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 10:40:21PM +0000, brian m. carlson wrote:

> I think "ends_with_path_components" might be the way forward, unless
> you think something else would be better.

FWIW, having read the rest of the thread, that was the name that clicked
for me.

-Peff
