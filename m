Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ED3C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 11:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjBDL1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 06:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjBDL1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 06:27:16 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F4F279A0
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 03:27:14 -0800 (PST)
Received: (qmail 3555 invoked by uid 109); 4 Feb 2023 11:27:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Feb 2023 11:27:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18179 invoked by uid 111); 4 Feb 2023 11:27:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Feb 2023 06:27:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Feb 2023 06:27:13 -0500
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: The sad state of git.wiki.kernel.org
Message-ID: <Y95BEaOGJy9uBHkG@coredump.intra.peff.net>
References: <20230203182255.lqla3hsme6riy4w7@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230203182255.lqla3hsme6riy4w7@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2023 at 01:22:55PM -0500, Konstantin Ryabitsev wrote:

> Today, most information found on the wiki is probably outdated and therefore
> potentially harmful. I would like to solicit ideas what to do with this
> resource.

Yeah, my assumption is that it's totally out of date these days. I admit
that's subjective and maybe there are people maintaining/using it. I
kind of suspect not, though (and if they don't reply to this thread,
perhaps we can assume they don't exist, or at least not connected enough
to the development community to matter).

> # Should it be migrated to RTD-style docs?
> 
> We have stopped providing new Mediawiki instances at kernel.org quite some
> time back, replacing the offering with Dokuwiki. Today, we don't spin up new
> Dokuwiki instances either and everyone is steered towards readthedocs-style
> documentation instead, which is a much more sane and manageable medium than
> wikis, especially when it comes to technical docs (see
> https://korg.docs.kernel.org/docs.html).
> 
> However, it's unclear if this is even needed for this wiki, considering the
> existence of https://git-scm.com/doc.

Yeah, for any content we prepare as a community, the Documentation/ is
the right spot, and git-scm.com is just mirroring those already.

For meta-information like current-year GSoC ideas, etc, we've been using
git.github.io. It's not quite a wiki, in that you need access and
contribute to it via the git clone, but IMHO both of those are features.
Spam is a non-issue, and anybody who wants to help out can do so either
by being a committer, or just making a one-off pull request.

> # Should it be archived as a static site?
> 
> It's possible to turn git.wiki.kernel.org into a static site with a large
> header on every page that it contains historical archival information, with a
> link to https://git-scm.com/doc

This would be my preference, just because some of the old content may
still have value. Some pages (like old gsoc stuff) would better redirect
to git.github.io, but it is probably not worth the time to even try to
classify pages.

> # Should it be archived and put out of its misery?
> 
> The last option is to just archive the site and put it out of its increasingly
> irrelevant existence.

I'm also OK with this, though if it is not too much work to serve the
old content with a warning that it may be out-of-date, that seems
better.

-Peff
