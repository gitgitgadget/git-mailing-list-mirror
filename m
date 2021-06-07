Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6CBC4743E
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 01:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C810613C8
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 01:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhFGBKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 21:10:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51826 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhFGBKX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 21:10:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65319CBAEA;
        Sun,  6 Jun 2021 21:08:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZfKvElLM5loDCgBHkF6OGZr03q6WbHYakgjwos
        V4i74=; b=j53Uv7yJrIs1zBx4nUu/aP03NWdhYSA6+p3SnkSnkjwGUjHBlCwq0S
        0OQg+GtdYDyhWMT29YhwNMQYnBh8qms3oyvqbKgLSnDwFdYk+hvZwrCXAjYd+4Nr
        szWCvUk3BX6jA8J4DKR4BUFt9BqyWrA+fIM9xjQG8nWx4rC/IluaM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C6CCCBAE9;
        Sun,  6 Jun 2021 21:08:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF31FCBAE8;
        Sun,  6 Jun 2021 21:08:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 try2 0/4] completion: bash: a bunch of fixes
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
        <CAJDDKr4Wm2FQ-kq8k8EU6wE20V6ghuKDrzC5PcsZ6We0bMz3uQ@mail.gmail.com>
Date:   Mon, 07 Jun 2021 10:08:32 +0900
In-Reply-To: <CAJDDKr4Wm2FQ-kq8k8EU6wE20V6ghuKDrzC5PcsZ6We0bMz3uQ@mail.gmail.com>
        (David Aguilar's message of "Sun, 6 Jun 2021 17:46:06 -0700")
Message-ID: <xmqqfsxuwkfj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0D2AF0C-C72C-11EB-A274-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> On Sun, Jun 6, 2021 at 11:51 AM Felipe Contreras
> ...
> I tested this series on:
> - GNU bash, version 4.2.46(2)-release (x86_64-redhat-linux-gnu)
> - GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin19)
> - zsh 5.0.2 (x86_64-redhat-linux-gnu)
> - zsh 5.7.1 (x86_64-apple-darwin19.0)
> and can confirm that it is an improvement.
>
> FWIW,
> Tested-by: David Aguilar <davvid@gmail.com>

Thanks, will queue (I haven't checked if there is any overlap with
what is cooking above 'master', so it may not happen very soon,
though).
