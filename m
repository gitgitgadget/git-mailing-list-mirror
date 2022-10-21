Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBEBC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJUF4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJUF4P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:56:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3971EB57D
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:56:13 -0700 (PDT)
Received: (qmail 10618 invoked by uid 109); 21 Oct 2022 05:56:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 05:56:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2033 invoked by uid 111); 21 Oct 2022 05:56:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 01:56:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 01:56:11 -0400
From:   Jeff King <peff@peff.net>
To:     Yehuda Katz <yehuda@ymkatz.net>
Cc:     git@vger.kernel.org
Subject: Re: Change in behavior of included safe.directory in system config
Message-ID: <Y1I0e4puVn0EQHbM@coredump.intra.peff.net>
References: <CAGBAQ45f6D=XsyiOmumpAnE+OxQpuZXhMsVegrHKsxaN5mc3eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGBAQ45f6D=XsyiOmumpAnE+OxQpuZXhMsVegrHKsxaN5mc3eQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 01:19:12AM -0400, Yehuda Katz wrote:

> There seems to be some change in behavior, either to included files or
> to safe.directory between Git 2.36.0 and 2.38.0. I don't see any
> explanation in the release notes.

It's a bug; see:

  https://lore.kernel.org/git/pull.1360.git.git.1665603814.gitgitgadget@gmail.com/

I expect the fix there will be in 2.38.2 (it didn't get into v2.38.1,
which was a pre-planned security release).

-Peff
