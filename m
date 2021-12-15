Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA82C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 16:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbhLOQi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 11:38:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:52452 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231316AbhLOQi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 11:38:27 -0500
Received: (qmail 17855 invoked by uid 109); 15 Dec 2021 16:38:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Dec 2021 16:38:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6009 invoked by uid 111); 15 Dec 2021 16:38:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Dec 2021 11:38:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Dec 2021 11:38:25 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: taking a break from Git
Message-ID: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all,

I'm going to be offline and completely absent from the mailing list for
five months starting at the end of December. After that, things are up
in the air, but I may not be as involved in the project as I have been.

Sorry, there's no juicy gossip or drama to share. I still like everyone,
and think it's a cool project. ;) After 15 years, it just feels like
it's time for a break and to perhaps apply my brain to something else
for a while.

There are a couple logistical things related to this:

  - I'm planning to step down from Git's Project Leadership Committee
    (the entity that represents Git within Software Freedom Conservancy,
    and which occasionally makes decisions on things like our project
    funds or assets like the trademark).

    That leaves Junio, Ævar, and Christian on the PLC, and the charter
    calls for having at least 3 members. So I don't technically need to
    be replaced, but maybe it's an opportunity for somebody else to get
    involved.

    We don't have a formal process here. The last discussion on adding
    new members was this thread from a few years ago:

      https://lore.kernel.org/git/20180816224138.GA15490@sigill.intra.peff.net/

  - I maintain the git-scm.com site (well, insofar as anybody does).
    There are a few regulars who review and merge pull requests at
    https://github.com/git/git-scm.com, but more help is always welcome
    there.

    The production parts of the site run on Heroku and Cloudflare. They
    don't need touched often, though we do trigger a manual update and
    flush the caches right after Junio releases, so that the site is
    updated immediately.  The Git PLC has the necessary credentials for
    those sites, though in practice I think I'm the only one there that
    touched it. Taylor (cc'd) has been helping out with that and also
    has access.

    If you want to get involved, I'd suggest subscribing to the repo
    linked above, and just helping out with issue/PR triage and
    response.  And of course bug fixes, features, and content updates
    are welcome, too. The README.md and ARCHITECTURE.md documents give
    an overview.

  - I really am going to stop reading the list. Even if you cc me. So
    please don't get mad if I don't review your patches, or respond to
    bug reports. :)

    Likewise, I'll be around for a bit more, and am trying to wrap up
    some personal topics and reviews. But undoubtedly I'll end up
    dropping many on the floor. Though that probably would have happened
    over the holidays anyway!

-Peff
