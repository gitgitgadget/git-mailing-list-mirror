Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB21EC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 03:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBD3205ED
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 03:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgCXDkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 23:40:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:48940 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727060AbgCXDkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 23:40:16 -0400
Received: (qmail 14677 invoked by uid 109); 24 Mar 2020 03:40:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Mar 2020 03:40:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20133 invoked by uid 111); 24 Mar 2020 03:50:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2020 23:50:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Mar 2020 23:40:15 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] clone: document --filter options
Message-ID: <20200324034015.GA51305@coredump.intra.peff.net>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
 <pull.586.v2.git.1584906606469.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.586.v2.git.1584906606469.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 07:50:06PM +0000, Derrick Stolee via GitGitGadget wrote:

>     Slightly simplify partial clone user experience
>     
>     V2: Only update the documentation of --filter.

Thanks, this part is definitely an improvement (and I read over the
proposed text again, and it looks very good).

-Peff
