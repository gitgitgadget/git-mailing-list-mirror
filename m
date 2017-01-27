Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C011F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934070AbdA0R4N (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 12:56:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:45961 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933883AbdA0Rzw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:55:52 -0500
Received: (qmail 14187 invoked by uid 109); 27 Jan 2017 17:54:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 17:54:25 +0000
Received: (qmail 10993 invoked by uid 111); 27 Jan 2017 17:54:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 12:54:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2017 12:54:23 -0500
Date:   Fri, 27 Jan 2017 12:54:23 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/1] reset: support the --stdin option
Message-ID: <20170127175422.b7bds4toeytndo43@sigill.intra.peff.net>
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
 <cover.1485520718.git.johannes.schindelin@gmx.de>
 <3b0bad26045ed175f40f050e15b65cb6a8f2368c.1485520718.git.johannes.schindelin@gmx.de>
 <20170127170422.lvpghp6jdud37zxx@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701271832270.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701271832270.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 06:34:46PM +0100, Johannes Schindelin wrote:

> > Is it worth clarifying that these are paths, not pathspecs? The word
> > "paths" is used to refer to the pathspecs on the command-line elsewhere
> > in the document.
> > 
> > It might also be worth mentioning the quoting rules for the non-z case.
> 
> I think this would be overkill. In reality, --stdin without -z does not
> make much sense, anyway.

I think with most Unix tools people tend to use the non-z forms until
they break, and then switch to the z form. :)

And in that sense, this transparently Just Works because the output will
often come from another git tool, which will quote as appropriate.

> If you feel strongly about it, I encourage you to submit a follow-up
> patch.
> 
> The rest of your suggestions have been implemented in v3.

Thanks. I think the path/pathspec thing was the more important of the
two suggestions.

-Peff
