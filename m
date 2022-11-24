Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F27C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 01:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiKXBIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 20:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiKXBIg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 20:08:36 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC61C786D2
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 17:08:35 -0800 (PST)
Received: (qmail 24332 invoked by uid 109); 24 Nov 2022 01:08:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Nov 2022 01:08:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21483 invoked by uid 111); 24 Nov 2022 01:08:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Nov 2022 20:08:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Nov 2022 20:08:34 -0500
From:   Jeff King <peff@peff.net>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3] object-file: use real paths when adding alternates
Message-ID: <Y37EEiJembUN9PmL@coredump.intra.peff.net>
References: <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
 <pull.1382.v3.git.git.1669251331340.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1382.v3.git.git.1669251331340.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022 at 12:55:31AM +0000, Glen Choo via GitGitGadget wrote:

>     object-file: use real paths when adding alternates
>     
>     Thanks all for the feedback on v2. Once again, this version takes nearly
>     all of Ævar's fixup patches [1] :)

This looks fine to me. I'd probably have done the strbuf_realpath()
change I suggested, but I don't mind if you want to punt on it for now.

-Peff
