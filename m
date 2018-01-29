Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87F6E1FC2C
	for <e@80x24.org>; Mon, 29 Jan 2018 18:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeA2SXT (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 13:23:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:32858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750959AbeA2SXS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 13:23:18 -0500
Received: (qmail 24525 invoked by uid 109); 29 Jan 2018 18:23:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Jan 2018 18:23:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5383 invoked by uid 111); 29 Jan 2018 18:23:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Jan 2018 13:23:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Jan 2018 13:23:16 -0500
Date:   Mon, 29 Jan 2018 13:23:16 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCHv2 0/5] Travis CI: don't run the test suite as root in the
 32 bit Linux build
Message-ID: <20180129182316.GD4185@sigill.intra.peff.net>
References: <20180129171713.17471-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180129171713.17471-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 06:17:08PM +0100, SZEDER Gábor wrote:

> This version addresses Peff comments:
> 
>   - Updated the commit message to discuss the broken && chain and its
>     consequences in patch 2.
>   - Fixed quoting of the 'su' command snippet and updated the commit
>     message in patch 3.
>   - Squelch error from 'test "$(id -u $CI_USER)"' and add debug
>     message in patch 5.
> 
> Additionally, it's rebased onto current master (I branched off v1 from
> 'sg/travis-build-during-script-phase' to avoid a conflict, but Junio
> applied it on top of current master).

Thanks, this all looks good to me.

-Peff
