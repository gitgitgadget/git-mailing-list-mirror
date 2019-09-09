Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 488A91F461
	for <e@80x24.org>; Mon,  9 Sep 2019 17:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfIIRAE (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 13:00:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:44298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727040AbfIIRAE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 13:00:04 -0400
Received: (qmail 20411 invoked by uid 109); 9 Sep 2019 17:00:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Sep 2019 17:00:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10441 invoked by uid 111); 9 Sep 2019 17:01:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2019 13:01:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Sep 2019 13:00:03 -0400
From:   Jeff King <peff@peff.net>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190909170002.GA30399@sigill.intra.peff.net>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190904194114.GA31398@sigill.intra.peff.net>
 <20190908145610.3ho2wo5qqiw3u4lz@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190908145610.3ho2wo5qqiw3u4lz@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 08, 2019 at 08:26:10PM +0530, Pratyush Yadav wrote:

> I'd like to put out a proposal regarding first contributions and micro 
> projects.
> 
> I have a small list of small isolated features and bug fixes that
> _I think_ git-gui would benefit with. And other people using it can 
> probably add their pet peeves and issues as well. My question is, are 
> these something new contributors should try to work on as an 
> introduction to the community? Since most of these features and fixes 
> are small and isolated, they should be pretty easy to work on. And I 
> think people generally find UI apps a little easier to work on.
> 
> But I'll play the devil's advocate on my proposal and point out some 
> problems/flaws:
> - Git-gui is written in Tcl, and git in C (and other languages too, but 
>   not Tcl). That means while people do get a feel of the community and 
>   general workflow, they don't necessarily get a feel of the actual git 
>   internal codebase.
> - Since I don't see a git-gui related project worth being into the 
>   Outreachy program, it essentially means they will likely not work on 
>   anything related to their project.
> - Git-gui is essentially a wrapper on top of git, so people won't get 
>   exposure to the git internals.
> 
> I'd like to hear your and the rest of the community's thoughts about 
> this proposal, and whether it will be a good idea or not.

Right, I came up with similar devil's advocate arguments. :) I'm not
totally opposed, because part of the point of these microprojects just
getting people familiar with interacting with the community and
submitting a patch. They're not always in the same area the intern
intends to work, just because there's not always a trivial problem to be
solved there.

So we do look at it mostly as a "can you do this basic test" test, and
not necessarily as a prelude to the project.

But it would be nice if it were at least in the same _language_ that the
ultimate project will be done in. Because we're evaluating the
applicant's ability to write code in that language, too.

So I dunno. I am on the fence.

-Peff
