Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFBFC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 20:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiFVUOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 16:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377275AbiFVUOK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 16:14:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7BB13E9A
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 13:14:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA42B1A6FE9;
        Wed, 22 Jun 2022 16:14:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pA9NRJx1ujDp0812eyXFykbKyiXf86Uh9qzuOv
        5ytkc=; b=jmDy78uJ9LG3VbqRQa/I6W5szPMGY15/A8zEOqN52qa5HHhLHpcNHa
        tMUJFPkIZIYNA7diHtPkCrr4h5l/y7yVREE5exZIkHI71DZXhs79W+1DSv/z52UR
        4EDaYyvsjWE9O7ES/4lgbTKgbCRk4Hcp2EZikTmAAj2JYgPI7ZJ5k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E249E1A6FE8;
        Wed, 22 Jun 2022 16:14:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 856171A6FE6;
        Wed, 22 Jun 2022 16:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Arthur Milchior via GitGitGadget" <gitgitgadget@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Cc:     git@vger.kernel.org, Arthur Milchior <arthur@milchior.fr>
Subject: Re: [PATCH] po typo: l10
References: <pull.1280.git.git.1655927444821.gitgitgadget@gmail.com>
Date:   Wed, 22 Jun 2022 13:14:04 -0700
In-Reply-To: <pull.1280.git.git.1655927444821.gitgitgadget@gmail.com> (Arthur
        Milchior via GitGitGadget's message of "Wed, 22 Jun 2022 19:50:44
        +0000")
Message-ID: <xmqqpmj03183.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDA2B400-F267-11EC-894F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Arthur Milchior via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Arthur Milchior <arthur@milchior.fr>
>
> It should be l10n

It should be, indeed.

Thanks for patching a 10-year old bug, introduced at 75b182ae
(Update l10n guide: change the repository URL, etc, 2012-03-02).

Jiang, I can take it directly to my tree, or I can pull it as part
of the localization update before the release.  Let's make sure we
do not drop it, each expecting that the other party will pick it up
X-<.

> Signed-off-by: Arthur Milchior <arthur@milchior.fr>
> ---
>     po typo: l10
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1280%2FArthur-Milchior%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1280/Arthur-Milchior/patch-1-v1
> Pull-Request: https://github.com/git/git/pull/1280
>
>  po/README.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/README.md b/po/README.md
> index 74856ca5bf2..3e4f897d935 100644
> --- a/po/README.md
> +++ b/po/README.md
> @@ -5,7 +5,7 @@ describes how you can contribute to the effort of enhancing the language
>  coverage and maintaining the translation.
>  
>  The localization (l10n) coordinator, Jiang Xin <worldhello.net@gmail.com>,
> -coordinates our localization effort in the l10 coordinator repository:
> +coordinates our localization effort in the l10n coordinator repository:
>  
>      https://github.com/git-l10n/git-po/
>  
>
> base-commit: ddbc07872e86265dc30aefa5f4d881f762120044
