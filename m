Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE9401F406
	for <e@80x24.org>; Wed,  3 Jan 2018 19:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeACTIr (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 14:08:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:52344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751209AbeACTIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 14:08:47 -0500
Received: (qmail 8812 invoked by uid 109); 3 Jan 2018 19:08:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Jan 2018 19:08:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30414 invoked by uid 111); 3 Jan 2018 19:09:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 03 Jan 2018 14:09:17 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jan 2018 14:08:45 -0500
Date:   Wed, 3 Jan 2018 14:08:45 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Several fixes for the test suite related to spaces
 in filenames
Message-ID: <20180103190844.GA30781@sigill.intra.peff.net>
References: <cover.1514998470.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1514998470.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 03, 2018 at 05:54:44PM +0100, Johannes Schindelin wrote:

> The second issue was found long ago, and the patch carried in Git for
> Windows, although nothing about it is specific to Windows.
> 
> The first patch was developed today, when I tried to verify that Git's
> test suite passes if Git is cloned to a directory called `with spaces/`.

Heh, the whole point of the space in the trash directory was to find
these issues early, but obviously it is not foolproof. :)

The patches themselves look good to me from inspection. Thanks.

-Peff
