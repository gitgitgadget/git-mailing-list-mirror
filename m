Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74588C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E1D61374
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhHXSxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 14:53:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63476 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhHXSxo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 14:53:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29A02D22BA;
        Tue, 24 Aug 2021 14:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zC8QA59SW8QcZ4iobIg8NqC/BrVXGLbgnAiJmr
        spSW8=; b=DsHnZuM8XtFs/nI9IbNTqc46HmplZCWxYo1ul/1UeoCL2ATkOCINUS
        mKdSRfW84UZWObxgc6+Ese56WaYFcGhGMpnWTJJWaIfhN2h1aEg7n0m6kDf4GPNN
        xD8v4r1gjeeFmIx4CR7nCc7bd6pOaADkAANisoAT3StcTHIAnM+0A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22319D22B9;
        Tue, 24 Aug 2021 14:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F5C4D22B8;
        Tue, 24 Aug 2021 14:52:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] whats-cooking: fix a couple of typos
References: <pull.1075.git.git.1629810383934.gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 11:52:53 -0700
In-Reply-To: <pull.1075.git.git.1629810383934.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 24 Aug 2021
        13:06:23 +0000")
Message-ID: <xmqqzgt6oet6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D9140CA-050C-11EC-9971-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     whats-cooking: fix a couple of typos
>     
>     I noticed a couple of typos while reading the most recent "What's
>     cooking" mail.

Thanks.  

https://trends.google.com/trends/explore?q=codepath,code%20path
makes it clear that "code path" is how the phrase is typically
written, but we have 233 instances of 'codepath' in our tree vs only
39 of 'code path', according to "git grep" X-<.

