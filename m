Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06CC01F453
	for <e@80x24.org>; Sat, 29 Sep 2018 07:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeI2OIo (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 10:08:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:36114 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727511AbeI2OIo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 10:08:44 -0400
Received: (qmail 9553 invoked by uid 109); 29 Sep 2018 07:41:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Sep 2018 07:41:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4497 invoked by uid 111); 29 Sep 2018 07:40:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Sep 2018 03:40:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2018 03:41:18 -0400
Date:   Sat, 29 Sep 2018 03:41:18 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/CodingGuidelines: How to document new APIs
Message-ID: <20180929074118.GE2174@sigill.intra.peff.net>
References: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com>
 <20180927212727.128214-1-sbeller@google.com>
 <20180927232732.GA216193@aiede.svl.corp.google.com>
 <20180928011129.GD11281@sigill.intra.peff.net>
 <CAGZ79kZzR+n+8ODs3SBhOEXFbOmccugOampzkpFKGoEXjggEwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZzR+n+8ODs3SBhOEXFbOmccugOampzkpFKGoEXjggEwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 10:14:12AM -0700, Stefan Beller wrote:

> > I think other high-level concepts that are _not_ APIs (e.g., file
> > formats, protocol, etc) could go into technical/.
> 
> That is what I meant with high level concepts. Anything that talks
> about or implies the existence of a function is clearly header level.

Ah, OK. I thought you meant the "this is how strbuf roughly works"
overview, which IMHO should remain in strbuf.h.

I think we are on the same page, then.

> > (Though actually, those are the thing that I would not mind at all if
> > they get formatted into real manpages and shipped to end users. We do
> > not expect most users to dissect our file-formats, but they could at
> > least be useful to somebody poking around).
> 
> Formats are sensible thing to present to the end user. I was also thinking
> about partial-clone, which is a concept rather than a format.

Yeah, definitely. Another good example is technical/api-credentials.
The section on credential helpers there probably ought to be in more
user-visible documentation (probably gitcredentials(7)).

-Peff
