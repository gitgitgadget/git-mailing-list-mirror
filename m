Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6F2A20248
	for <e@80x24.org>; Thu, 28 Feb 2019 21:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbfB1VnQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:43:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:33528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727601AbfB1VnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:43:16 -0500
Received: (qmail 31400 invoked by uid 109); 28 Feb 2019 21:43:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 21:43:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24019 invoked by uid 111); 28 Feb 2019 21:43:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 16:43:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 16:43:14 -0500
Date:   Thu, 28 Feb 2019 16:43:14 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH RFC 0/20] cat-file: start using formatting logic from
 ref-filter
Message-ID: <20190228214314.GL12723@sigill.intra.peff.net>
References: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 06:50:06PM +0300, Olga Telezhnaya wrote:

> In my opinion, it still has some issues. I mentioned all of them in
> TODOs in comments. All of them considered to be separate tasks for
> other patches. Some of them sound easy and could be great tasks for
> newbies.

One other thing I forgot to mention: your patches ended up on the list
in jumbled order. How do you send them? Usually `send-email` would add 1
second to the timestamp of each, so that threading mail readers sort
them as you'd expect (even if they arrive out of order due to the
vagaries of SMTP servers).

-Peff
