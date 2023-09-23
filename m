Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344DCCE7A88
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 07:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjIWHA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 03:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIWHA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 03:00:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF721A8
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 00:00:20 -0700 (PDT)
Received: (qmail 9585 invoked by uid 109); 23 Sep 2023 07:00:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Sep 2023 07:00:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24921 invoked by uid 111); 23 Sep 2023 07:00:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 03:00:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 03:00:19 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/6] coverity: allow overriding the Coverity project
Message-ID: <20230923070019.GD1469941@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <6c1c82862814f40a408231cb249fb4b653276b52.1695379323.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c1c82862814f40a408231cb249fb4b653276b52.1695379323.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 10:42:00AM +0000, Johannes Schindelin via GitGitGadget wrote:

> +# By default, the builds are submitted to the Coverity project `git`. To override this,
> +# set the repository variable `COVERITY_PROJECT`.

This may not matter all that much, because I don't expect most people to
set this up for their forks (and if we have git/git results that I have
access to, I will probably even stop building my peff/git one). But I
just wondered if a better default would be the GitHub project name
(i.e., $user/git).

It has been long enough that I do not remember all of the setup on the
Coverity side, but I assumed there was some "set it up for this GitHub
project" button. But maybe I just picked that name myself.

-Peff
