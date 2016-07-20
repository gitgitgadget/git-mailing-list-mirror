Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5FCA2034E
	for <e@80x24.org>; Wed, 20 Jul 2016 16:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbcGTQAN (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 12:00:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:47575 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751204AbcGTQAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 12:00:11 -0400
Received: (qmail 16231 invoked by uid 102); 20 Jul 2016 16:00:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 12:00:11 -0400
Received: (qmail 22165 invoked by uid 107); 20 Jul 2016 16:00:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 12:00:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 10:00:08 -0600
Date:	Wed, 20 Jul 2016 10:00:08 -0600
From:	Jeff King <peff@peff.net>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1 2/6] Status and checkout unit tests for
 --porcelain[=<n>]
Message-ID: <20160720160007.GB24902@sigill.intra.peff.net>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-3-git-send-email-jeffhost@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1468966258-11191-3-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 06:10:54PM -0400, Jeff Hostetler wrote:

> +test_expect_failure '--porcelain=bogus with stuff to commit returns ok' '
> +	echo bongo bongo bongo >>file &&
> +	git commit -m next -a --porcelain=bogus
> +'

Hrm. That seems unexpected to me. Shouldn't it complain about
--porcelain=bogus?

-Peff
