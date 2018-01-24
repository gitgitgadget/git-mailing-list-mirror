Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8646A1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 04:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeAXEDo (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 23:03:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:55126 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752258AbeAXEDo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 23:03:44 -0500
Received: (qmail 29529 invoked by uid 109); 24 Jan 2018 04:03:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 04:03:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22011 invoked by uid 111); 24 Jan 2018 04:04:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Jan 2018 23:04:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jan 2018 23:03:42 -0500
Date:   Tue, 23 Jan 2018 23:03:42 -0500
From:   Jeff King <peff@peff.net>
To:     Gargi Sharma <gs051095@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6] mru: Replace mru.[ch] with list.h implementation
Message-ID: <20180124040341.GC1330@sigill.intra.peff.net>
References: <1516751211-19307-1-git-send-email-gs051095@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516751211-19307-1-git-send-email-gs051095@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 06:46:51PM -0500, Gargi Sharma wrote:

> Replace the custom calls to mru.[ch] with calls to list.h. This patch is
> the final step in removing the mru API completely and inlining the logic.
> This patch leads to significant code reduction and the mru API hence, is
> not a useful abstraction anymore.
> 
> Signed-off-by: Gargi Sharma <gs051095@gmail.com>

Thanks, this version looks good to me.

-Peff
