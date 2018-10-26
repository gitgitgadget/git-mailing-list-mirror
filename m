Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA3281F453
	for <e@80x24.org>; Fri, 26 Oct 2018 11:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeJZUat (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 16:30:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:55624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727469AbeJZUat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 16:30:49 -0400
Received: (qmail 13426 invoked by uid 109); 26 Oct 2018 11:54:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Oct 2018 11:54:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28764 invoked by uid 111); 26 Oct 2018 11:53:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Oct 2018 07:53:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2018 07:53:59 -0400
Date:   Fri, 26 Oct 2018 07:53:59 -0400
From:   Jeff King <peff@peff.net>
To:     Mischa POSLAWSKY <git@shiar.nl>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Junio C Hamano <gitster@pobox.com>,
        "lhf635@163.com" <lhf635@163.com>, git <git@vger.kernel.org>
Subject: Re: the opposite of .gitignore, whitelist
Message-ID: <20181026115358.GA26844@sigill.intra.peff.net>
References: <201810251039388653199@163.com>
 <xmqqh8hak2mh.fsf@gitster-ct.c.googlers.com>
 <c166b421-a228-8349-0815-2ebb9dcab998@lakedaemon.net>
 <20181026093644.GA20876@sigill.intra.peff.net>
 <20181026113151.dgjta7tlcjgnttcx@shiar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181026113151.dgjta7tlcjgnttcx@shiar.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 01:31:51PM +0200, Mischa POSLAWSKY wrote:

> Jeff King wrote 2018-10-26 5:36 (-0400):
> > I think what Junio meant is to ignore everything by default, like:
> > 
> >   echo '*' >.gitignore
> > 
> > and then selectively use negative patterns (and being in .gitignore,
> > that makes them positive "yes, include this") to add things back:
> > 
> >   echo 'foo' >>.gitignore
> > 
> > which ends up being roughly the same as your .gitonly concept.
> 
> To clarify, Peff meant to say echo '!foo' to whitelist. See git help ignore.

Oops, yes, thank you.

-Peff
