Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1A2C67871
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 00:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiJYAwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiJYAwP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 20:52:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6215E7330A
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 16:33:19 -0700 (PDT)
Received: (qmail 4497 invoked by uid 109); 24 Oct 2022 23:33:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Oct 2022 23:33:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11773 invoked by uid 111); 24 Oct 2022 23:33:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Oct 2022 19:33:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 24 Oct 2022 19:33:17 -0400
From:   Jeff King <peff@peff.net>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
Message-ID: <Y1cgvTcMk6OT4axk@coredump.intra.peff.net>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221022011931.43992-1-michael@mcclimon.org>
 <20221022011931.43992-3-michael@mcclimon.org>
 <Y1Rdtog/XQV0YLj0@coredump.intra.peff.net>
 <Y1Rp+7R7e+LFa5k6@coredump.intra.peff.net>
 <Y1R6ecMO+6X8tFlF@newk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1R6ecMO+6X8tFlF@newk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 22, 2022 at 07:19:21PM -0400, Michael McClimon wrote:

> > I prepared it on top of your fix in the mm/git-pm-try-catch-syntax-fix
> > branch. That's not strictly necessary, since my patch deletes the line
> > you fixed. :) But I think it's nicer to use your fix as the starting
> > point, since it means the test runs but produces the wrong behavior,
> > rather than barfing with a syntax error.
> 
> My vanity thanks you for this, even if it's not strictly necessary. As a
> professional programmer with roughly no C chops and a long-time admirer of the
> Git project, all I _really_ wanted to do was to fix a thing that was in my
> wheelhouse so that I could say I have a commit in the history. (This isn't a
> good reason on its own, of course, but I'm happy it was useful even if the
> line is immediately deleted!)

:) I think it makes my patch easier to understand, but I'm glad you are
getting some you, too. Finding the original issue and the ensuing
discussion was as much (or more) effort than the actual fix. Thanks for
starting it!

-Peff
