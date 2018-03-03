Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E7FE1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 10:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeCCKDA (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 05:03:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:45556 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751908AbeCCKC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 05:02:59 -0500
Received: (qmail 23550 invoked by uid 109); 3 Mar 2018 10:02:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 10:02:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4559 invoked by uid 111); 3 Mar 2018 10:03:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 05:03:48 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 05:02:56 -0500
Date:   Sat, 3 Mar 2018 05:02:56 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Dorian Taylor <dorian.taylor.lists@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] smart-http: document flush after "# service" line
Message-ID: <20180303100256.GA21033@sigill.intra.peff.net>
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com>
 <20180221221516.GA7944@sigill.intra.peff.net>
 <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com>
 <20180222053722.GB133592@aiede.svl.corp.google.com>
 <614A9A36-9DE3-4A85-BFA8-8380C4AC21B8@gmail.com>
 <20180222100840.GD12442@sigill.intra.peff.net>
 <xmqqbmggx063.fsf@gitster-ct.c.googlers.com>
 <01B07AA7-B2A4-4A81-B1F0-E2EC3D6BFBF9@gmail.com>
 <20180303052708.GF27689@sigill.intra.peff.net>
 <CAPig+cT4NhhZNaYYXZL3dqvVn++KrNSL1bQRtdPt4RqfPexAnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cT4NhhZNaYYXZL3dqvVn++KrNSL1bQRtdPt4RqfPexAnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 03, 2018 at 03:28:47AM -0500, Eric Sunshine wrote:

> On Sat, Mar 3, 2018 at 12:27 AM, Jeff King <peff@peff.net> wrote:
> > Subject: smart-http: document flush after "# service" line
> >
> > The http-protocol.txt spec fails to mention that a flush
> > packet comes in the smart server response after sending any
> > the "service" header.
> 
> "any the"?

Oops, should just be "the".

-Peff
