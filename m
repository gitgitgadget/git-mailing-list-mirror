Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A7FC77B71
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 08:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDOI7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 04:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDOI7W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 04:59:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22475902E
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 01:59:19 -0700 (PDT)
Received: (qmail 28567 invoked by uid 109); 15 Apr 2023 08:59:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Apr 2023 08:59:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3055 invoked by uid 111); 15 Apr 2023 08:59:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Apr 2023 04:59:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Apr 2023 04:59:18 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Bock <bockthom@cs.uni-saarland.de>
Cc:     git@vger.kernel.org
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order':
 Commits from 2011 are treated to be before 1980
Message-ID: <20230415085918.GA679010@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230415085207.GA656008@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2023 at 04:52:07AM -0400, Jeff King wrote:

> There may be also cases where the two diverge. Obviously having two

Sorry, my ability to type is going rapidly downhill this evening.

I meant to say "there may be other cases where the two diverge". I.e.,
the best way to be sure they behave the same is to make them share code.

-Peff
