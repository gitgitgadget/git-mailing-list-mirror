Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BACD720441
	for <e@80x24.org>; Thu, 29 Dec 2016 01:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbcL2B7X (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 20:59:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:32910 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbcL2B7W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 20:59:22 -0500
Received: (qmail 13079 invoked by uid 109); 29 Dec 2016 01:59:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Dec 2016 01:59:22 +0000
Received: (qmail 21157 invoked by uid 111); 29 Dec 2016 02:00:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 21:00:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Dec 2016 20:59:19 -0500
Date:   Wed, 28 Dec 2016 20:59:19 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jvoss@altsci.com,
        "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH] contrib: remove gitview
Message-ID: <20161229015918.jyiqd42z4htjibul@sigill.intra.peff.net>
References: <20161228064255.f4akjdsq24r2hqn7@sigill.intra.peff.net>
 <20161228172837.24395-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161228172837.24395-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 09:28:37AM -0800, Stefan Beller wrote:

> gitview did not have meaningful contributions since 2007, which gives the
> impression it is either a mature or dead project.
> 
> In both cases we should not carry it in git.git as the README for contrib
> states we only want to carry experimental things to give early exposure.
> 
> Recently a security vulnerability was reported by Javantea, so the decision
> to either fix the issue or remove the code in question becomes a bit
> more urgent.
> 
> Reported-by: Javantea <jvoss@altsci.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  contrib/gitview/gitview     | 1305 -------------------------------------------
>  contrib/gitview/gitview.txt |   57 --
>  2 files changed, 1362 deletions(-)
>  delete mode 100755 contrib/gitview/gitview
>  delete mode 100644 contrib/gitview/gitview.txt

Thanks for assembling the patch. This seems reasonable to me, though I'd
like to get an Ack from Aneesh if we can.

-Peff
