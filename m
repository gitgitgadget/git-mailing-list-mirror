Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8786620357
	for <e@80x24.org>; Tue, 11 Jul 2017 10:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755274AbdGKKsA (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 06:48:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:36866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754550AbdGKKr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 06:47:58 -0400
Received: (qmail 3390 invoked by uid 109); 11 Jul 2017 10:47:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 10:47:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15265 invoked by uid 111); 11 Jul 2017 10:48:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 06:48:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 06:47:56 -0400
Date:   Tue, 11 Jul 2017 06:47:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 0/7] tag: more fine-grained pager-configuration
Message-ID: <20170711104755.4z5exp43lvwbb5hq@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <xmqqpod752yh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpod752yh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 03:42:14PM -0700, Junio C Hamano wrote:

> > A review would be much appreciated. Comments on the way I
> > structured the series would be just as welcome as ones on the
> > final result.
> 
> I see you CC'ed Peff who's passionate in this area, so these patches
> are in good hands already ;-) I briefly skimmed your patches myself,
> and did not spot anything glaringly wrong.

Heh, I don't think of "paging tag output" as one of my passions, but you
may be right. :)

I left a few comments on the code and direction, but I agree that
overall it looks pretty good. And I'm very impressed with the attention
to detail for a first-time contributor.

-Peff
