Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7418D20899
	for <e@80x24.org>; Wed, 23 Aug 2017 15:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbdHWPrw (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 11:47:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:46748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932112AbdHWPru (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 11:47:50 -0400
Received: (qmail 11578 invoked by uid 109); 23 Aug 2017 15:47:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 15:47:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1049 invoked by uid 111); 23 Aug 2017 15:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 11:48:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Aug 2017 11:47:47 -0400
Date:   Wed, 23 Aug 2017 11:47:47 -0400
From:   Jeff King <peff@peff.net>
To:     Adam Spiers <git@adamspiers.org>
Cc:     Drew Northup <n1xim.email@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>
Subject: Re: splitting off shell test framework
Message-ID: <20170823154747.vxtyy2v2ofkxwrkx@sigill.intra.peff.net>
References: <CAOkDyE8KxFvM4CJhC4U=Jb95D6HQ-4qQBtKAgBMyHH15UOhvqg@mail.gmail.com>
 <CAM9Z-n=ypt_fyFcPjYD28NNoxnJ2ZSovd1TbERdA8RJY1Va=kA@mail.gmail.com>
 <CAOkDyE9phgZ4ToWTWa2GYgfVkDknCqWr+KEyqVoHg0RVrVVk9A@mail.gmail.com>
 <CAOkDyE_VhGUzn=PmAVsbaTe1ZeBwBVGpF4Muz5MBckMAB6cf=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOkDyE_VhGUzn=PmAVsbaTe1ZeBwBVGpF4Muz5MBckMAB6cf=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 02:46:30PM +0100, Adam Spiers wrote:

> >> Done at least once already:
> >>
> >> http://comments.gmane.org/gmane.comp.version-control.git/201591
> [...]
> 
> but sadly since then gmane has shuffled off its mortal coil and I can't
> remember / find what this URL referred to.  Please could someone
> point me at a working link?

Try:

  https://public-inbox.org/git/?q=gmane:201591

Public-inbox uses message-ids as its primary key, but keeps a static
mapping of gmane articles to message-ids. But the corpus of gmane ids
isn't growing anymore, and public-inbox URLs can be trivially converted
to other systems which index on the message id[1].

-Peff

[1] I actually keep a local archive and convert public-inbox URLs into
    local requests that I view in mutt.
