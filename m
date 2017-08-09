Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95AAD208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 20:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbdHIUXq (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 16:23:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:33746 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752202AbdHIUXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 16:23:45 -0400
Received: (qmail 25870 invoked by uid 109); 9 Aug 2017 20:23:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 20:23:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30888 invoked by uid 111); 9 Aug 2017 20:24:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 16:24:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 16:23:42 -0400
Date:   Wed, 9 Aug 2017 16:23:42 -0400
From:   Jeff King <peff@peff.net>
To:     Ian Campbell <ijc@hellion.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] filter-branch: Handle rewritting (very) old style
 tags which lack tagger
Message-ID: <20170809202342.si5d72s44v3xywvq@sigill.intra.peff.net>
References: <1502179560.2735.22.camel@hellion.org.uk>
 <20170808080620.9536-2-ijc@hellion.org.uk>
 <20170809102040.l5sb6ukqh2225zqm@sigill.intra.peff.net>
 <xmqqlgms7nbl.fsf@gitster.mtv.corp.google.com>
 <1502305353.2735.33.camel@hellion.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1502305353.2735.33.camel@hellion.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 08:02:33PM +0100, Ian Campbell wrote:

> > > Should we instead make git-mktag more lenient (possibly with a
> > > command-line option to reduce accidental omissions)?
> > 
> > That sounds sensible. Thanks for injecting a dose of sanity.
> 
> Indeed. I'll add a --allow-missing-tagger option (suggestions for a
> snappier name accepted!) and pass it unconditionally from the filter-
> branch script.

I think that name is the right amount of snappy. It's not meant to be
used very often. :)

-Peff
