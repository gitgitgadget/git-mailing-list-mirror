Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990FDC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 19:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbhLATqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:46:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:41340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240028AbhLATqE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 14:46:04 -0500
Received: (qmail 17390 invoked by uid 109); 1 Dec 2021 19:42:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Dec 2021 19:42:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9813 invoked by uid 111); 1 Dec 2021 19:42:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Dec 2021 14:42:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Dec 2021 14:42:41 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document which output goes to stdout
 vs. stderr
Message-ID: <YafQMTsU2+vLNalY@coredump.intra.peff.net>
References: <20211201053214.2902-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211201053214.2902-1-sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 01, 2021 at 12:32:14AM -0500, Eric Sunshine wrote:

> It has long been practice in this project for a command to emit its
> primary output to stdout so that it can be captured to a file or sent
> down a pipe, and to emit "chatty" messages (such as those reporting
> progress) to stderr so that they don't interfere with the primary
> output. However, this idiomatic Unix practice is not necessarily
> universally understood and may be at odds with other schools of thought,
> such as the somewhat common one that only error messages should go to
> stderr, and all other messages to stdout. Let's help newcomers by
> documenting how stdout and stderr are used on this project.

I agree with everything you wrote here and below, which I think captures
what we want to communicate to folks adding new messages or commands.

I am not quite sure _everyone_ would agree with "this idiomatic Unix
practice" above. It does seem to be a matter of taste (it is just that
what you wrote very much agrees with my taste :) ). And "idiomatic Unix
practice" is probably not to be chatty at all, but I think that has been
changing over the years.

So I'm not sure if your commit message is being nicely assertive about
its taste, or is being uncharitable to people who may have different
tastes (but again, IMHO we should pick a direction and this seems like
the best one to me). :)

-Peff
