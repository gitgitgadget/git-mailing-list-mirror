Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30460202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 07:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932319AbdIHHnA (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 03:43:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:60604 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932289AbdIHHnA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 03:43:00 -0400
Received: (qmail 23728 invoked by uid 109); 8 Sep 2017 07:42:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 07:42:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6543 invoked by uid 111); 8 Sep 2017 07:43:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 03:43:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 03:42:57 -0400
Date:   Fri, 8 Sep 2017 03:42:57 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/10] Implement transactions for the packed ref store
Message-ID: <20170908074257.tmdyj4wbij35fylq@sigill.intra.peff.net>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1503993268.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 10:20:24AM +0200, Michael Haggerty wrote:

> This should be the second-to-last patch series in the quest for
> mmapped packed-refs.

I just gave this a careful read, and it looks pretty good to me. I had a
few questions, but no show-stoppers. I'll admit to glossing a little bit
over the conversions in patch 3 and 4, after seeing that they're
basically adaptations of the code that goes away in patch 9.

-Peff
