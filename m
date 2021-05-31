Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEB1C4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF1360FE3
	for <git@archiver.kernel.org>; Mon, 31 May 2021 07:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhEaH4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 03:56:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59747 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhEaH4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 03:56:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FCA3D6326;
        Mon, 31 May 2021 03:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=230rI8mwwmTjAND5/DCgHB1xM0TIJOU/W2uK/C6KHmI=; b=g42F
        wpnJAqH71nDKZVjrmnOKIS/XrYsjlzsg8qEE4WM8UnbTJFPOD0tDNrg9CMWvrM2s
        Ppm0tKojc9PosUEdTcl+UaVbQ1FgsYeJJNoWtlLMT239fVQU8Yun4j9PGdILUD27
        6AKP2ljNDaYto5D6xoLtav7jTdf+0mAIyQHuKFI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07C67D6325;
        Mon, 31 May 2021 03:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83A70D6324;
        Mon, 31 May 2021 03:54:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 15/15] push: rename !triangular to same_remote
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
        <20210529074458.1916817-16-felipe.contreras@gmail.com>
Date:   Mon, 31 May 2021 16:54:51 +0900
Message-ID: <xmqqh7ijuylw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B52361C-C1E5-11EB-B828-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The typical case is what git was designed for: distributed remotes.
>
> It's only the atypical case--fetching and pushing to the same
> remote--that we need to keep an eye on.

Yup.  Avoiding the phrase "centralized" and using "same_remote"
makes quite a lot of sense, too.

Overall the end-result of the series is quite pleasant read, even
though some intermediate states in the middle risked readers to
worry about "are we going in the right direction?"

Well done.
