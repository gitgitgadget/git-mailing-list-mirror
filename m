Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9DE1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdEaVNE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:13:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:60785 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdEaVNE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:13:04 -0400
Received: (qmail 14801 invoked by uid 109); 31 May 2017 21:06:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 21:06:22 +0000
Received: (qmail 8621 invoked by uid 111); 31 May 2017 21:07:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 17:07:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 17:06:21 -0400
Date:   Wed, 31 May 2017 17:06:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>
Subject: Re: [PATCH 6.5?/8] version: move --build-options to a test helper
Message-ID: <20170531210621.64pv2dxmtuhg4mzh@sigill.intra.peff.net>
References: <20170530051742.3j3yn3ipfmyrrteu@sigill.intra.peff.net>
 <20170530204553.25968-1-avarab@gmail.com>
 <20170530210530.o5gbz2k24wxrfner@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1705311726110.3610@virtualbox>
 <20170531153123.atl45b3kbfmqhnta@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1705311744170.3610@virtualbox>
 <CACBZZX4NkCgXZaz2+d6SN2ZL_zoh_i3fdwLZdinPNki+hU5ZOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4NkCgXZaz2+d6SN2ZL_zoh_i3fdwLZdinPNki+hU5ZOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 07:51:20PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Thanks both. It makes sense to discard this patch.
> 
> I wasn't sure whether anyone really cared about this, and thought a
> patch was a better starting point of discussion.

I will never complain about somebody starting a discussion with a patch
as long as they don't mind if it gets shot down. :)

Thanks for raising the point. I do think it was worth thinking about.

-Peff
