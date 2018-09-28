Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315621F453
	for <e@80x24.org>; Fri, 28 Sep 2018 01:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeI1Hch (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 03:32:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:34610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725972AbeI1Hcg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 03:32:36 -0400
Received: (qmail 22264 invoked by uid 109); 28 Sep 2018 01:11:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Sep 2018 01:11:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8428 invoked by uid 111); 28 Sep 2018 01:11:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 21:11:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 21:11:29 -0400
Date:   Thu, 27 Sep 2018 21:11:29 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] Documentation/CodingGuidelines: How to document new APIs
Message-ID: <20180928011129.GD11281@sigill.intra.peff.net>
References: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com>
 <20180927212727.128214-1-sbeller@google.com>
 <20180927232732.GA216193@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927232732.GA216193@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 04:27:32PM -0700, Jonathan Nieder wrote:

> > There are different opinions on how to document an API properly.
> > Discussion turns out nobody disagrees with documenting new APIs on the
> > function level in the header file and high level concepts in
> > Documentation/technical, so let's state that in the guidelines.
> 
> I disagree with this.  I think we should put all the API docs in the
> header file, like we're already doing in e.g. strbuf.h.

Me too.

I think other high-level concepts that are _not_ APIs (e.g., file
formats, protocol, etc) could go into technical/.

(Though actually, those are the thing that I would not mind at all if
they get formatted into real manpages and shipped to end users. We do
not expect most users to dissect our file-formats, but they could at
least be useful to somebody poking around).

> Do you have a link to where in the discussion this split-docs strategy
> was decided?

I think the purpose of this patch is to spur people towards a decision.
:)

-Peff
