Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D23520248
	for <e@80x24.org>; Wed,  6 Mar 2019 19:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfCFTIW (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 14:08:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:41312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726394AbfCFTIW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 14:08:22 -0500
Received: (qmail 26984 invoked by uid 109); 6 Mar 2019 19:08:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Mar 2019 19:08:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16236 invoked by uid 111); 6 Mar 2019 19:08:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Mar 2019 14:08:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2019 14:08:19 -0500
Date:   Wed, 6 Mar 2019 14:08:19 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
Message-ID: <20190306190819.GC18239@sigill.intra.peff.net>
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <CACsJy8DhDe+28z2=3v1dBqco7q2Zj12hdKKT==yWFPui8SBkiw@mail.gmail.com>
 <20190306044955.GC6664@sigill.intra.peff.net>
 <CACsJy8BaCMsXhXSAwu+wmZCTwL5TO8wVDtGd87vRwH=AcOsThA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BaCMsXhXSAwu+wmZCTwL5TO8wVDtGd87vRwH=AcOsThA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 04:36:12PM +0700, Duy Nguyen wrote:

> > It seems like that would even be pretty easy to do, with the exception
> > of the numbering.
> 
> I'd like some niceties from test-lib.sh though. -i should be supported
> to stop at the first failure. -v would be nice if possible. Skipping
> tsets also.

Yeah, I'd want all of those, too. I think they're easier, though,
because it's not too hard to get information _into_ the C program via
the environment. But still, somebody has to write the code. :)

-Peff
