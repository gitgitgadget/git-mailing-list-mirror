Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE55FC4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0BA20793
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgLCPmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 10:42:42 -0500
Received: from mail.javad.com ([54.86.164.124]:45674 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgLCPmm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 10:42:42 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 053CC3E8C8;
        Thu,  3 Dec 2020 15:42:01 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1kkqk3-0003wQ-Ih; Thu, 03 Dec 2020 18:41:59 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 09/27] diff-merges: re-arrange functions to match the
 order they are called in
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-10-sorganov@gmail.com>
        <CABPp-BESWpqska++EsfxfbncyV0kNo1RGLjF+1BiV=D6zLx2LQ@mail.gmail.com>
Date:   Thu, 03 Dec 2020 18:41:59 +0300
In-Reply-To: <CABPp-BESWpqska++EsfxfbncyV0kNo1RGLjF+1BiV=D6zLx2LQ@mail.gmail.com>
        (Elijah Newren's message of "Wed, 2 Dec 2020 21:52:02 -0800")
Message-ID: <87wnxyhp6g.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sun, Nov 8, 2020 at 1:43 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> For clarity, define public functions in the order they are called, to
>> make logic inter-dependencies easier to grok.
>
> You added diff-merges.[ch] earlier in this series.  Why not just add
> them in the correct order initially instead of adding another patch
> later in the series?

Well, I did consider it, but there are 2 issues that stopped me.

First, I didn't want to rearrange functions as I move them from
revision.c, to avoid mixed commit to simplify review, and second, I
didn't want to rearrange them in the original to perform as little
changes to the codebase as possible before isolating my work
into diff-merges.[ch].

Hope it makes sense.

Thanks,
-- Sergey Organov
