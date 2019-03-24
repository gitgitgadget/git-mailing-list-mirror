Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1486D202BB
	for <e@80x24.org>; Sun, 24 Mar 2019 12:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfCXMQW (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 08:16:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:34248 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726090AbfCXMQV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 08:16:21 -0400
Received: (qmail 4778 invoked by uid 109); 24 Mar 2019 12:16:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Mar 2019 12:16:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1627 invoked by uid 111); 24 Mar 2019 12:16:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 24 Mar 2019 08:16:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Mar 2019 08:16:20 -0400
Date:   Sun, 24 Mar 2019 08:16:19 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190324121619.GD312@sigill.intra.peff.net>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190317194431.GY31362@pobox.com>
 <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190323192756.GK4047@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 23, 2019 at 03:27:56PM -0400, Todd Zullinger wrote:

> I updated my system to asciidoctor-2.0.0 last night and now
> I can't even generate the man pages properly, because the
> docbook45 converter was removed.  I'll have to see if I
> missed some other required update. :/

I ran into that, too. Using ASCIIDOC_DOCBOOK=docbook5 worked. The output
looked OK to me, but I only eyeballed it briefly. It's possible there
are subtle problems.

-Peff
