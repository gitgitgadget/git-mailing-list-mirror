Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D5CC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 21:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhLGVVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:21:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51002 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhLGVVk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:21:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACBB1E243B;
        Tue,  7 Dec 2021 16:18:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3n86iyvNmhJr5nDAle6RZUIr62g7tQrZzeBPcv
        LjtBE=; b=gRMn16ougI8aPmPbm4PBtD6/0vWqEhuDkNvhj0aC/wMwqkIHRYr/LD
        i2GDBpCg+TWF+brfglrnBYA2MgClWezz5m6fYZUgQ/UCBFsph2qvjHrfu8xy2eLT
        Pam4gvXg/YIERp/AzulNMeKhJS181FsK4NkFkOadfkMKaXwTgVYGo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C14FE243A;
        Tue,  7 Dec 2021 16:18:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0299E2438;
        Tue,  7 Dec 2021 16:18:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v4 0/8] Allow writing invalid OIDs into refs for testing
 purposes
References: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
        <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 13:18:06 -0800
In-Reply-To: <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Tue, 07 Dec 2021 13:38:12
        +0000")
Message-ID: <xmqqtufk5d2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D0CC108-57A3-11EC-9B40-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> this covers a few cases of direct filesystem access to the ref database in
> tests.
>
> v4:
>
>  * fix stack OOB read due to missing array terminator.

Looks good to me.  I'll tentatively mark it for 'next' and will
merge it by the end of this week unless problems are found in the
series.

Thanks for a pleasant read.
