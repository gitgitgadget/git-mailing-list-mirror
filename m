Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AE2C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 21:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbhLVVye (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 16:54:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55671 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbhLVVyd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 16:54:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6D5110E5BC;
        Wed, 22 Dec 2021 16:54:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+VEqt7xmhnXc6yUHh4ge8ikNUnG8CcfoIGXq7Z
        Hpx+U=; b=kWdnFgswD/CMKUufeBU8RrkOSqIyijFf/3PadWuIvhuTa0lyD7k/8L
        huDv0UjWjI2tccYUBCSXvOIt7eb03okMlj1oWjkI2SVebELt4mz1VaIidV4QHZal
        vA7ITQr4Y1utEVmpguQhY8A2CbXDXVLO+hJoMmEn88NH/rwnLHof8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCB8210E5BB;
        Wed, 22 Dec 2021 16:54:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4347E10E5BA;
        Wed, 22 Dec 2021 16:54:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 0/3] tweaks to refs/debug.c
References: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
        <pull.1163.v2.git.git.1640196714.gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 13:54:31 -0800
In-Reply-To: <pull.1163.v2.git.git.1640196714.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Wed, 22 Dec 2021 18:11:51
        +0000")
Message-ID: <xmqq5yrgi9uw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEAA29A0-6371-11EC-9662-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> these are two small commits that helped me while debugging reftable support
> for git.
>
> Han-Wen Nienhuys (3):
>   refs: pass gitdir to packed_ref_store_create
>   refs: print error message in debug output
>   refs: centralize initialization of the base ref_store.

Welcome to our "we cannot count to three" club ;-)

All three patches make sense to me.  Especially the [3/3] has become
much easier to understand.

Thanks, will queue.
