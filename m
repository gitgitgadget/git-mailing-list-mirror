Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A6EC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 13:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDVN4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjDVNy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 09:54:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A971FE3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 06:54:56 -0700 (PDT)
Received: (qmail 13667 invoked by uid 109); 22 Apr 2023 13:54:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 13:54:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29004 invoked by uid 111); 22 Apr 2023 13:54:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 09:54:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 09:54:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 0/2] coverity null-check fixes
Message-ID: <20230422135455.GA3942740@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are two cases I happened to notice via Coverity. Neither produces
a user-visible bug; it's just slightly misleading code which can be
cleaned up.

The first one is ancient, but since the nearby code changed, Coverity
considered it new. :)

The second one is actually recent; I noted it already on the list, but
it was already in 'next' at that point and is now in 'master'.

-Peff
