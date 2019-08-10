Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D55751F731
	for <e@80x24.org>; Sat, 10 Aug 2019 06:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfHJGDx (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 02:03:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:39728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725601AbfHJGDw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 02:03:52 -0400
Received: (qmail 16324 invoked by uid 109); 10 Aug 2019 06:03:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 10 Aug 2019 06:03:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3932 invoked by uid 111); 10 Aug 2019 06:06:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 10 Aug 2019 02:06:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 10 Aug 2019 02:03:51 -0400
From:   Jeff King <peff@peff.net>
To:     Mark Rushakoff via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Mark Rushakoff <mark.rushakoff@gmail.com>
Subject: Re: [PATCH 1/1] doc: fix repeated words
Message-ID: <20190810060351.GA25876@sigill.intra.peff.net>
References: <pull.309.git.gitgitgadget@gmail.com>
 <76831150995dd3e7847825192b22114a6d4906d1.1565416752.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76831150995dd3e7847825192b22114a6d4906d1.1565416752.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 09, 2019 at 10:59:14PM -0700, Mark Rushakoff via GitGitGadget wrote:

> From: Mark Rushakoff <mark.rushakoff@gmail.com>
> 
> Inspired by 21416f0a07 ("restore: fix typo in docs", 2019-08-03), I ran
> "git grep -E '(\b[a-zA-Z]+) \1\b' -- Documentation/" to find other cases
> where words were duplicated, e.g. "the the", and in most cases removed
> one of the repeated words.
> 
> There were many false positives by this grep command, including
> deliberate repeated words like "really really" or valid uses of "that
> that" which I left alone, of course.
> 
> I also did not correct any of the legitimate, accidentally repeated
> words in old RelNotes.

Thanks. I read over each of these, and they are all obviously the right
thing to do.

-Peff
