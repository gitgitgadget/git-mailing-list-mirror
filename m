Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633CDC54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4142F2074D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgCYFe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:34:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:50284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725781AbgCYFe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:34:57 -0400
Received: (qmail 22938 invoked by uid 109); 25 Mar 2020 05:34:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 25 Mar 2020 05:34:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32323 invoked by uid 111); 25 Mar 2020 05:44:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Mar 2020 01:44:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Mar 2020 01:34:55 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Anton Mladenov <anton.g.mladenov@gmail.com>, git@vger.kernel.org
Subject: Re: Wrong Version On The Website ?
Message-ID: <20200325053455.GB651138@coredump.intra.peff.net>
References: <D6C222C5-3949-43F3-A63C-24D58EAB6675@gmail.com>
 <20200325001258.GJ6499@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200325001258.GJ6499@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 12:12:58AM +0000, brian m. carlson wrote:

> The Mac and Windows builds linked to from the website are provided by
> third parties.  The Git project itself only provides source releases.
> While the Windows builds are usually released around the same time as
> the main source releases, the Mac builds sometimes take longer, since
> they're done by a volunteer.
> 
> If you're interested in the latest release, I recommend trying Homebrew,
> as they tend to be a little more up to date.

I think the web page could do a much better job of making this clear:

 - mentioning homebrew and possibly other sources on the /download/mac
   page

 - make it clear that the binary builds are provided by a 3rd party;
   they may lag official releases (and are not themselves official; I've
   never heard any complaints about them differing in behavior from what
   Git devs would expect, but I don't think anybody from this list is
   really actively paying attention to them either).

Patches welcome (we take PRs at https://github.com/git/git-scm.com).

-Peff
