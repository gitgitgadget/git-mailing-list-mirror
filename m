Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658841FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 22:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755330AbcLBWV4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 17:21:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:50915 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbcLBWVz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 17:21:55 -0500
Received: (qmail 11519 invoked by uid 109); 2 Dec 2016 22:21:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Dec 2016 22:21:55 +0000
Received: (qmail 16052 invoked by uid 111); 2 Dec 2016 22:22:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Dec 2016 17:22:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Dec 2016 17:21:53 -0500
Date:   Fri, 2 Dec 2016 17:21:53 -0500
From:   Jeff King <peff@peff.net>
To:     ken edward <kedward777@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Where is Doc to configure Git + Apache + kerberos for Project
 level access in repo?
Message-ID: <20161202222153.3j5i5rsacybwexg6@sigill.intra.peff.net>
References: <CAAqgmoNG4vOqLnOqmrUvwTNJpqGBckfN-y=Fc99TrvjPhz7h0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAqgmoNG4vOqLnOqmrUvwTNJpqGBckfN-y=Fc99TrvjPhz7h0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 01:15:02PM -0500, ken edward wrote:

> Where is Doc to configure Git + Apache + kerberos for Project level
> access in repo?

I don't know about Kerberos, but all of the documentation in git for
configuring Apache is found in "git help http-backend".

-Peff
