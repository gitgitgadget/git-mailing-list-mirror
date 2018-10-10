Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BD671F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 15:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJJW3g (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 18:29:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:35586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726649AbeJJW3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 18:29:36 -0400
Received: (qmail 25568 invoked by uid 109); 10 Oct 2018 15:07:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Oct 2018 15:07:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18103 invoked by uid 111); 10 Oct 2018 15:06:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 11:06:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 11:06:58 -0400
Date:   Wed, 10 Oct 2018 11:06:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
Message-ID: <20181010150658.GA31986@sigill.intra.peff.net>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
 <87efcyfd0r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87efcyfd0r.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 09:59:16AM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Oct 10 2018, Junio C Hamano wrote:
> 
> > * jk/drop-ancient-curl (2017-08-09) 5 commits
> >  - http: #error on too-old curl
> >  - curl: remove ifdef'd code never used with curl >=7.19.4
> >  - http: drop support for curl < 7.19.4
> >  - http: drop support for curl < 7.16.0
> >  - http: drop support for curl < 7.11.1
> >
> >  Some code in http.c that has bitrot is being removed.
> >
> >  Expecting a reroll.
> 
> There's been no activity on this for 6 months since I sent a "hey what's
> going on with it" E-Mail in:
> https://public-inbox.org/git/20180404204920.GA15402@sigill.intra.peff.net/
> 
> Maybe it should just be dropped?

That's fine with me. I think it was a nice cleanup as long as nobody
cared, but some people did seem to care. Maybe they care less now that
more time has passed, but it just hasn't really been worth the time to
revisit.

I'm OK to drop it; the patches are on the list if we want to look at it
again later.

-Peff
