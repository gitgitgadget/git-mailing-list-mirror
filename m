Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B211F405
	for <e@80x24.org>; Sun, 16 Dec 2018 16:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbeLPQRX (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 11:17:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:43446 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729822AbeLPQRX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 11:17:23 -0500
Received: (qmail 5293 invoked by uid 109); 16 Dec 2018 16:17:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Dec 2018 16:17:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24275 invoked by uid 111); 16 Dec 2018 16:16:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 16 Dec 2018 11:16:54 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2018 11:17:21 -0500
Date:   Sun, 16 Dec 2018 11:17:21 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] A few Asciidoctor-fixes
Message-ID: <20181216161720.GA1511@sigill.intra.peff.net>
References: <20181215112742.1475882-1-martin.agren@gmail.com>
 <20181216104458.GC13704@sigill.intra.peff.net>
 <CAN0heSrccWop+KRKFCTNHTB43XcAv+Q8X7p0hT1t2+rPjS1THA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrccWop+KRKFCTNHTB43XcAv+Q8X7p0hT1t2+rPjS1THA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 16, 2018 at 03:34:42PM +0100, Martin Ågren wrote:

> Your list seems complete to me in terms of "how could we teach doc-diff
> to diff asciidoctor vs asciidoc?". For the resulting diff to actually be
> useful ;-) there are two more outstanding issues that I see:
> 
>   - Headers and footers. Asciidoc (driven by doc-diff) uses some
>     boilerplate values which avoid timestamps and the like. Asciidoctor
>     partly uses different values, partly interprets the ones given
>     differently.
> 
>   - Asciidoctor introduces a space after linkgit:foo , e.g., before
>     punctuation.
> 
> Both of these are problems in their own right, so they probably
> shouldn't be suppressed in the resulting diff. But as long as these
> issues remain, they produce a lot of noise which might hide more
> interesting (IMHO) differences.

If there are a small number of distinct problems (that each have many
instances), I'm not opposed to having a mode to suppress them in the
resulting diff, so we can see the other problems more clearly.  Of
course, just fixing them is even better. ;)

The first one sounds like it may be a candidate for suppressing (i.e.,
it's not necessarily an actual problem).

-Peff
