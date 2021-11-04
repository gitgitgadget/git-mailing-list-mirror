Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D653C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 05:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3558260E9B
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 05:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhKDGAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:00:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:52814 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhKDGAk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 02:00:40 -0400
Received: (qmail 7156 invoked by uid 109); 4 Nov 2021 05:58:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Nov 2021 05:58:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29027 invoked by uid 111); 4 Nov 2021 05:58:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Nov 2021 01:58:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Nov 2021 01:58:02 -0400
From:   Jeff King <peff@peff.net>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.email,
        eschwartz@archlinux.org, Carlo Arenas <carenas@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] async_die_is_recursing: work around GCC v11.x issue
 on Fedora
Message-ID: <YYN2ahdpbBEUfRNe@coredump.intra.peff.net>
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
 <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 04, 2021 at 04:01:03AM +0000, Victoria Dye via GitGitGadget wrote:

>     Changes since V1
>     ================
>     
>      * Change &ret to &async_die_counter ("dummy" argument to
>        pthread_setspecific) so that it's using a global (rather than local)
>        variable
>      * Fix typo in commit message (pthread_getspecific ->
>        pthread_setspecific)

Thanks, this version looks good to me!

-Peff
