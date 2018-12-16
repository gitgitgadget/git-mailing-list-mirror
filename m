Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32B98211B3
	for <e@80x24.org>; Sun, 16 Dec 2018 10:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeLPK7r (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 05:59:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:43278 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729819AbeLPK7r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 05:59:47 -0500
Received: (qmail 24813 invoked by uid 109); 16 Dec 2018 10:59:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Dec 2018 10:59:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22446 invoked by uid 111); 16 Dec 2018 10:59:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 16 Dec 2018 05:59:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2018 05:59:45 -0500
Date:   Sun, 16 Dec 2018 05:59:45 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] git-status.txt: render tables correctly under
 Asciidoctor
Message-ID: <20181216105944.GG13704@sigill.intra.peff.net>
References: <20181215112742.1475882-1-martin.agren@gmail.com>
 <20181215112742.1475882-5-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181215112742.1475882-5-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 15, 2018 at 12:27:42PM +0100, Martin Ågren wrote:

> Asciidoctor removes the indentation of each line in these tables, so the
> last lines of each table have a completely broken alignment.
> 
> Similar to 379805051d ("Documentation: render revisions correctly under
> Asciidoctor", 2018-05-06), use an explicit literal block to indicate
> that we want to keep the leading whitespace in the tables.
> 
> Because this gives us some extra indentation, we can remove the one that
> we have been carrying explicitly. That is, drop the first four spaces of
> indentation on each line. With Asciidoc (8.6.10), this results in
> identical rendering before and after this commit, both for git-status.1
> and git-status.html.

Yep, this makes sense based on the prior art you cited.

The whole series looks good to me. Thanks for working on it!

-Peff
