Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB70C1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 10:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeAJKeC (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 05:34:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:39928 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751409AbeAJKd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 05:33:59 -0500
Received: (qmail 25280 invoked by uid 109); 10 Jan 2018 10:34:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Jan 2018 10:34:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14092 invoked by uid 111); 10 Jan 2018 10:34:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Jan 2018 05:34:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2018 05:33:57 -0500
Date:   Wed, 10 Jan 2018 05:33:57 -0500
From:   Jeff King <peff@peff.net>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t3900: add some more quotes
Message-ID: <20180110103357.GA18553@sigill.intra.peff.net>
References: <20180110095832.22077-1-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180110095832.22077-1-dev+git@drbeat.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 10:58:32AM +0100, Beat Bolli wrote:

> In 89a70b80 ("t0302 & t3900: add forgotten quotes", 2018-01-03), quotes
> were added to protect against spaces in $HOME. In the test_when_finished
> hander, two files are deleted which must be quoted individually.

Doh. I can't believe I missed that when reading the patch.

Thanks.

-Peff
