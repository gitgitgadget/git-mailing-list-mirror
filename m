Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A51DA2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 15:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbdKUP6T (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 10:58:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:36202 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751067AbdKUP6S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 10:58:18 -0500
Received: (qmail 18061 invoked by uid 109); 21 Nov 2017 15:58:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Nov 2017 15:58:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22970 invoked by uid 111); 21 Nov 2017 15:58:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 21 Nov 2017 10:58:33 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Nov 2017 10:58:16 -0500
Date:   Tue, 21 Nov 2017 10:58:16 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] p5550: factor our nonsense-pack creation
Message-ID: <20171121155815.46ih4ld4cp7n544l@sigill.intra.peff.net>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
 <20171120202643.s2cywlqykayq5qdb@sigill.intra.peff.net>
 <CAPig+cRDNmjmM2Ed+mwqf7JZ76CxA3Eh7-UV6k=LFngZ3YE_sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRDNmjmM2Ed+mwqf7JZ76CxA3Eh7-UV6k=LFngZ3YE_sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 06:55:51PM -0500, Eric Sunshine wrote:

> On Mon, Nov 20, 2017 at 3:26 PM, Jeff King <peff@peff.net> wrote:
> > p5550: factor our nonsense-pack creation
> 
> s/our/out/, I guess.

Heh, yes. I even fixed it once, but I have the funny habit of noticing
such typos while reading the "todo" list of "rebase -i" and fixing them
there. Which of course has no impact whatsoever on the commit. :-/

-Peff
