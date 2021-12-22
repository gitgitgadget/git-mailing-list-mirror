Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00080C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 14:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbhLVO7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 09:59:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:56256 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241422AbhLVO7I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 09:59:08 -0500
Received: (qmail 17563 invoked by uid 109); 22 Dec 2021 14:59:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Dec 2021 14:59:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26849 invoked by uid 111); 22 Dec 2021 14:58:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Dec 2021 09:58:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Dec 2021 09:58:59 -0500
From:   Jeff King <peff@peff.net>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: Issues on git-scm.com
Message-ID: <YcM9M8JG6gFftBVi@coredump.intra.peff.net>
References: <011501d7f743$a8981e50$f9c85af0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <011501d7f743$a8981e50$f9c85af0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 09:53:13AM -0500, rsbecker@nexbridge.com wrote:

> The website appears to be having some issues:
> https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git

It's hosted on Heroku, which has been having an outage all morning:

  https://status.heroku.com/

Looks like things are coming back now-ish.

-Peff
