Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24BFC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 09:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJCJC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJCJCa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 05:02:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B240561
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 01:52:26 -0700 (PDT)
Received: (qmail 30921 invoked by uid 109); 3 Oct 2022 08:52:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Oct 2022 08:52:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22931 invoked by uid 111); 3 Oct 2022 08:52:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Oct 2022 04:52:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Oct 2022 04:52:23 -0400
From:   Jeff King <peff@peff.net>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4] tmp-objdir: skip clean up when handling a signal
Message-ID: <Yzqix7sKRhpTAMKV@coredump.intra.peff.net>
References: <pull.1348.v3.git.git.1664376956780.gitgitgadget@gmail.com>
 <pull.1348.v4.git.git.1664570831583.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1348.v4.git.git.1664570831583.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2022 at 08:47:11PM +0000, John Cai via GitGitGadget wrote:

>     Changes since v3:
>     
>      * Updated commit message to clarify that we still clean up the tmp dir
>        on atexit

Thanks, this version looks great to me!

-Peff
