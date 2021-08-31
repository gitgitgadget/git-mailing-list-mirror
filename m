Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9B4C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91DB61074
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbhHaTQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:16:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50777 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbhHaTQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 15:16:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01E3CEE1C6;
        Tue, 31 Aug 2021 15:15:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JnvA8fpUKi8n84K3gt948niAq3ajyLdPy04CYh
        Iu1Vw=; b=jOycF5gx4SSKPkP5YehKjcglBdp4Vg3FX1FJBKg0YBMdkivI8wThtU
        hVuVpL634eCVyRrGI7q2f4+z4tZ80Jtgei3irYDqDntvLSE78YuY95DqA0UjjC/E
        xUv06ml/3TQeBmlNg1K5kIR2//hY4ky3P97v0USM7N4CHZoQtFdaE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED1A2EE1C5;
        Tue, 31 Aug 2021 15:15:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7213DEE1C4;
        Tue, 31 Aug 2021 15:15:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "USAMI Kenta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, USAMI Kenta <tadsan@zonu.me>
Subject: Re: [PATCH] userdiff: support enum keyword in PHP hunk header
References: <pull.1082.git.git.1630389685997.gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 12:15:32 -0700
In-Reply-To: <pull.1082.git.git.1630389685997.gitgitgadget@gmail.com> (USAMI
        Kenta via GitGitGadget's message of "Tue, 31 Aug 2021 06:01:25 +0000")
Message-ID: <xmqqh7f5toh7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D069E15C-0A8F-11EC-A31C-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"USAMI Kenta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: USAMI Kenta <tadsan@zonu.me>
>
> "enum" keyword will be introduced in PHP 8.1.
> https://wiki.php.net/rfc/enumerations
>
> Signed-off-by: USAMI Kenta <tadsan@zonu.me>
> ---
>     userdiff: support enum keyword in PHP hunk header
>     
>     "enum" keyword will be introduced in PHP 8.1.
>     https://wiki.php.net/rfc/enumerations

I no longer speak PHP, but this looks sensible to me.

Thanks, will queue.
