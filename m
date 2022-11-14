Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD4C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiKNWdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbiKNWdb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:33:31 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018052642
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:33:27 -0800 (PST)
Received: (qmail 15532 invoked by uid 109); 14 Nov 2022 22:33:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Nov 2022 22:33:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14621 invoked by uid 111); 14 Nov 2022 22:33:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Nov 2022 17:33:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Nov 2022 17:33:26 -0500
From:   Jeff King <peff@peff.net>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <nasamuffin@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 0/2] http: redact curl h2h3 headers in info
Message-ID: <Y3LCNmsqfHDtG33u@coredump.intra.peff.net>
References: <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
 <pull.1377.v3.git.git.1668206106.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1377.v3.git.git.1668206106.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 10:35:04PM +0000, Glen Choo via GitGitGadget wrote:

> Big thanks to Peff for the feedback last round. I've incorporated all of the
> suggestions. I'm so glad that we finally have tests here :)
> 
> Changes in v3:
> 
>  * Add the HTTP2 test from [1] to the start of the series
>  * Drop struct strbuf inner in favor of doing work on the original strbuf

Thanks, both look good to me (unsurprisingly ;) ).

-Peff
