Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C5251F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 12:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeKXW64 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 17:58:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:49962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726160AbeKXW64 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 17:58:56 -0500
Received: (qmail 1905 invoked by uid 109); 24 Nov 2018 12:10:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Nov 2018 12:10:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1359 invoked by uid 111); 24 Nov 2018 12:10:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 24 Nov 2018 07:10:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Nov 2018 07:10:37 -0500
Date:   Sat, 24 Nov 2018 07:10:37 -0500
From:   Jeff King <peff@peff.net>
To:     Max Kirillov <max@max630.net>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH] t5562: fix perl path
Message-ID: <20181124121036.GC19257@sigill.intra.peff.net>
References: <20181119213924.GA2318@sigill.intra.peff.net>
 <20181122233821.17871-1-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181122233821.17871-1-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 23, 2018 at 01:38:21AM +0200, Max Kirillov wrote:

> From: Jeff King <peff@peff.net>
> 
> Some systems do not have perl installed to /usr/bin. Use the variable
> from the build settiings, and call perl directly than via shebang.
> 
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> Submitting. Could you sign-off? Also removed shebang from the script as it is not needed

Yep:

  Signed-off-by: Jeff King <peff@peff.net>

As Carlos mentioned, I think you could leave the shebang as
documentation, but I'm OK either way.

-Peff
