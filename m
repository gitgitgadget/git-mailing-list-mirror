Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02FCEB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 22:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbjFNWv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 18:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjFNWv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 18:51:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3BD1FFA
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 15:51:56 -0700 (PDT)
Received: (qmail 18738 invoked by uid 109); 14 Jun 2023 22:51:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jun 2023 22:51:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16873 invoked by uid 111); 14 Jun 2023 22:51:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jun 2023 18:51:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jun 2023 18:51:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2 0/2] credential: improvements to erase in helpers
Message-ID: <20230614225154.GC1441072@coredump.intra.peff.net>
References: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
 <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
 <xmqqjzw5wvwk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzw5wvwk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2023 at 02:56:11PM -0700, Junio C Hamano wrote:

> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > M Hickford (2):
> >   credential: avoid erasing distinct password
> >   credential: erase all matching credentials
> 
> Will queue.  Comments by folks with more experience (than me) who
> have worked on the credential subsystem are very much welcomed.

I think the direction is good, but there are a few small bits in each
patch to tweak, and we'll want a v3.

-Peff
