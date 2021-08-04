Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6CAC4320A
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798B16103C
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhHDAOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 20:14:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52171 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhHDAOd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 20:14:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D7D3129843;
        Tue,  3 Aug 2021 20:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZcADGFgdE00a/d/hKxF/j/q2cSFJFDZH7rTBgz
        Acmq0=; b=VIGu5LND+PrF1MFTNOYbLw1Cb4SNhnJqqZbhw0hxZr0pSxfeoTm6I8
        tFr2TQgYYucjDvoCmRLPVWIi6CcpkdIs/k4RURX/vyCIyjFwOPRoOw1yChdKetZA
        281wS7JA2VHCOKfIdHObOuW//k/EpnjlcY6ex/L0pogqj+yemaBRE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70F38129842;
        Tue,  3 Aug 2021 20:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 701EC129841;
        Tue,  3 Aug 2021 20:14:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 03/10] Documentation: edit awkward references to `git
 merge-recursive`
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <c1d056f0794ddcb0400901228b370b3bb5dfc0da.1628004920.git.gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 17:14:15 -0700
In-Reply-To: <c1d056f0794ddcb0400901228b370b3bb5dfc0da.1628004920.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 03 Aug 2021
        15:35:13 +0000")
Message-ID: <xmqqr1farrqg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8608ABE-F4B8-11EB-9076-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -355,8 +355,8 @@ See also INCOMPATIBLE OPTIONS below.
>  -s <strategy>::
>  --strategy=<strategy>::
>  	Use the given merge strategy.
> -	If there is no `-s` option 'git merge-recursive' is used
> -	instead.  This implies --merge.
> +	If there is no `-s` option the `recursive` strategy is the
> +	default. This implies --merge.

We can depart from the original even more to make it shorter and
more readable, I think.

    Use the given merge strategy, instead of the default
    `recursive`.  This implies `--merge`.

But the above is readable enough already, so I'll queue it as-is.

