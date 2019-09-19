Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10FF91F463
	for <e@80x24.org>; Thu, 19 Sep 2019 22:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407244AbfISW0M (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 18:26:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:55326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2407235AbfISW0J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 18:26:09 -0400
Received: (qmail 8958 invoked by uid 109); 19 Sep 2019 22:26:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Sep 2019 22:26:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5088 invoked by uid 111); 19 Sep 2019 22:28:22 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Sep 2019 18:28:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Sep 2019 18:26:07 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20190919222607.GA25680@sigill.intra.peff.net>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <20190919173423.GA70421@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919173423.GA70421@dentonliu-ltm.internal.salesforce.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 10:34:23AM -0700, Denton Liu wrote:

> > 4. Add an official Code of Conduct
> > 
> > So far, the community has had an unofficial policy of "be nice,
> > as much as possible". We should add a Code of Conduct that is
> > more explicit about the behavior we want to model. This was also
> > discussed in the meeting with wide approval.
> 
> From what I've personally read and experienced, I don't think that an
> official Code of Conduct is really warranted. Everyone I've interacted
> with has been really kind. Perhaps a new contributor might interpret the
> curtness of replies here as someone being rude but I quickly learned
> that it's more out of necessity since everyone is busy.
> 
> From reading the mailing list archives, I know that in the past, there
> have been some flamewars and some abrasive individuals but I think
> that's a problem of the past.

I've had similar thoughts over the years, but eventually switched my way
of thinking. I think part of that switch was coming to the conclusion
that most of the value of a Code of Conduct isn't about having a system
of enforcement against bad actors (in fact, I think that's the most
difficult and potentially problematic part, because it creates a sort of
justice system). IMHO the most important part is that it communicates
and reinforces norms:

  - It lets good actors easily understand what the expectations are.

  - It gives a framework for agreed-upon principles, so that people can
    more easily and productively discuss the conflicts that do happen.

  - It advertises our values to people outside the community, which may
    help make us more inviting for people to join (and ultimately
    contribute code, or docs, or reviews, etc).

> I also see some drawbacks to implementing a CoC as well. First of all,
> it just feels like unnecessary bureaucracy. Second, I think it'll
> probably cause a stir like it did when the Linux kernel introduced it.
> Of course, all that noise will die down eventually but I feel like it'll
> bring the wrong kind of attention to Git.

I've also been worried about that. And it's easy to think "nobody is
behaving too badly right now, so it's all a net negative since we risk a
trollish flamewar". But I think it's easy to discount "invisible"
negatives of the status quo, like people who are hesitant to join the
community because of the lack of a CoC. We in the community don't see
that. And even for people who remember what it was like to join, many
people have different expectations and experiences. If we can easily
make ourselves more inviting to a wider range of people, that seems like
a win.

-Peff
