Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85E8202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 06:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbdJUGUx (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 02:20:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:59748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751157AbdJUGUx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 02:20:53 -0400
Received: (qmail 9891 invoked by uid 109); 21 Oct 2017 06:20:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 06:20:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22661 invoked by uid 111); 21 Oct 2017 06:20:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 02:20:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Oct 2017 02:20:51 -0400
Date:   Sat, 21 Oct 2017 02:20:51 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] mention git stash push first in the man page
Message-ID: <20171021062050.wp2fdjwmjhwcorln@sigill.intra.peff.net>
References: <20171005200049.GF30301@hank>
 <20171005201029.4173-1-t.gummerer@gmail.com>
 <20171017041405.eavuutzgzgs4ppk2@sigill.intra.peff.net>
 <20171017214515.GG15399@hank>
 <20171017214708.ixc2hnut2virarzh@sigill.intra.peff.net>
 <20171019180801.GI15399@hank>
 <alpine.LFD.2.21.1710200403260.30185@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710200403260.30185@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 04:04:10AM -0400, Robert P. J. Day wrote:

> > > I don't think there's any reason to go slow in marking something as
> > > deprecated. It's the part where we follow up and remove or change the
> > > feature that must take a while.
> >
> > Makes sense, let me drop it from the synopsis then.
> 
>   what, exactly, is the oft-referred-to issue with how "git stash
> save" works that is being addressed with the new syntax of "git stash
> push"?

"stash save" soaks up all arguments as the stash message, so it's not
possible to specify pathspecs. "push" uses "-m <msg>" for the stash
message, and can accept pathspecs.

-Peff
