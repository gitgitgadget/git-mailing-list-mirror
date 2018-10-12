Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2CC1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 19:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeJMCpd (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 22:45:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:39186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725851AbeJMCpc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 22:45:32 -0400
Received: (qmail 32511 invoked by uid 109); 12 Oct 2018 19:11:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Oct 2018 19:11:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13606 invoked by uid 111); 12 Oct 2018 19:10:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Oct 2018 15:10:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2018 15:11:35 -0400
Date:   Fri, 12 Oct 2018 15:11:35 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] config.mak.dev: add -Wformat
Message-ID: <20181012191134.GE4917@sigill.intra.peff.net>
References: <20181012184037.15076-1-t.gummerer@gmail.com>
 <20181012184549.GC4917@sigill.intra.peff.net>
 <20181012185450.GB52080@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181012185450.GB52080@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 11:54:50AM -0700, Jonathan Nieder wrote:

> > I'm not opposed to making config.mak.dev a bit more redundant to handle
> > this case, but we'd probably want to include all of -Wall, since it
> > contains many other warnings we'd want to make sure are enabled.
> 
> Do you mean putting -Wall instead of -Wformat?

Yes.

> Should we add -Wextra too?  From a quick test, it seems to build okay.

We already do (though we have to then manually disable a few warnings
that we're not ready for -- see config.mak.dev).

-Peff
