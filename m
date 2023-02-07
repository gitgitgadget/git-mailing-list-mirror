Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60096C636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjBGSKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjBGSKB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:10:01 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355543A588
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:10:00 -0800 (PST)
Received: (qmail 11102 invoked by uid 109); 7 Feb 2023 18:09:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Feb 2023 18:09:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23102 invoked by uid 111); 7 Feb 2023 18:09:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Feb 2023 13:09:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Feb 2023 13:09:58 -0500
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: The sad state of git.wiki.kernel.org
Message-ID: <Y+KT9pHivnUyyu0K@coredump.intra.peff.net>
References: <20230203182255.lqla3hsme6riy4w7@meerkat.local>
 <Y95BEaOGJy9uBHkG@coredump.intra.peff.net>
 <CAP8UFD1q7-XbX4C_NjyL7A-6n6Nc4MgSbUKnzQOiRyKRMtLv_w@mail.gmail.com>
 <20230206214101.fe6rismtfzv4k75n@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230206214101.fe6rismtfzv4k75n@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 06, 2023 at 04:41:01PM -0500, Konstantin Ryabitsev wrote:

> On Sat, Feb 04, 2023 at 03:03:16PM +0100, Christian Couder wrote:
> > > > # Should it be archived as a static site?
> > > >
> > > > It's possible to turn git.wiki.kernel.org into a static site with a large
> > > > header on every page that it contains historical archival information, with a
> > > > link to https://git-scm.com/doc
> > >
> > > This would be my preference, just because some of the old content may
> > > still have value. Some pages (like old gsoc stuff) would better redirect
> > > to git.github.io, but it is probably not worth the time to even try to
> > > classify pages.
> > 
> > This would be my preference too. I agree that some old content might
> > still have some value. We could also move or redirect some old content
> > to git.github.io, but I am not sure it's worth the time either.
> 
> Okay, here's what I have:
> 
> https://archive.kernel.org/oldwiki/git.wiki.kernel.org/
> 
> It's just a static scrape excluding all Special: and User: pages, and carrying
> a very large "OBSOLETE CONTENT" warning.

That looks just fine to me. Thanks for taking care of this!

-Peff
