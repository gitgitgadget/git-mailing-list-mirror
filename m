Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFBAC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 19:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbhLVT7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 14:59:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60242 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345346AbhLVT73 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 14:59:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FE5F10DAC5;
        Wed, 22 Dec 2021 14:59:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cq/SzIcEi75qwocSXF/iLvaQ/AVP8bKC5eibO0
        3sec8=; b=go5Q7Hew3pQUMKZGCuteEWp2a4E5TJHgdm8X7t7oj14aA2Ebq1biwR
        oHOg5LHs8Z2I9nNyEF84uMoTvYQqKAomwwIfnreB8TRQD0kTiPMdnVqJ9B1eQ0mS
        sRhUK3baysDtChsouly78x7YVCjzC2v0n27tuNOvWWyyxhaAwq3DQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 160BB10DAC2;
        Wed, 22 Dec 2021 14:59:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 621C810DAC1;
        Wed, 22 Dec 2021 14:59:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, peff@peff.net,
        me@ttaylorr.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 0/6] usage API: Add and use die_message()
References: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
        <20211222185715.1090524-1-jonathantanmy@google.com>
Date:   Wed, 22 Dec 2021 11:59:27 -0800
In-Reply-To: <20211222185715.1090524-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 22 Dec 2021 10:57:14 -0800")
Message-ID: <xmqq4k70jtr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABA350F8-6361-11EC-BA31-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> A small set of fixes to usage.[ch]'s API use that will go towards
>> enabling nicer things down the road. See [1] for the v1 summary
>> 
>> I believe this should address all the feedback Junio had on the
>> v1.
>> 
>> Aside from the substantially rewritten 6/6 and much simplified 4/6 the
>> end-state is almost the same, but things are better split up,
>> explained etc. now.
>> 
>> 1. https://lore.kernel.org/git/cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com/
>
> I haven't looked at this round of patches yet, but for the convenience
> of reviewers, it would have been great if you linked to a prior
> discussion [1], including an email from me with comments that (as far as
> I know) haven't been addressed [2].
>
> [1] https://lore.kernel.org/git/patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com/
> [2] https://lore.kernel.org/git/20211027215053.2257548-1-jonathantanmy@google.com/

Hear, hear, and thanks.
