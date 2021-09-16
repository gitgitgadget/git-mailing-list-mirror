Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1127AC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18BE611CE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhIPFQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:16:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61922 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhIPFQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:16:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 967E1EA490;
        Thu, 16 Sep 2021 01:15:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ns1irRkN//atSwWRaSkbEAYIY7EoWoZIuvU4Pb
        Srp6Q=; b=tr+uGDIrnBW5aAps33RhJ3TEnYggHCO7tcAVwpt1kSmJirRG2WTTiq
        QEBY1uPtHTlvgF7/VL138uU2NOzAu2qGIhlKhCtDSQlCoHGROnSN3PNl7WZQdgQE
        aMCriQ5KfwmQFx3B3/zE8Rhe2gqe9XeZrppaazhyQ+jOD3ONiN3hQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E2CEEA48E;
        Thu, 16 Sep 2021 01:15:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1639BEA48D;
        Thu, 16 Sep 2021 01:15:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Kyle Zhao <keyu98@qq.com>, kylezhao <kylezhao@tencent.com>
Subject: Re: [PATCH v2] pack-revindex.h: correct the time complexity
 descriptions
References: <pull.1039.git.1631695337775.gitgitgadget@gmail.com>
        <pull.1039.v2.git.1631696964072.gitgitgadget@gmail.com>
        <YULRwFhL/T44ygpe@nand.local>
Date:   Wed, 15 Sep 2021 22:15:36 -0700
In-Reply-To: <YULRwFhL/T44ygpe@nand.local> (Taylor Blau's message of "Thu, 16
        Sep 2021 01:10:24 -0400")
Message-ID: <xmqqtuilummf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20710792-16AD-11EC-A535-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> But these two were swapped, and are now correct after your patch. Thanks
> again.
>
>     Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks,
> Taylor

Yup, both are from f894081d (pack-revindex: read multi-pack reverse
indexes, 2021-03-30) and a "reviewed-by:" from the person who wrote
it certainly is appreciated :-).

Thanks, both.

