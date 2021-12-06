Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A64C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 19:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348408AbhLFT2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:28:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65102 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244157AbhLFT2J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 14:28:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCFD315F978;
        Mon,  6 Dec 2021 14:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=046pIrB2C9g6umdtMg//Z5Pc35RiIC4JFgJnEM
        VIrB8=; b=cv/FeHUCy9Dow9dxcKcpBE1sJgS+BGP++RwwVOEBBh5dwhig92/G6+
        x65siU2kiQRST+JmutV6FtGyV1YXYQnNKtJxXp/s29/9jnSB6723z6h4MRQmOkjS
        jJTCif1hlaOA4LDYkO/wF4hnMLiO3i6C37Qhs9wRa0Pyx4IH3D5nU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C76CC15F977;
        Mon,  6 Dec 2021 14:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C0CE115F976;
        Mon,  6 Dec 2021 14:24:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Dec 2021, #01; Fri, 3)
References: <xmqqh7bpqhf0.fsf@gitster.g>
        <e1aadd47-533c-fd8b-4fae-f64a53c81ec9@gmail.com>
Date:   Mon, 06 Dec 2021 11:24:34 -0800
In-Reply-To: <e1aadd47-533c-fd8b-4fae-f64a53c81ec9@gmail.com> (Phillip Wood's
        message of "Mon, 6 Dec 2021 19:13:08 +0000")
Message-ID: <xmqqk0ghfsel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25BB0E98-56CA-11EC-8289-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> * pw/fix-some-issues-in-reset-head (2021-10-01) 12 commits
> I've got a re-roll which I think is almost ready but feel free to drop
> it in the meantime.

I'll mark it as expecting a reroll then.

>> * pw/diff-color-moved-fix (2021-10-27) 15 commits
>
> Dscho spotted a typo which I was going to correct with a re-roll but
> I've been holding off in case he has time to read the rest of the
> series.

Likewise.

Thanks for these updates, which are greatly appreciated.

