Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897C9C433EF
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 01:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiABBVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 20:21:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59570 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiABBVe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 20:21:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 130B311ADD8;
        Sat,  1 Jan 2022 20:21:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WdO2iuf+WFwvoEjLvmgwS5xlIojtURab03LbAZ
        4ymIo=; b=wz5YAAQLBgcup/oSN1DR/FbUO1YUXrfafj5Bn5jEjenDTfJDafVXtQ
        QWBZOiLzaVCm4alFNu3P1J0r+GSAw4i19MHJzBItu8iRvvFMBfv4wCgw8zxuSwEb
        dmYsu72DVnK5DRkqJ8zMD1rMpORTLYYYCuqWtMm6wL5DToE66Xbng=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0981011ADD7;
        Sat,  1 Jan 2022 20:21:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72E6B11ADD6;
        Sat,  1 Jan 2022 20:21:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t4126: this test does not pass SANITIZE_LEAK; quit
 claiming it does
References: <pull.1177.git.git.1640927702745.gitgitgadget@gmail.com>
Date:   Sat, 01 Jan 2022 17:21:31 -0800
In-Reply-To: <pull.1177.git.git.1640927702745.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Fri, 31 Dec 2021 05:15:02
        +0000")
Message-ID: <xmqqtuenkk4k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51CED29E-6B6A-11EC-9040-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     t4126: this test does not pass SANITIZE_LEAK; quit claiming it does

Is this continuation of [*1*]?

I think it will go away when dee839a2 (format-patch: mark
rev_info with UNLEAK, 2021-12-16) is merged.


[Reference]

*1* https://lore.kernel.org/git/xmqqee6dz5s9.fsf@gitster.g/
