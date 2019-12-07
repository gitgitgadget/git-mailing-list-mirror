Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FD7C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 19:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48566206DB
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 19:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfLGTr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:47:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:41182 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726489AbfLGTr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 14:47:58 -0500
Received: (qmail 5371 invoked by uid 109); 7 Dec 2019 19:47:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Dec 2019 19:47:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7435 invoked by uid 111); 7 Dec 2019 19:52:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Dec 2019 14:52:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Dec 2019 14:47:56 -0500
From:   Jeff King <peff@peff.net>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/15] git-p4.py: Cast byte strings to unicode strings
 in python3
Message-ID: <20191207194756.GA43949@coredump.intra.peff.net>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 07, 2019 at 05:47:28PM +0000, Ben Keene via GitGitGadget wrote:

> Ben Keene (13):
>   git-p4: select P4 binary by operating-system
>   git-p4: change the expansion test from basestring to list
>   git-p4: promote encodeWithUTF8() to a global function
>   git-p4: remove p4_write_pipe() and write_pipe() return values
>   git-p4: add new support function gitConfigSet()
>   git-p4: add casting helper functions for python 3 conversion
>   git-p4: python 3 syntax changes
>   git-p4: fix assumed path separators to be more Windows friendly
>   git-p4: add Py23File() - helper class for stream writing
>   git-p4: p4CmdList - support Unicode encoding
>   git-p4: support Python 3 for basic P4 clone, sync, and submit (t9800)
>   git-p4: added --encoding parameter to p4 clone
>   git-p4: Add depot manipulation functions
> 
> Jeff King (2):
>   t/gitweb-lib.sh: drop confusing quotes
>   t/gitweb-lib.sh: set $REQUEST_URI

Hmm, looks like rebasing leftovers. :) I think we can probably drop
these first two?

-Peff
