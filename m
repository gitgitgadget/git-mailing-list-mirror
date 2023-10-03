Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB06E8FDB3
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbjJCUc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJCUcz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:32:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA0AB
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:32:52 -0700 (PDT)
Received: (qmail 14918 invoked by uid 109); 3 Oct 2023 20:32:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:32:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15072 invoked by uid 111); 3 Oct 2023 20:32:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:32:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:32:51 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: batch-command wishlist [was: [TOPIC 02/12] Libification Goals
 and Progress]
Message-ID: <20231003203251.GA7933@coredump.intra.peff.net>
References: <20231003005251.M353509@dcvr>
 <20231003201048.GD1562@coredump.intra.peff.net>
 <20231003203124.M560967@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003203124.M560967@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 08:31:24PM +0000, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > I know that you asked for a persistent process, but just for reference,
> > you can hackily access approxidate with:
> > 
> >   git config --type=expiry-date --default='15 days ago' does.not.exist
> 
> --type is too new (trying to support 1.8.x :<).  But yeah, using
> `git rev-parse --since=15.days.ago` and extracting the integers

Ah, that is probably less hacky than my suggestion anyway.

-Peff
