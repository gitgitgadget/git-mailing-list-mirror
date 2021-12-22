Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F5BC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 22:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbhLVWvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:51:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53620 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbhLVWvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 17:51:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D454151E85;
        Wed, 22 Dec 2021 17:51:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=TM8GICn4R843wblnSyb+jT4mRx2tSeIanoAuUxWwyhw=; b=XGmv
        VOmntwtE+wJhnzgqKxyGJIBM+jFmT4kD9wG0FRymgekAqpokJJLe9KvO1SoRyyQq
        phDf7CMbc2AnDhDXUvanWZ5oD/Snu7lG7vXFhptRUhKb8Xz9syovNsEE0ovwr83D
        XzBUffRwinXaCp83rGDVH9NZedNcRi399ys40ug=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35E5C151E84;
        Wed, 22 Dec 2021 17:51:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 963D7151E81;
        Wed, 22 Dec 2021 17:51:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 13/16] reftable: remove outdated file reftable.c
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <4175089ec432da921d158fec9ccb1902be710af6.1640199396.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:51:12 -0800
Message-ID: <xmqqmtksfe3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA04DCAE-6379-11EC-BB21-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This was renamed to generic.c, but the origin was never removed
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/reftable.c | 115 --------------------------------------------
>  1 file changed, 115 deletions(-)
>  delete mode 100644 reftable/reftable.c

That's embarrassing for all reviewers of past reftable patches.
