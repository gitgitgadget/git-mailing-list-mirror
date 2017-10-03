Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B7C2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 23:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbdJCXxM (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 19:53:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:59820 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750865AbdJCXxL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 19:53:11 -0400
Received: (qmail 27770 invoked by uid 109); 3 Oct 2017 23:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 23:53:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13222 invoked by uid 111); 3 Oct 2017 23:53:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 19:53:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 19:53:09 -0400
Date:   Tue, 3 Oct 2017 19:53:09 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Rebischke <Chris.Rebischke@archlinux.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [bug] git version 2.4.12 color.ui = always breaks git add -p
Message-ID: <20171003235309.tysfbxqmb7zbiaic@sigill.intra.peff.net>
References: <20171003213353.GA9195@motoko>
 <20171003214748.GA19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003214748.GA19555@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 02:47:48PM -0700, Jonathan Nieder wrote:

> Hi Christian,
> 
> Christian Rebischke wrote:
> 
> > I played around with my gitconfig and I think I found a bug while doing
> > so. I set the following lines in my gitconfig:
> >
> > [color]
> >     ui = always
> >
> > When I try to use `git add -p <filename>` I don't see the 'Stage
> > this hunk'-dialog anymore. First I thought it's some other configuration
> > but now I can definitly say that this configuration breaks `git add -p`
> > interactive mode.
> 
> Do the patches at
> https://public-inbox.org/git/20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net/
> help?

If it makes it any easier to test, they are also available as a fetch
from:

  https://github.com/peff/git jk/color-no-always

-Peff
