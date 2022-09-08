Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52D9C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 01:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiIHBe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 21:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHBe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 21:34:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7DB10BF
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 18:34:23 -0700 (PDT)
Received: (qmail 24207 invoked by uid 109); 8 Sep 2022 01:34:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 01:34:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16597 invoked by uid 111); 8 Sep 2022 01:34:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Sep 2022 21:34:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Sep 2022 21:34:22 -0400
From:   Jeff King <peff@peff.net>
To:     Caglar Akyuz <caglar.akyuz@sparsetechnology.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Ambiguous 'HEAD' issue.
Message-ID: <YxlGnkPBmczarL62@coredump.intra.peff.net>
References: <AM0PR08MB4323160241D4341FB1B99CC2FD749@AM0PR08MB4323.eurprd08.prod.outlook.com>
 <xmqqsflfr1y0.fsf@gitster.g>
 <AM0PR08MB432341F2A27E1133C7A31DEBFD769@AM0PR08MB4323.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM0PR08MB432341F2A27E1133C7A31DEBFD769@AM0PR08MB4323.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2022 at 06:57:00AM +0000, Caglar Akyuz wrote:

> Both 'grep HEAD .git/packed-refs' and 'git for-each-ref | grep HEAD'
> commands return nothing and still 'git status' is complaining about
> ambiguous HEAD.

Is it possible for you to tar up your .git directory and share it
(either publicly, or privately to individual developers)?

-Peff
