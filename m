Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F9E1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964982AbeAXSGl (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:06:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:55770 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964826AbeAXSGk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:06:40 -0500
Received: (qmail 17804 invoked by uid 109); 24 Jan 2018 18:06:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 18:06:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26745 invoked by uid 111); 24 Jan 2018 18:07:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 13:07:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 13:06:38 -0500
Date:   Wed, 24 Jan 2018 13:06:38 -0500
From:   Jeff King <peff@peff.net>
To:     "Juan F. Codagnone" <jcodagnone@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: avoid segfault when can't open files
Message-ID: <20180124180638.GA18703@sigill.intra.peff.net>
References: <20180124025417.32497-1-jcodagnone@gmail.com>
 <20180124040232.GB1330@sigill.intra.peff.net>
 <CALfSDjd0oZZmz1nKzasKu-Adn3LPS+AdLH4mYeR=Rx-PZpe4Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALfSDjd0oZZmz1nKzasKu-Adn3LPS+AdLH4mYeR=Rx-PZpe4Jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 01:51:31PM -0300, Juan F. Codagnone wrote:

> > As for the patch itself, it looks correct but I saw two style nits:
> 
> Thanks for the detailed review! I'm sorry about the style nits. I
> focused on the tabs and braces. Next time I will take additional
> attention.

No problem, and thank you for fixing the bug (also, I think this is your
first patch, so welcome to git. :) ).

> I'll be resubmitting  the patch taking into account your remarks.

It looks good to me.

-Peff
