Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF35C388F9
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 01:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5808E24695
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 01:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgKQBvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:51:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:59962 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgKQBvv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 20:51:51 -0500
Received: (qmail 13175 invoked by uid 109); 17 Nov 2020 01:51:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 01:51:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21397 invoked by uid 111); 17 Nov 2020 01:51:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Nov 2020 20:51:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Nov 2020 20:51:49 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 00/11] Fix color handling in git add -i
Message-ID: <20201117015149.GC19433@coredump.intra.peff.net>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
 <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 04:08:21PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Changes since v2:
> 
>  * The commit messages of patches 7/11 and 9/11 now stress why we want to
>    align the output of the Perl vs the built-in version so slavishly: to be
>    able to validate both versions against prerecorded output.
>  * A typo was fixed in the commit message of patch 10/11.

This version looks fine to me, and I agree is a good stopping point for
now (the only thing I'd consider adding is a test for the funcname in a
split-hunk header, but it would have to be expect_failure for now; it is
probably not worth the effort to rewrite the perl version to behave like
the builtin here if we think it's going away soon).

-Peff
