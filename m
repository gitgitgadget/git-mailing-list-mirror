Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09199C47088
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiLATe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiLATej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:34:39 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C79093801
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:33:55 -0800 (PST)
Received: (qmail 25811 invoked by uid 109); 1 Dec 2022 19:33:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Dec 2022 19:33:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27708 invoked by uid 111); 1 Dec 2022 19:33:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Dec 2022 14:33:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Dec 2022 14:33:54 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] commit: don't lazy-fetch commits
Message-ID: <Y4kBor6o+Sclifny@coredump.intra.peff.net>
References: <Y4fFaoRFro2hNDdv@coredump.intra.peff.net>
 <20221201191150.3605771-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221201191150.3605771-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2022 at 11:11:50AM -0800, Jonathan Tan wrote:

> Jeff King <peff@peff.net> writes:
> > OK, so we know we want a commit object because we're in the
> > commit-parsing function, so we just ask to disable fetching.
> > 
> > Two devil's advocate thoughts:
> [...]
> 
> Thanks for taking a look. Let me know if you think that the commit message
> could be improved to cover these cases. Right now I think that e.g. "When
> parsing an object believed to be a commit in repo_parse_commit_internal()"
> instead of "When parsing commits" wouldn't add much value, but I might be
> missing something.

I think your commit message is OK as-is. I was mostly just laying out my
thoughts in reviewing. Some of that could go into the commit message as
notes, but I think it is sufficient that they're here in the list
archive.

-Peff
