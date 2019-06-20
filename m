Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D351F461
	for <e@80x24.org>; Thu, 20 Jun 2019 18:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfFTSXm (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 14:23:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:46230 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726852AbfFTSXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 14:23:41 -0400
Received: (qmail 24900 invoked by uid 109); 20 Jun 2019 18:23:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 18:23:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17392 invoked by uid 111); 20 Jun 2019 18:24:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 14:24:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 14:23:39 -0400
Date:   Thu, 20 Jun 2019 14:23:39 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 09/17] object: convert create_object() to use object_id
Message-ID: <20190620182339.GA18704@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
 <20190620074121.GI3713@sigill.intra.peff.net>
 <b69ddbda-b24f-bb67-30b3-206fd21c2e53@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b69ddbda-b24f-bb67-30b3-206fd21c2e53@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 03:21:43PM +0100, Ramsay Jones wrote:

> 
> 
> On 20/06/2019 08:41, Jeff King wrote:
> > There are no callers left of lookup_object() that aren't just passing us
> 
> s/lookup_object/create_object/

Heh, thanks. I took a final pass at these commit messages to normalize
them, since they are all basically doing the same thing, and obviously I
screwed up a bit of cut-and-paste.

(Normally I'd say that is a sign they should be lumped together, but the
diffs are so noisy due to the caller updates that I think it was worth
keeping them split).

-Peff
