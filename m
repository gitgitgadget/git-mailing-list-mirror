Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7161F454
	for <e@80x24.org>; Thu, 27 Sep 2018 05:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeI0Lfi (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 07:35:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:33082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726626AbeI0Lfi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 07:35:38 -0400
Received: (qmail 9581 invoked by uid 109); 27 Sep 2018 05:19:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Sep 2018 05:19:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27838 invoked by uid 111); 27 Sep 2018 05:18:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 01:18:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 01:19:12 -0400
Date:   Thu, 27 Sep 2018 01:19:12 -0400
From:   Jeff King <peff@peff.net>
To:     "Zych, David M" <dmrz@illinois.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: clarify gitcredentials path component matching
Message-ID: <20180927051911.GA14178@sigill.intra.peff.net>
References: <1538000558-25523-1-git-send-email-dmrz@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1538000558-25523-1-git-send-email-dmrz@illinois.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 10:23:11PM +0000, Zych, David M wrote:

> The gitcredentials documentation implied that the config file's
> "pattern" URL might include a path component, but did not explain that
> it must match exactly (potentially leaving readers with the false hope
> that it would support a more flexible prefix match).
> [...]

Thanks, the proposed text looks perfect to me.

-Peff
