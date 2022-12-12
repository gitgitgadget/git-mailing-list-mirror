Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029E4C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiLLVCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiLLVB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:01:27 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A8193C7
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:00:35 -0800 (PST)
Received: (qmail 6530 invoked by uid 109); 12 Dec 2022 21:00:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Dec 2022 21:00:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29631 invoked by uid 111); 12 Dec 2022 20:59:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Dec 2022 15:59:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Dec 2022 15:59:19 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] Bundle URIs 4.5: fixups from part IV
Message-ID: <Y5eWJ03XQTqkJHjK@coredump.intra.peff.net>
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 05:33:23PM +0000, Derrick Stolee via GitGitGadget wrote:

> These patches represent small fixups that came in review from the last
> version of 'ds/bundle-uri-4'. Since it was merged to 'next', these patches
> are forward-fixes on that branch.
> 
> Note: I did not include any changes that could be solved by adding an UNUSED
> macro, saving that for Peff and his already-prepared patches in that area.

Thanks, that sounds good on my part. The first two look obviously
correct to me. The third looks sensible, too, but isn't an area I'd
looked at before.

-Peff
