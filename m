Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83208C433E9
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F3C64FB1
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBDVKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:10:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:50914 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229983AbhBDVK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:10:29 -0500
Received: (qmail 7359 invoked by uid 109); 4 Feb 2021 21:09:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Feb 2021 21:09:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19548 invoked by uid 111); 4 Feb 2021 21:09:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Feb 2021 16:09:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Feb 2021 16:09:47 -0500
From:   Jeff King <peff@peff.net>
To:     "Bulgrien, Dennis" <Dennis.Bulgrien@astronics.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: howto-index not found
Message-ID: <YBxim/CGZAzttpoN@coredump.intra.peff.net>
References: <68e6a4e1991d4066a39b84ab5924202a@astronics.com>
 <CAPig+cT3qrYB09Z5J5afJUOUU6HvCm6jgjsMNQ_8nqHQUK70Og@mail.gmail.com>
 <YBxYowmCO50QmhVp@coredump.intra.peff.net>
 <bda4965e57c74f2a8f855ab7d92e71ca@astronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bda4965e57c74f2a8f855ab7d92e71ca@astronics.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 04, 2021 at 08:34:18PM +0000, Bulgrien, Dennis wrote:

> The github tracker redirects back to this group, saying "These pages
> are generated from git man pages, so we have no control over it. Have
> you reported it to the community at https://git-scm.com/community ?"
> 
> [1]: https://github.com/git/git-scm.com/issues/1521

Yeah, there are sort of two questions here:

  - should git-scm.com be generating the howto-index, api-index, etc;
    that's an issue that would be solved there (because it has custom
    code to import and format the documentation from git.git).

  - should Documentation/git.txt be more careful about referencing
    potentially-absent html files from the manpage builds. That's an
    issue that should be solved here on the mailing list.

-Peff
