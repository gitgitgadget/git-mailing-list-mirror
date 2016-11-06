Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22DD02021E
	for <e@80x24.org>; Sun,  6 Nov 2016 14:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbcKFOyM (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 09:54:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:39280 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751918AbcKFOyL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 09:54:11 -0500
Received: (qmail 2177 invoked by uid 109); 6 Nov 2016 14:54:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Nov 2016 14:54:10 +0000
Received: (qmail 6145 invoked by uid 111); 6 Nov 2016 14:54:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Nov 2016 09:54:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Nov 2016 09:54:08 -0500
Date:   Sun, 6 Nov 2016 09:54:08 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] t0021: use $PERL_PATH for rot13-filter.pl
Message-ID: <20161106145408.qenhcucj7a3llhyr@sigill.intra.peff.net>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
 <20161102182022.zalzmc6rcwmvrgqq@sigill.intra.peff.net>
 <E073426F-8285-4D11-91BC-E1B80F54AD32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E073426F-8285-4D11-91BC-E1B80F54AD32@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 06, 2016 at 03:52:00PM +0100, Lars Schneider wrote:

> Would it make sense to rename "rot13-filter.pl" to 
> "rot13-filter.pl.template" or something because of the
> missing shebang?

I think it makes sense to keep it as ".pl". Without the "#!" things like
editors will use the extension to guess what type of file it is, for
features like syntax highlight and auto-indentation.

I was actually tempted to _keep_ the #! line for that reason, but then
the built result ends up with two such lines (which is not wrong, but is
confusing if anybody actually looks at it).

-Peff
