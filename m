Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B1E20954
	for <e@80x24.org>; Thu,  7 Dec 2017 22:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbdLGWVq (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 17:21:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:51582 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750895AbdLGWVp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 17:21:45 -0500
Received: (qmail 1753 invoked by uid 109); 7 Dec 2017 22:21:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Dec 2017 22:21:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27586 invoked by uid 111); 7 Dec 2017 22:22:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 07 Dec 2017 17:22:06 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Dec 2017 17:21:43 -0500
Date:   Thu, 7 Dec 2017 17:21:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jacob.e.keller@intel.com
Subject: Re: [PATCH v2 5/7] diff: use skip-to-optional-val in parsing
 --relative
Message-ID: <20171207222143.GA14845@sigill.intra.peff.net>
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
 <20171207173034.12865-1-gitster@pobox.com>
 <20171207173034.12865-2-gitster@pobox.com>
 <20171207211102.GA12850@sigill.intra.peff.net>
 <xmqqpo7qb3n8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpo7qb3n8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 01:59:39PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Dec 07, 2017 at 09:30:32AM -0800, Junio C Hamano wrote:
> >
> >> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >> ---
> >
> > It might be worth mentioning why this conversion is pulled out from the
> > others (because its "default" case is "do not touch the pointer").
> 
> I am not sure what you mean by "pulled out from the others".  I did
> not intend to keep these 3 additional patches permanently; rather, I
> did them to help Christian's rerolling the series, and I do not think
> this one should be separate from other ones that use the _default()
> variant when that happens.

Ah, I see. I had thought you meant these to be applied on top.

-Peff
