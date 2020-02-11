Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C4FC35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 20:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412E220659
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 20:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tfb6g19Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgBKUDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:03:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62128 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgBKUDY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 15:03:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 228214D177;
        Tue, 11 Feb 2020 15:03:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NbOyT9w+JeQ77cWxPw5iCoWlNLg=; b=tfb6g1
        9ZnsBHpwCkpbsECvjVeX5vPgKB7+DANi38uruUKL8wvpU98BFB02DeRdDEo7Fvbm
        HIRNTj3hHFVfePQUHnFXXNPyj0j5saR5dsGgbsjAPBkdemOisI7AKX+a/OdPd07P
        SdNxd3BK9u7D58rSVmWwZ1z//6BjalD/vwBBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q5dQjEUlnUcIUtvi70NJ0vIeUzl5yPzf
        uENUOth7wADX0nake747opb61hW2z/A4Rez6aybGsfz2Ic8w1M8kttfaidwZcmrY
        JlDTCvhnDqgXQoU9GRA88YY/huoAxBrRJ1iH/R72xepjrMSxEG9OcwuOX6VaUFvv
        kau83ofVdA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19CC84D176;
        Tue, 11 Feb 2020 15:03:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7770A4D174;
        Tue, 11 Feb 2020 15:03:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] convert: fix typo
References: <pull.551.git.1581447378188.gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 12:03:20 -0800
In-Reply-To: <pull.551.git.1581447378188.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 11 Feb 2020 18:56:18
        +0000")
Message-ID: <xmqq1rr0x56f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DAAD906-4D09-11EA-94B7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Fix typo "smuge"
>     
>     Just another typo I stumbled across.

Thanks.
