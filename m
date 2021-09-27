Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B54C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4286101A
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbhI0UNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:13:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62651 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbhI0UNu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:13:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A432F7BFD;
        Mon, 27 Sep 2021 16:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=obRhRLIhpi1SLE+a3b1uOYTx1+CLs6cuvZLquW
        Ow2tM=; b=P4q4tImN+4Zah4XSho11tcg9dqQ8599c5p6TFiyh6OXDrXAe1v9LYY
        z/mvrR7ZTOiy78vYqYTChcOLHRIWTdBtevHCvu9HrTcPeUx9BTfRcrGSrmQiaKjx
        FpzN0s3GDDcGX3oWl/PsBctxFsJfghuIhpi45IreipMaCVIGeJG6g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 429EEF7BFC;
        Mon, 27 Sep 2021 16:12:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B05FAF7BFB;
        Mon, 27 Sep 2021 16:12:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] doc: fix capitalization in porcelain v2 section
References: <pull.1095.git.git.1632628082841.gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 13:12:10 -0700
In-Reply-To: <pull.1095.git.git.1632628082841.gitgitgadget@gmail.com> (Orgad
        Shaneh via GitGitGadget's message of "Sun, 26 Sep 2021 03:48:02
        +0000")
Message-ID: <xmqqsfxppylh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33158C08-1FCF-11EC-9587-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH] doc: fix capitalization in porcelain v2 section
> From: Orgad Shaneh <orgads@gmail.com>

Between "doc" and "porcelain v2 section", there is this level called
"page" ;-) When this commit is mixed together with other commits in
"git shortlog" output, it will be hard to tell that this is about
fixing documentation for which command, so you must give it to your
readers.

    Subject: doc: match XY placeholder in status --porcelain-v2 output

or something like that, perhaps?

Thanks.

>
> The summary line had xy, while the description (and other sub-sections)
> has XY.
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>     doc: fix capitalization in porcelain v2 section
>     
>     The summary line had xy, while the description (and other sub-sections)
>     has XY.
>     
>     Signed-off-by: Orgad Shaneh orgads@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1095%2Forgads%2Fstatus-doc-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1095/orgads/status-doc-v1
> Pull-Request: https://github.com/git/git/pull/1095
>
>  Documentation/git-status.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 83f38e31981..c33a3d8d532 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -363,7 +363,7 @@ Field       Meaning
>  Unmerged entries have the following format; the first character is
>  a "u" to distinguish from ordinary changed entries.
>  
> -    u <xy> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
> +    u <XY> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
>  
>  ....
>  Field       Meaning
>
> base-commit: ddb1055343948e0d0bc81f8d20245f1ada6430a0
