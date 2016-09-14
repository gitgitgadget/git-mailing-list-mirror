Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4007D1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 15:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762668AbcINPbk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 11:31:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:43188 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762177AbcINPbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 11:31:39 -0400
Received: (qmail 26604 invoked by uid 109); 14 Sep 2016 15:31:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 15:31:38 +0000
Received: (qmail 579 invoked by uid 111); 14 Sep 2016 15:31:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 11:31:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 08:31:34 -0700
Date:   Wed, 14 Sep 2016 08:31:34 -0700
From:   Jeff King <peff@peff.net>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/16] fix config-reading in non-repos
Message-ID: <20160914153134.skehcameo2oh7dr7@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
 <1473850541.30531.18.camel@kaarsemaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1473850541.30531.18.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 12:55:41PM +0200, Dennis Kaarsemaker wrote:

> >   [14/16]: config: only read .git/config from configured repos
> >   [15/16]: init: expand comments explaining config trickery
> >   [16/16]: init: reset cached config when entering new repo
> 
> Couldn't find anything to comment on, and I've tested that this does
> indeed fix the symptoms we saw.
> 
> Reviewed-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>

Thanks. Based on our conversations earlier, I tried to dig around for
other cases that might be broken, especially with the "reinit" cases.
The result is the tests in patch 16. But let me know if you can think of
anything else that might be broken.

-Peff
