Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C0D1FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 06:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdFOGhm (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 02:37:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:40470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751641AbdFOGhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 02:37:42 -0400
Received: (qmail 28454 invoked by uid 109); 15 Jun 2017 06:37:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 06:37:41 +0000
Received: (qmail 20301 invoked by uid 111); 15 Jun 2017 06:37:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 02:37:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 02:37:40 -0400
Date:   Thu, 15 Jun 2017 02:37:40 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v4 0/6] Avoid problem where git_dir is set after alias
 expansion
Message-ID: <20170615063739.xpja3bayrmiogbcz@sigill.intra.peff.net>
References: <cover.1497440104.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1497440104.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 01:35:22PM +0200, Johannes Schindelin wrote:

> Changes since v3:
> 
> - avoided the strbuf in alias_lookup() by using skip_prefix() and !strcmp()
>   instead.
> 
> - fixed tyop ("read" instead of "reading", causing Junio to stumble) in the
>   commit message of 6/6.

Thanks, this whole series looks good to me (and it sounds like Brandon
will address the common-dir thing on top).

-Peff
