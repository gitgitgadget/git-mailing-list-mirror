Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8251C1F407
	for <e@80x24.org>; Sun, 10 Dec 2017 14:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbdLJOx5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 09:53:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:53718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751616AbdLJOx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 09:53:56 -0500
Received: (qmail 30725 invoked by uid 109); 10 Dec 2017 14:53:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Dec 2017 14:53:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13692 invoked by uid 111); 10 Dec 2017 14:54:18 -0000
Received: from pool-96-236-18-62.albyny.fios.verizon.net (HELO sigill.intra.peff.net) (96.236.18.62)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 10 Dec 2017 09:54:18 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Dec 2017 09:53:54 -0500
Date:   Sun, 10 Dec 2017 09:53:54 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH Outreachy 1/2] format: create pretty.h file
Message-ID: <20171210145354.GA20367@sigill.intra.peff.net>
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
 <xmqq7etx9kzq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7etx9kzq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 09:40:09AM -0800, Junio C Hamano wrote:

> I see you've "standardized" to drop "extern" from the declarations
> in the header; I have an impression that our preference however is
> to go in the other direction.

Can we revisit that?

I haven't see any compelling reason to include the "extern" in a
declaration. And all things being equal, I'd prefer the thing that makes
the source code shorter, and is one less thing for authors to remember
to do.

-Peff
