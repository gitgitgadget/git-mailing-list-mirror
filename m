Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB0FCE7A8C
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 07:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjIWHG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 03:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIWHGy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 03:06:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4199199
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 00:06:48 -0700 (PDT)
Received: (qmail 9620 invoked by uid 109); 23 Sep 2023 07:06:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Sep 2023 07:06:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24977 invoked by uid 111); 23 Sep 2023 07:06:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 03:06:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 03:06:47 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 5/6] coverity: allow running on macOS
Message-ID: <20230923070647.GB1471672@coredump.intra.peff.net>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
 <782cf2b440313fcad0492ee352fa66d1a3534ac4.1695379323.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <782cf2b440313fcad0492ee352fa66d1a3534ac4.1695379323.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 10:42:02AM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> For completeness' sake, let's add support for submitting macOS builds to
> Coverity Scan.

I don't have any real problem with this, and it will check a few extra
bits of platform-specific code not covered elsewhere. My big question
would be: how much extra does this cost to run each time?

I guess it is not too much (compared to regular CI); my coverity build
job ran in 7 minutes, and that is including the download of the tool.

-Peff
