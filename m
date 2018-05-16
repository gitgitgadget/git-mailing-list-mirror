Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4B0D1F406
	for <e@80x24.org>; Wed, 16 May 2018 23:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeEPXpv (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:45:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:43964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751379AbeEPXpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 19:45:50 -0400
Received: (qmail 31011 invoked by uid 109); 16 May 2018 23:45:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 May 2018 23:45:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30111 invoked by uid 111); 16 May 2018 23:45:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 16 May 2018 19:45:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2018 16:45:47 -0700
Date:   Wed, 16 May 2018 16:45:47 -0700
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Message-ID: <20180516234546.GA8521@sigill.intra.peff.net>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87po1waqyc.fsf@evledraar.gmail.com>
 <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
 <87muwzc2kv.fsf@evledraar.gmail.com>
 <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
 <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
 <20180516191410.GA3417@sigill.intra.peff.net>
 <CAGZ79kaVroLhEu+QmTwLCpv1irst5zbnQBzg7xLkfFy8cC9owA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaVroLhEu+QmTwLCpv1irst5zbnQBzg7xLkfFy8cC9owA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 02:18:20PM -0700, Stefan Beller wrote:

> >
> > You can also do periodic maintenance like:
> >
> >   1. Copy each ref in the forked repositories into the parent repository
> >      (e.g., giving each child that borrows from the parent its own
> >      hierarchy in refs/remotes/<child>/*).
> 
> Can you just copy? I assume the mother repo doesn't know about
> all objects, hence by copying the ref, we have a "spotty" history.
> 
> And to improve copying could permanent symlinking be used instead?

Sorry, by copying, I meant "fetching". I.e., migrating objects and refs.

-Peff
