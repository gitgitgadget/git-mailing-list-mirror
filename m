Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40BD202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 13:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbcGTNB3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 09:01:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:47418 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751566AbcGTNB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 09:01:28 -0400
Received: (qmail 7344 invoked by uid 102); 20 Jul 2016 13:01:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:01:27 -0400
Received: (qmail 20239 invoked by uid 107); 20 Jul 2016 13:01:50 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:01:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 07:01:24 -0600
Date:	Wed, 20 Jul 2016 07:01:24 -0600
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Shreyas Mulay <shreyasmulay23@gmail.com>, git@vger.kernel.org
Subject: Re: 500 Internal Server Error
Message-ID: <20160720130123.GA17469@sigill.intra.peff.net>
References: <loom.20160720T061853-541@post.gmane.org>
 <578F3AF7.4030702@gmail.com>
 <alpine.DEB.2.20.1607201312450.14111@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607201312450.14111@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 01:13:21PM +0200, Johannes Schindelin wrote:

> > The git@vger.kernel.org mailing list is for a development of Git itself;
> > the bugs on Git Homepage (https://git-scm.com) should be sent to
> > https://github.com/git/git-scm.com/issues -- as you can find on the
> > bottom of the page... though it is not obvious.
> 
> In addition, I believe this to be an invalid bug report. It seems at least
> that
> 
> 	curl -i --header 'Accept-Language: hi' https://git-scm.com/
> 
> does not reproduce the purported issue.

I suspect the OP means:

  https://git-scm.com/book/hi/v1/%E0%A4%B6%E0%A5%81%E0%A4%B0%E0%A5%81%E0%A4%86%E0%A4%A4

which is linked as the first chapter of the incomplete Hindi translation
of Pro Git.

From a cursory look, I think the problem is simply that the translation
does not have enough chapters to meet some of the assumptions in the
formatting code. It might be nice to fix the formatting code to handle
this case, but ultimately, I think a translator needs to step up and
finish the rest of the book.

-Peff
