Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752EAC4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 15:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKQPDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 10:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbiKQPDs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 10:03:48 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2F24C265
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 07:03:48 -0800 (PST)
Received: (qmail 25361 invoked by uid 109); 17 Nov 2022 15:03:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Nov 2022 15:03:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12729 invoked by uid 111); 17 Nov 2022 15:03:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Nov 2022 10:03:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Nov 2022 10:03:46 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v6 0/7] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y3ZNUuyWF2gDk2mA@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668663795.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1668663795.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 06:46:35AM +0100, Patrick Steinhardt wrote:

> this is the sixth version of my patch series that tries to improve
> performance of the connectivity check by only considering preexisting
> refs as uninteresting that could actually have been advertised to the
> client.
> 
> There are only two changes in this version compared to v5:
> 
>     - A fix to the test setup in commit 5/7 so that tests pass when
>       GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main.
> 
>     - A typo fix in the commit message of patch 6/7.

Thanks. Looking at the range diff, this seems good to me!

-Peff
