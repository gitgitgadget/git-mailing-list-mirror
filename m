Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33C9C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 04:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbjELEHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 00:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjELEHh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 00:07:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C90E55
        for <git@vger.kernel.org>; Thu, 11 May 2023 21:07:35 -0700 (PDT)
Received: (qmail 2782 invoked by uid 109); 12 May 2023 04:07:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 May 2023 04:07:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18027 invoked by uid 111); 12 May 2023 04:07:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 May 2023 00:07:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 12 May 2023 00:07:33 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 23/24] hash-ll, hashmap: move oidhash() to hash-ll
Message-ID: <20230512040733.GA1999607@coredump.intra.peff.net>
References: <44a4027b240289605f4c40b9121ee6615e9759f7.1683431153.git.gitgitgadget@gmail.com>
 <20230511172401.934633-1-calvinwan@google.com>
 <20230511183143.GA1978320@coredump.intra.peff.net>
 <CABPp-BEVWS2atggSNC16bQ3FxvNxU-76+o3B5QF+2opiwOLfgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEVWS2atggSNC16bQ3FxvNxU-76+o3B5QF+2opiwOLfgQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 07:08:00PM -0700, Elijah Newren wrote:

> Oh, wow, I was about to type up an explanation to Calvin, but you did
> so in even greater detail.  Sweet.
> 
> And sure, I'd be happy to split this out into a separate patch and
> steal the commit message.  I think you deserve Co-author, though,
> given it's only a 1-line code change versus the 20 line commit message
> you wrote...

Great. I'm happy with any form of credit (or none). And the commit
message is is S-o-b: me in case that matters. :)

-Peff
