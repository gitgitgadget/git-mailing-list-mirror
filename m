Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5AAC2013E
	for <e@80x24.org>; Fri,  3 Mar 2017 05:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdCCFOp (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 00:14:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:37663 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbdCCFOi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 00:14:38 -0500
Received: (qmail 2795 invoked by uid 109); 3 Mar 2017 05:07:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 05:07:48 +0000
Received: (qmail 24795 invoked by uid 111); 3 Mar 2017 05:07:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 00:07:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 00:07:45 -0500
Date:   Fri, 3 Mar 2017 00:07:45 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 9/9] Test read_early_config()
Message-ID: <20170303050745.wv4zsb24ykr34xr7@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <cover.1488506615.git.johannes.schindelin@gmx.de>
 <f27a753830b8fb61a5276ce1d8eeba04ae4dbbfd.1488506615.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f27a753830b8fb61a5276ce1d8eeba04ae4dbbfd.1488506615.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 03:04:36AM +0100, Johannes Schindelin wrote:

> So far, we had no explicit tests of that function.

Makes sense. The pager tests fixed in an earlier commit were effectively
checking those, but I don't mind making it explicit.

-Peff
