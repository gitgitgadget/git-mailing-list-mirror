Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A143C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 17:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjBPRZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 12:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBPRZA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 12:25:00 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD64D600
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 09:24:59 -0800 (PST)
Received: (qmail 30145 invoked by uid 109); 16 Feb 2023 17:24:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Feb 2023 17:24:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5370 invoked by uid 111); 16 Feb 2023 17:24:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Feb 2023 12:24:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Feb 2023 12:24:58 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] rev-list: clarify git-log default date format
Message-ID: <Y+5m6qIx1xsy2Scw@coredump.intra.peff.net>
References: <20230201155712.86577-1-rafael@dulfer.be>
 <xmqq5ycl1c6h.fsf@gitster.g>
 <230201.864js5q9sv.gmgdl@evledraar.gmail.com>
 <xmqqy1phxabi.fsf@gitster.g>
 <d9fc8688-bbf1-96c2-07bf-a12fe38625a9@dulfer.be>
 <xmqqfsbovy7u.fsf@gitster.g>
 <xmqqsffouhys.fsf@gitster.g>
 <xmqqcz6av3ta.fsf_-_@gitster.g>
 <xmqqzg9dshei.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg9dshei.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 08:29:25AM -0800, Junio C Hamano wrote:

>  * The same text as the previous one; only to correct the lack of
>    "--" at the end in v2 that broke the formatting toolchain.

Thanks. I looked at this version under doc-diff as well as the HTML
version and confirmed that it looks good (which I'm sure you also did at
this point ;) ).

-Peff
