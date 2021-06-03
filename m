Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C2EC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700AC613E4
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFCTbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:31:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:45352 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhFCTbX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 15:31:23 -0400
Received: (qmail 6370 invoked by uid 109); 3 Jun 2021 19:29:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Jun 2021 19:29:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28489 invoked by uid 111); 3 Jun 2021 19:29:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jun 2021 15:29:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Jun 2021 15:29:37 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 0/2] [GSOC] cat-file: fix --batch report changed-type
 bug
Message-ID: <YLktoTqu/YZgOe4k@coredump.intra.peff.net>
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
 <pull.967.v2.git.1622737766.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.967.v2.git.1622737766.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 03, 2021 at 04:29:24PM +0000, ZheNing Hu via GitGitGadget wrote:

> Change from last version:
> 
>  1. Modified the test structure under the recommendation of Peff.
>  2. Use clearer and more concise commit message help by Peff.

Thanks, this version looks good to me.

-Peff
