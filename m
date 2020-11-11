Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66279C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046FA208B3
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgKKUHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:07:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:55228 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKKUHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:07:02 -0500
Received: (qmail 14432 invoked by uid 109); 11 Nov 2020 20:07:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Nov 2020 20:07:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20846 invoked by uid 111); 11 Nov 2020 20:07:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Nov 2020 15:07:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Nov 2020 15:07:01 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 00/15] Add struct strmap and associated utility
 functions
Message-ID: <20201111200701.GB39046@coredump.intra.peff.net>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
 <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 08:02:06PM +0000, Elijah Newren via GitGitGadget wrote:

> Here I introduce new strmap, strintmap, and strset types.
> 
> Changes since v5:
> 
>  * Fixed a typo in forward declaration of struct mem_pool, spotted by
>    Phillip. (Usage via pointers meant gcc & clang wouldn't complain.)

Yep, this version looks good to me. I think this is probably ready for
'next'.

-Peff
