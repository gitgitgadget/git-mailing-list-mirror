Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FCBC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 06:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDYGws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 02:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjDYGwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 02:52:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DE949EA
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 23:52:43 -0700 (PDT)
Received: (qmail 22491 invoked by uid 109); 25 Apr 2023 06:52:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 06:52:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1928 invoked by uid 111); 25 Apr 2023 06:52:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 02:52:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 02:52:42 -0400
From:   Jeff King <peff@peff.net>
To:     Blyxyas <blyxyas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Inconsistent names in `git shortlog`
Message-ID: <20230425065242.GE4061254@coredump.intra.peff.net>
References: <CAGeanHfxL9e_OHPFzBjLjgVU=QLvwYS9QVCGHC1JHSkApRAwgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGeanHfxL9e_OHPFzBjLjgVU=QLvwYS9QVCGHC1JHSkApRAwgQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 02:00:27AM +0200, Blyxyas wrote:

> This isn't a big deal on its own, but there are some external tools
> (like thanks.rust-lang.org) that use the output of `git shortlog` to
> thank contributors, and it has some cases of people going just by
> their first name (no surnames), or people appearing multiple times,
> once with their username and one with their real name.

I agree with everything brian said elsewhere, but I wanted to add one
thing: for this "multiple times" problem, it can be solved with a
mailmap file, which associates names such that ones you don't like can
be rewritten to ones that you do. See "git help mailmap" for details and
examples.

-Peff
