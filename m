Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04022ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 15:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiIAPp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiIAPpx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 11:45:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A991A61B3F
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 08:45:51 -0700 (PDT)
Received: (qmail 24667 invoked by uid 109); 1 Sep 2022 15:45:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Sep 2022 15:45:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10469 invoked by uid 111); 1 Sep 2022 15:45:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Sep 2022 11:45:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Sep 2022 11:45:49 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 3/3] add -p: ignore dirty submodules
Message-ID: <YxDTrUI0kOkQr9q5@coredump.intra.peff.net>
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
 <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
 <116f0cf5cabee3590957731740b33e800b762f34.1661977877.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <116f0cf5cabee3590957731740b33e800b762f34.1661977877.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2022 at 08:31:17PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Thanks to alwyas running `diff-index` and `diff-files` with the

Not a big deal, but since it sounds like you're going to re-roll anyway:

  s/alwyas/always/

I hadn't been closely following the earlier iterations of this series,
but the approach of this version definitely matches what I'd expected to
see based on our previous discussions about filters.

Modulo the coloring thing Phillip brought up in patch 2, it all looks
good to me. Thanks for working on it. I know you said earlier that the
bugs we've found in the conversion make you hesitant to remove the perl
version for now. But to me, your responsiveness in fixing those bugs
gives me more confidence in dumping the perl one. ;) (eventually, at
least)

-Peff
