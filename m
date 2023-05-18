Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0FDC77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 18:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjERS2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 14:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERS2k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 14:28:40 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076041B5
        for <git@vger.kernel.org>; Thu, 18 May 2023 11:28:39 -0700 (PDT)
Received: (qmail 1210 invoked by uid 109); 18 May 2023 18:28:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 May 2023 18:28:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23381 invoked by uid 111); 18 May 2023 18:28:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 14:28:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 14:28:38 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH v3 0/1] Fix empty SHA-256 clones with v0 and v1
Message-ID: <20230518182838.GB557383@coredump.intra.peff.net>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230517192443.1149190-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517192443.1149190-1-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 07:24:42PM +0000, brian m. carlson wrote:

> Changes since v2:
> * Move advertisement of fake capabilities ref to a separate function to
>   avoid an extra strcmp.

Thanks, the code change looks good to me.

I'm still a little puzzled why we need http tests both in t5551 and
t5700. Not too big a deal to have redundant tests, obviously, but I
wonder if I am missing something.

-Peff
