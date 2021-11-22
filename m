Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B9C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 07:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhKVHIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 02:08:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55257 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhKVHIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 02:08:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF3AF1042C7;
        Mon, 22 Nov 2021 02:05:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=LdPefTKuiOObRIwPfAlKvHhE8yE/Tde88cqWNEpg7GY=; b=LrKx
        DKK/MMK2/tCZJplHPJIBuU45LTFgj2r4mZW/ah3U2netD4ojCzD+JUbrofom2NId
        6tP4QYDgmK/EwacojnpAR7ePHOGVxcA4FW5oaDXPCwC68qerc9P/f2PqHqdlDv5u
        VS3WTIdK9I56wTAcuEY+WZPtXdnX7FDHcYUWw2k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A59891042C4;
        Mon, 22 Nov 2021 02:05:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 044831042C2;
        Mon, 22 Nov 2021 02:05:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "hakre via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        hakre <hanskrentel@yahoo.de>
Subject: Re: [PATCH] ci(check-whitespace): update stale file top comments
References: <pull.1143.git.git.1637347813367.gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 23:05:30 -0800
Message-ID: <xmqqilwkk6v9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95007AF4-4B62-11EC-8D9F-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"hakre via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: hakre <hanskrentel@yahoo.de>
>
> Earlier a066a90d (ci(check-whitespace): restrict to the intended
> commits, 2021-07-14) changed the check-whitespace task to stop using a
> shallow clone, and cc003621 (ci(check-whitespace): stop requiring a
> read/write token, 2021-07-14) changed the way how the errors the task
> discovered is signaled back to the user.
>
> They however forgot to update the comment that outlines what is done in
> the task. Correct them.
>
> Signed-off-by: Hans Krentel (hakre) <hanskrentel@yahoo.de>
> ---

I've manually corrected what is queued in my tree, but the name and
address recorded on the in-body From: line should match what is on
the signed-off-by line.  Please make sure I do not have to manually
fix your commits next time.

Thanks.

