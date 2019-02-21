Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34DB1F462
	for <e@80x24.org>; Thu, 21 Feb 2019 12:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfBUMgs (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 07:36:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:52388 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725385AbfBUMgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 07:36:48 -0500
Received: (qmail 19684 invoked by uid 109); 21 Feb 2019 12:36:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 12:36:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11632 invoked by uid 111); 21 Feb 2019 12:37:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 07:37:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 07:36:46 -0500
Date:   Thu, 21 Feb 2019 07:36:46 -0500
From:   Jeff King <peff@peff.net>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v8 0/3]
Message-ID: <20190221123646.GA12185@sigill.intra.peff.net>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190219083123.27686-1-nbelakovski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219083123.27686-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 05:31:20PM +0900, nbelakovski@gmail.com wrote:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
> 
> I've made the various cosmetic changes that were suggested, as well as adding tests for 3/3
> 
> I don't have a particularly strong opinion on the subject of keeping the atom as "worktreepath"
> or changing it to "worktree:path". We did feel earlier in this thread that if we went with
> "worktree:path", then "worktree" is somewhat ambiguous, and that discussion led to deciding to
> have "worktree" return the path,. After that I chose to name it "worktreepath" because I like to
> make things explicit and intuitive.

I am OK with it either way. We have used ":" for some variants (e.g.,
objectsize:disk). But we have also used long single names with related
prefixes (e.g., objectname versus objecttype versus objectsize).

Patch 1 looks good to me. Given that we're on v8 and most of the other
comments are for patches 2 and 3, I think we might consider graduating
it separately if the other two are not ready soon. It's independently
useful, IMHO.

I have a few comments on the others which I'll leave as replies there.

-Peff
