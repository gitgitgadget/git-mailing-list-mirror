Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD7A208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 18:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbeHFVKH (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 17:10:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:44474 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729861AbeHFVKH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 17:10:07 -0400
Received: (qmail 20602 invoked by uid 109); 6 Aug 2018 18:59:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 18:59:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30402 invoked by uid 111); 6 Aug 2018 18:59:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 14:59:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 14:59:39 -0400
Date:   Mon, 6 Aug 2018 14:59:39 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
Message-ID: <20180806185938.GB18119@sigill.intra.peff.net>
References: <20180804020009.224582-1-sbeller@google.com>
 <20180804020255.225573-1-sbeller@google.com>
 <20180804060928.GB55869@aiede.svl.corp.google.com>
 <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
 <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com>
 <87zhxzsb2p.fsf@evledraar.gmail.com>
 <20180806170211.GD19053@sigill.intra.peff.net>
 <20180806171119.GC120433@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180806171119.GC120433@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06, 2018 at 10:11:19AM -0700, Jonathan Nieder wrote:

> > We're developers ourselves, and we interact with new developers that we
> > want to help.  But there are masses of people[1] building Git who are
> > _not_ developers, and want the default to be as robust as possible.
> > They're probably not going to show up in this thread.
> >
> > -Peff
> >
> > [1] I actually wonder how large that mass is. Clearly there are many
> >     orders of magnitude more users than there are developers. But I have
> >     no idea what percentage of them build from source versus using
> >     somebody else's binary package.
> 
> Relatedly, we need to think about the incentives these defaults
> create.  Personally, I want *more* naive users to be building from
> source, because then they are better able to test recent versions,
> bisect, test my patches, etc.
> 
> As I hinted in my earlier reply, I think it would be best to try some
> basic things to make DEVELOPER more visible first.  If that fails,
> then we can revisit how to make this more drastic change in a way that
> minimizes the harm (and I am not sure yet that that is possible).

Yes, I agree very much with both of those paragraphs.

-Peff
