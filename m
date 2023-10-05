Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AE6E92719
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjJERRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjJERQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:16:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6364496
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:09:01 -0700 (PDT)
Received: (qmail 23782 invoked by uid 109); 5 Oct 2023 17:09:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Oct 2023 17:09:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25566 invoked by uid 111); 5 Oct 2023 17:09:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Oct 2023 13:09:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Oct 2023 13:08:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: js/ci-coverity, was Re: What's cooking in git.git (Oct 2023, #02;
 Wed, 4)
Message-ID: <20231005170859.GB975921@coredump.intra.peff.net>
References: <xmqqpm1ulzoh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm1ulzoh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2023 at 04:45:34PM -0700, Junio C Hamano wrote:

> * js/ci-coverity (2023-09-25) 7 commits
>  - SQUASH???
>  - coverity: detect and report when the token or project is incorrect
>  - coverity: allow running on macOS
>  - coverity: support building on Windows
>  - coverity: allow overriding the Coverity project
>  - coverity: cache the Coverity Build Tool
>  - ci: add a GitHub workflow to submit Coverity scans
> 
>  GitHub CI workflow has learned to trigger Coverity check.
> 
>  Looking good.
>  source: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>

I think that has been sitting at "Looking good" for a few iterations.
IMHO it is ready to progress, with the SQUASH applied on the final
patch.

-Peff
