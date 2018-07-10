Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F1E1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 15:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934209AbeGJPh1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:37:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:53702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933475AbeGJPh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:37:27 -0400
Received: (qmail 22859 invoked by uid 109); 10 Jul 2018 15:37:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 15:37:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27626 invoked by uid 111); 10 Jul 2018 15:37:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 11:37:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 11:37:25 -0400
Date:   Tue, 10 Jul 2018 11:37:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Henning Schild <henning.schild@siemens.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/8] gpg-interface: introduce an abstraction for multiple
 gpg formats
Message-ID: <20180710153724.GA23438@sigill.intra.peff.net>
References: <cover.1530616446.git.henning.schild@siemens.com>
 <db46732d1cd09a71200e00c2d09605d5beaff364.1530616446.git.henning.schild@siemens.com>
 <CAN0heSrXpLCDRjnZC80QXBG27gd6m5reBn1hfNd_KXxnPVkA2g@mail.gmail.com>
 <xmqqa7r4mg45.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7r4mg45.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 06, 2018 at 10:24:58AM -0700, Junio C Hamano wrote:

> What we've been avoiding was the comma after the last element in the
> enum (in other words, if PGP_FMT had ',' after it in the above
> quoted addition, that would have been violation of that rule), as
> having such a trailing comma used to be ANSI C violation as well.  I
> do not recall offhand if we loosened that deliberately.
> 
> 4b05548f ("enums: omit trailing comma for portability", 2010-05-14),
> c9b6782a ("enums: omit trailing comma for portability", 2011-03-16)

I think we accidentally did a weather-balloon in e1327023ea (grep:
refactor the concept of "grep source" into an object, 2012-02-02).
It's still there and nobody has complained about it yet.

So I think we can consider that requirement loosened at this point.

-Peff
