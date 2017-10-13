Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E132220437
	for <e@80x24.org>; Fri, 13 Oct 2017 12:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbdJMMfY (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 08:35:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:51966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753348AbdJMMfX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 08:35:23 -0400
Received: (qmail 18482 invoked by uid 109); 13 Oct 2017 12:35:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 12:35:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24864 invoked by uid 111); 13 Oct 2017 12:35:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 08:35:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 08:35:21 -0400
Date:   Fri, 13 Oct 2017 08:35:21 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Constantine <hi-angel@yandex.ru>, git@vger.kernel.org
Subject: Re: git-clone causes out of memory
Message-ID: <20171013123521.hop5hrfsyagu7znl@sigill.intra.peff.net>
References: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
 <20171013100603.5eed26sjjigph2il@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013100603.5eed26sjjigph2il@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 07:06:03PM +0900, Mike Hommey wrote:

> On Fri, Oct 13, 2017 at 12:51:58PM +0300, Constantine wrote:
> > There's a gitbomb on github. It is undoubtedly creative and funny, but since
> > this is a bug in git, I thought it'd be nice to report. The command:
> > 
> > 	$ git clone https://github.com/x0rz/ShadowBrokersFiles
> 
> What fills memory is actually the checkout part of the command. git
> clone -n doesn't fail.
> 
> Credit should go where it's due: https://kate.io/blog/git-bomb/
> (with the bonus that it comes with explanations)

That is a nice explanation, and I think the dates point to the kate.io
post as the parent there.

I certainly have come across this type of "bomb" repo before, but I
couldn't come up with any public references (somebody uploaded such a
repository to GitHub in 2014). So I think this may be the first public
discussion of the idea.

-Peff
