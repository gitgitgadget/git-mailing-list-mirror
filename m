Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0C520248
	for <e@80x24.org>; Tue,  5 Mar 2019 22:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfCEWg5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 17:36:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:40042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726069AbfCEWg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 17:36:57 -0500
Received: (qmail 26943 invoked by uid 109); 5 Mar 2019 22:36:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 22:36:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3339 invoked by uid 111); 5 Mar 2019 22:37:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 05 Mar 2019 17:37:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2019 17:36:55 -0500
Date:   Tue, 5 Mar 2019 17:36:55 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Doc: fix misleading asciidoc formating
Message-ID: <20190305223655.GA27535@sigill.intra.peff.net>
References: <20190305214423.27820-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190305214423.27820-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 05, 2019 at 10:44:23PM +0100, Jean-Noël Avila wrote:

> The end of sentence in "x." at the begining of a line misleads
> ascidoctor into interpreting it as the start of numbered sub-list.

Because I'd been wanting to play with doc-diff and asciidoctor, I tried
looking at the rendered diff. However, I couldn't see any difference!

Did you notice this when building locally, or on the asciidoctor-built
pages at git-scm.com? If the latter, I wonder if we might need to update
our version of asciidoctor there (it looks like we're on v1.5.6.1 there,
but my local asciidoctor binary is v1.5.8).

-Peff
