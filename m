Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27105C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbiBDRJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 12:09:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54306 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiBDRJi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 12:09:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23D23118440;
        Fri,  4 Feb 2022 12:04:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7nZ+0uVpkeTmaYdbO7O+pceeOH5ztoN4kby43a
        HUD2s=; b=TKqSyWypwHj/o98ut72F4FiPyycyKA3SCS9XNF2KswTNiGZgrIFRCj
        Us3gf/tPD4j3ibTrx7kUbbBm0IZeLoRTuqoafXMlHDLvU99G2LYcstIehVi/evB4
        YPLJqwUYhAhCzWRY820NgGiDiRMxJCrvXLtTAYNm+WCCaQ/u/kcn0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19D6E11843F;
        Fri,  4 Feb 2022 12:04:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6DC9611843E;
        Fri,  4 Feb 2022 12:04:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v6 0/3] completion: sparse-checkout updates
References: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
        <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
        <CABPp-BGM0xu=Hgd_uKevAbpCtxR9ZY5NX=PWNn2Bqw8SaOJvLQ@mail.gmail.com>
Date:   Fri, 04 Feb 2022 09:04:29 -0800
In-Reply-To: <CABPp-BGM0xu=Hgd_uKevAbpCtxR9ZY5NX=PWNn2Bqw8SaOJvLQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 3 Feb 2022 22:05:36 -0800")
Message-ID: <xmqq1r0io95u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 848B73E0-85DC-11EC-B786-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Changes since V5
>> ================
>>
>>  * Fix incorrect conditional that was causing failure of non-cone mode test
>>    (and causing 'seen' CI to fail).
>>  * Remove __git_comp_directories indentation changes between the second and
>>    third commits.
>
> This round looks good to me:
>
> Reviewed-by: Elijah Newren <newren@gmail.com>
>
> Nice work!

Thanks, both.  Will queue.  Let's mark it to be merged down to
'next' soonish.
