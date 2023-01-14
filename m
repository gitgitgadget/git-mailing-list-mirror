Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD43C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 12:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjANMsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 07:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjANMsS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 07:48:18 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7FB76B8
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 04:48:16 -0800 (PST)
Received: (qmail 29367 invoked by uid 109); 14 Jan 2023 12:48:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Jan 2023 12:48:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9331 invoked by uid 111); 14 Jan 2023 12:48:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Jan 2023 07:48:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 14 Jan 2023 07:48:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2023, #04; Sat, 14)
Message-ID: <Y8Kkjswoy3ELmAxR@coredump.intra.peff.net>
References: <xmqqilh9ms1p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqilh9ms1p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2023 at 12:36:18AM -0800, Junio C Hamano wrote:

> * ab/test-env-helper (2023-01-13) 1 commit
>  - env-helper: move this built-in to to "test-tool env-helper"
> 
>  Remove "git env--helper" and demote it to a test-tool subcommand.
> 
>  Will merge to 'next'.
>  source: <patch-1.1-e662c570f1d-20230112T155226Z-avarab@gmail.com>

There's a typo in the subject: s/to to/to/. Not a big deal, but since it
hasn't quite hit next yet, maybe worth fixing.

> * jk/interop-error (2023-01-13) 1 commit
>  - t/interop: report which vanilla git command failed
> 
>  Test helper improvement.
> 
>  Will merge to 'next'.
>  source: <Y8A3yGeJl0TCDNqe@coredump.intra.peff.net>

I was curious if you'd stick this one with Ævar's, since they're
somewhat related. But it's fine to queue them independently. Mine makes
finding the bug easier, and his fixes it. ;)

-Peff
