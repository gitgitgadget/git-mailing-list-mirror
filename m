Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DEF1F406
	for <e@80x24.org>; Thu, 10 May 2018 15:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966178AbeEJPG0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 11:06:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:34930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966166AbeEJPGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 11:06:17 -0400
Received: (qmail 6994 invoked by uid 109); 10 May 2018 15:06:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 15:06:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25217 invoked by uid 111); 10 May 2018 15:06:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 11:06:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 11:06:15 -0400
Date:   Thu, 10 May 2018 11:06:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 2/6] sha1-array.h: align function arguments
Message-ID: <20180510150615.GA6462@sigill.intra.peff.net>
References: <20180501184016.15061-10-avarab@gmail.com>
 <20180510124303.6020-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180510124303.6020-3-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 12:42:59PM +0000, Ævar Arnfjörð Bjarmason wrote:

> The arguments weren't lined up with the opening parenthesis. Fixes up
> code added in aae0caf19e ("sha1-array.h: align function arguments",
> 2018-04-30).

I think that's this patch. :)

Presumably you meant 910650d2f8 (Rename sha1_array to oid_array,
2017-03-31)?

-Peff
