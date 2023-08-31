Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CC4C83F35
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 17:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbjHaRmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjHaRmT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 13:42:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D445ECF3
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 10:42:16 -0700 (PDT)
Received: (qmail 25357 invoked by uid 109); 31 Aug 2023 17:42:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 17:42:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9285 invoked by uid 111); 31 Aug 2023 17:42:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 13:42:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 13:42:15 -0400
From:   Jeff King <peff@peff.net>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/10] lower core.maxTreeDepth default to 2048
Message-ID: <20230831174215.GA3208283@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
 <20230831062320.GJ3185325@coredump.intra.peff.net>
 <ZPBt6VYAWHJhv3N2@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPBt6VYAWHJhv3N2@ugly>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 12:39:37PM +0200, Oswald Buddenhagen wrote:

> On Thu, Aug 31, 2023 at 02:23:20AM -0400, Jeff King wrote:
> > But I thought that
> > following the sequence of logic (from "4096 is probably OK" to "whoops,
> > it's not") had some value to share.
> > 
> of course, but you can just integrate that into the squashed commit message.
> having it all in one place makes it easier to follow.

Yes, though I think having it as a separate patch makes it easier to
revisit later (e.g., by reverting or by replacing the patch during a
re-roll).

-Peff
