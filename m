Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE7EC2B9F7
	for <git@archiver.kernel.org>; Tue, 25 May 2021 02:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7069B61415
	for <git@archiver.kernel.org>; Tue, 25 May 2021 02:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhEYDBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 23:01:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50526 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhEYDBA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 23:01:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07B05BB4DA;
        Mon, 24 May 2021 22:59:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FZvq11lAVp2aH1hoYkHxOA6zsoPKmT32OFZvRK
        T1NXk=; b=T8ubZcYRhKo8DR2CFX3qqC3wY/tZ82EN7wEk9FAgikwhPQAPUxsu1C
        L4+nGLIJhE0uZU7fiKVkNf3nxTY2h/q88ENmg9fPhRGstJ4XiaUnnK/JnqAVwlZG
        x6HbW5pDpKYdsH38PRmZm+ZO7pvLQfMM39nr8VaNSve6m1L61KYdo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F33E0BB4D9;
        Mon, 24 May 2021 22:59:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76796BB4D8;
        Mon, 24 May 2021 22:59:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 3/5] doc: remove unnecessary rm instances
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
        <20210521222941.525901-4-felipe.contreras@gmail.com>
        <xmqqcztgj9za.fsf@gitster.g> <60abf32038579_1b209208d2@natae.notmuch>
Date:   Tue, 25 May 2021 11:59:29 +0900
In-Reply-To: <60abf32038579_1b209208d2@natae.notmuch> (Felipe Contreras's
        message of "Mon, 24 May 2021 13:40:32 -0500")
Message-ID: <xmqqwnrnh626.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39AD305C-BD05-11EB-9EAF-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I happen to have at hand a script that ranks the most common trailer
> lines:
>
>  * acked-by: 25% (1945)
>
> Doesn't apply.
>
>  * reviewed-by: 22% (1729)
>
> This does apply, but I'm not confident Jeff would like me to add that.
>
>  * helped-by: 17% (1336)

I actually think people use this one to say "person X gave a
valuable input in the review discussion", which is exactly the case
here, and that was why I wondered you needed to invent a completely
new one.

