Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D1021F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfIZVLe (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:11:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:33262 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725919AbfIZVLe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:11:34 -0400
Received: (qmail 19529 invoked by uid 109); 26 Sep 2019 21:11:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Sep 2019 21:11:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3734 invoked by uid 111); 26 Sep 2019 21:14:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2019 17:14:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Sep 2019 17:11:33 -0400
From:   Jeff King <peff@peff.net>
To:     Alejandro Sanchez <asanchez1987@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] am: fix --interactive HEAD tree resolution
Message-ID: <20190926211132.GA17942@sigill.intra.peff.net>
References: <20190520120636.GA12634@sigill.intra.peff.net>
 <20190520121301.GD11212@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905230858570.46@tvgsbejvaqbjf.bet>
 <20190524063955.GD25694@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905281301070.44@tvgsbejvaqbjf.bet>
 <20190528213529.GG24650@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905291356240.44@tvgsbejvaqbjf.bet>
 <CAA4phoF5xm=HuoAmor+dQEBqBJn_0thAT38ao8JtA6XhGCDQ6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA4phoF5xm=HuoAmor+dQEBqBJn_0thAT38ao8JtA6XhGCDQ6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 04:20:05PM +0200, Alejandro Sanchez wrote:

> Are there any updates to this problem?

The fix for the original bug went into Git v2.22.1.

-Peff
