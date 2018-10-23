Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D051F453
	for <e@80x24.org>; Tue, 23 Oct 2018 20:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeJXE1l (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 00:27:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:51624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725266AbeJXE1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 00:27:41 -0400
Received: (qmail 6310 invoked by uid 109); 23 Oct 2018 20:02:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Oct 2018 20:02:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26151 invoked by uid 111); 23 Oct 2018 20:02:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Oct 2018 16:02:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2018 16:02:46 -0400
Date:   Tue, 23 Oct 2018 16:02:46 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v1 2/2] reset: add new reset.quietDefault config setting
Message-ID: <20181023200245.GA15214@sigill.intra.peff.net>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181017164021.15204-3-peartben@gmail.com>
 <CAPig+cQ3ia78pLtnHSq8tM3B-XnFgWhwowJxwacYEEzXosJ16g@mail.gmail.com>
 <20181017182337.GD28326@sigill.intra.peff.net>
 <874lddc9fs.fsf@evledraar.gmail.com>
 <1ba81f12-7040-1ba5-2009-fa681caf9874@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ba81f12-7040-1ba5-2009-fa681caf9874@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 02:11:01PM -0400, Ben Peart wrote:

> This sounds like an easy way to choose a set of default values that we think
> make sense to get bundled together. That could be a way for users to quickly
> choose a set of good defaults but I still think you would want find grained
> control over the individual settings.
> 
> Coming up with the set of values to bundle together, figuring out the
> hierarchy of precedence for this new global config->individual
> config->individual command line, updating the code to make it all work is
> outside the scope of this particular patch series.

True, it probably does make sense to give individual defaults. Having a
unifying option may help with the discoverability issue you were
thinking of elsewhere, though.

-Peff
