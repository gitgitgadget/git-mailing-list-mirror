Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FEC71F463
	for <e@80x24.org>; Tue, 24 Sep 2019 20:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfIXUw2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 16:52:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:58860 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727890AbfIXUw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 16:52:28 -0400
Received: (qmail 11027 invoked by uid 109); 24 Sep 2019 20:52:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 20:52:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12533 invoked by uid 111); 24 Sep 2019 20:54:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2019 16:54:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Sep 2019 16:52:27 -0400
From:   Jeff King <peff@peff.net>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org,
        git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
Message-ID: <20190924205226.GB20858@sigill.intra.peff.net>
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <20190924171214.GA11452@dentonliu-ltm.internal.salesforce.com>
 <20190924200533.pfi7zjv73zklaahw@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924200533.pfi7zjv73zklaahw@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 25, 2019 at 01:35:33AM +0530, Pratyush Yadav wrote:

> > As I said above, I couldn't find a public list of the people who were on
> > the project committee. Perhaps that's because my Googling skills are bad
> > but I feel uncomfortable knowing that *anyone* will be given judge, jury
> > and executioner power, let alone people whom I don't know anything
> > about.
>  
> I agree with this. I would certainly like to know who the people who 
> will judge these cases are.

See my other reply to Denton for details here.

> I want to add another question: what will the judgement process be like? 
> Will it be an open discussion on this list, or will it be decided behind 
> closed doors by the committee, and we just get to hear the results?

I think we'll have to approach this on a case by case basis to some
degree. If people are having conflict on the mailing list, I'd like to
see it resolved there, too. If somebody is sexually assaulted at the Git
Contributor Summit, that probably needs to be handled with more
discretion.

Keep in mind that a lot of this isn't changing the status quo. When we
had a problem on the mailing list in the past, it was discussed on the
list _and_ in private. And ultimately decisions came down to the
maintainer: am I going to start ignoring this person's patches, or will
I continue to encourage them to interact with the project even though
they're causing problems.

So I think a lot of this is really just writing down the current
practice.

> While there might be no plans regarding this as of now, I'd _really_ 
> like an open discussion regarding these issues that arise in the future, 
> rather than it being decided behind closed doors with us regular old
> contributors getting no say in it. A closed discussion would be much 
> more prone to power abuse, if any.

Yes, I don't like the idea of creating a pseudo-judicial system that has
none of the normal guarantees of rights (like say, facing your accuser
and seeing their evidence). At the same time, I don't want to re-create
a court system (badly). Especially given that most of our enforcement is
pretty "soft" in the first place; i.e., the most we can probably do is
stop interacting with a person, and maybe ask vger admins to block them
from using the list.

-Peff
