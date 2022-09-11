Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B02BC54EE9
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 05:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiIKFJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 01:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIKFJw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 01:09:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA49B15FD7
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 22:09:49 -0700 (PDT)
Received: (qmail 18296 invoked by uid 109); 11 Sep 2022 05:09:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 11 Sep 2022 05:09:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31631 invoked by uid 111); 11 Sep 2022 05:09:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 01:09:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 01:09:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2022, #02; Fri, 9)
Message-ID: <Yx1tnBRXJdkFQYEX@coredump.intra.peff.net>
References: <xmqq5yhwi1vw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yhwi1vw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2022 at 04:06:27PM -0700, Junio C Hamano wrote:

> [Cooking]
> 
> * ab/unused-annotation (2022-09-01) 2 commits
>   (merged to 'next' on 2022-09-08 at dfc6123c6b)
>  + git-compat-util.h: use "deprecated" for UNUSED variables
>  + git-compat-util.h: use "UNUSED", not "UNUSED(var)"
>  (this branch uses jk/unused-annotation.)
> 
>  Undoes 'jk/unused-annotation' topic and redoes it to work around
>  Coccinelle rules misfiring false positives in unrelated codepaths.
> 
>  Will merge to 'master'.
>  source: <cover-0.2-00000000000-20220825T170709Z-avarab@gmail.com>

I just want to double-check that the plan is to merge this to master as
noted above. I had thought you would revert jk/unused-annotation and
that I'd just re-roll it. I'm perfectly happy with either, but just
didn't want to add more confusion by posting that re-roll. ;)

-Peff
