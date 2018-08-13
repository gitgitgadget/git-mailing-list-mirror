Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086361F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbeHNAij (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 20:38:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:53916 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730114AbeHNAij (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 20:38:39 -0400
Received: (qmail 18090 invoked by uid 109); 13 Aug 2018 21:54:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Aug 2018 21:54:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14272 invoked by uid 111); 13 Aug 2018 21:54:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 17:54:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 17:54:32 -0400
Date:   Mon, 13 Aug 2018 17:54:32 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: Contributor Summit planning
Message-ID: <20180813215431.GB16006@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
 <20180813210617.GA19738@sigill.intra.peff.net>
 <CAGZ79kaNa2bo31rQexs4rAH6bAz1rMzpxS3-fSFE6Cj87E8saw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaNa2bo31rQexs4rAH6bAz1rMzpxS3-fSFE6Cj87E8saw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 02:19:07PM -0700, Stefan Beller wrote:

> However the mailing list participation numbers there doesn't really
> help me:
> 
> ~/git-ml$ git shortlog --since 2017 -sne
>   3721  Junio C Hamano <gitster@pobox.com>
>   2166  Stefan Beller <stefanbeller@gmail.com>
>   2071  Jeff King <peff@peff.net>
> 
> and I certainly do not provide as much value as Junio or you do;
> I am just good at resending long patch series to drive up the email
> count. But I think that data would be also interesting to look at if
> we were to find out what drives the community.
> 
> Maybe some derived metrics posts on mailing list divided by
> commits appearing in origin/next can guide if one is a effective
> contributor; but then as you said there are other ways to contribute
> effectively as well.

You could probably just drop any emails that start with "[PATCH" from
your count. They are ultimately counted separately in "git shortlog" on
the actual repo. And if you are sending tons of re-rolls you just do not
get any credit. ;)

The rabbit hole is deep there, though. Is it productive to have bugs in
your patch which force somebody else to reply (they get a point, good),
and then you have to respond explaining what's going on (you get a
point, bad, since you're now ahead of a hypothetical you who didn't have
the bug in the first place).

So I try not to think too hard on metrics, and just use them to get a
rough view on who is active.

> Reviewing and bug triage do show up in the mailing
> list but not as commits in git.git, but the numbers alone would
> not hint at the quality. In fact the opposite is the case: if you only
> need one email to diagnose a bug, suggest a workaround and
> include a proper patch, it is more helpful to the community than
> having more emails, potentially going back and forth.

Yep, another good example. More emails may mean you are incompetent at
diagnosing, or it may mean you are digging on a particularly hard
problem.

-Peff
