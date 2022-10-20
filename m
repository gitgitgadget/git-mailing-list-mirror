Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D0C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 06:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJTGSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 02:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiJTGSK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 02:18:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99018C42B
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 23:18:07 -0700 (PDT)
Received: (qmail 5012 invoked by uid 109); 20 Oct 2022 06:18:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Oct 2022 06:18:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15386 invoked by uid 111); 20 Oct 2022 06:18:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Oct 2022 02:18:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Oct 2022 02:18:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #06; Wed, 19)
Message-ID: <Y1DoHb1vRYpIyPzK@coredump.intra.peff.net>
References: <xmqqa65rnuvv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa65rnuvv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2022 at 06:31:16PM -0700, Junio C Hamano wrote:

> * jk/use-o0-in-leak-sanitizer (2022-10-19) 1 commit
>   (merged to 'next' on 2022-10-19 at 27c2546b98)
>  + Makefile: force -O0 when compiling with SANITIZE=leak
> 
>  Avoid false-positive from LSan whose assumption may be broken with
>  higher optimization levels.
> 
>  Will merge to 'master'.
>  source: <Y08JZVDgJpJvrBiz@coredump.intra.peff.net>

BTW, you should be able to see that "next" now passes the leaks CI job
(because of this patch), but master doesn't yet.

-Peff
