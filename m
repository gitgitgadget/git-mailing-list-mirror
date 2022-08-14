Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E15C25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 06:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiHNGnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 02:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHNGnV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 02:43:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D75F99E
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 23:43:20 -0700 (PDT)
Received: (qmail 18544 invoked by uid 109); 14 Aug 2022 06:43:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 14 Aug 2022 06:43:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31519 invoked by uid 111); 14 Aug 2022 06:43:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Aug 2022 02:43:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 14 Aug 2022 02:43:18 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: "bubbling up" patches in a commit sequence.
Message-ID: <YviZho4/BlRRNWEn@coredump.intra.peff.net>
References: <CANgJU+VYSuEkU+V0WRpsTPv9iPYeDo52MeMHuD7-Yp4JnA60NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgJU+VYSuEkU+V0WRpsTPv9iPYeDo52MeMHuD7-Yp4JnA60NA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 13, 2022 at 10:45:53AM +0200, demerphq wrote:

> In general I do this when I want to find a "fixup" pair that should be
> merged together before the PR is pushed, but there are other reasons,
> sometimes a PR contains a number of sub topics which are evolving and
> using this technique  can help the patches related to different sub
> topics be grouped together for easier review.
> 
> Anybody created tooling to do something like this? Or suggestions on
> how to approach it efficiently?

I haven't used these myself, but there are some projects that might do
what you want:

   - https://github.com/tummychow/git-absorb

   - https://github.com/torbiak/git-autofixup

> Please forgive me for not using the correct specialist git jargon for
> these concepts, if there is any.

I think the key term is "absorb", but don't feel bad. I didn't remember
that either, but only had a vague feeling I had seen something recently.
I skimmed the "tools" section of the last couple issues of Git Rev News
(thanks, Rev News editors!) which led me to autofixup, which mentioned
"absorb". :)

-Peff
