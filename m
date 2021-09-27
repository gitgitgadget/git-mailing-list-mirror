Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22ECC433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B029160FF2
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbhI0ULT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:11:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63815 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbhI0ULS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:11:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEC39EA6B7;
        Mon, 27 Sep 2021 16:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vUghEBQApxWv0zz9EITdl1yUZlIps4/gdz2Ql3
        6Vz2E=; b=Pn/7Bw1gMOBV8Yj/aNTu/SXc2ViAc/RHFsP5odEaGt7R6GP87o2j/e
        px+kqtxVB1BHuwk+HU7R1OHrNEa7zsx6Fr42fjZxcfwiZnp5aTsdVPe+fkF4Pg5r
        Wp2+abVfs5eXz0p8x/Bo2w2AJ64awQeL0a2+rMr+ew2kvhxJ+5VZQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6C36EA6B6;
        Mon, 27 Sep 2021 16:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D4F9EA6B5;
        Mon, 27 Sep 2021 16:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] doc: fix capitalization in porcelain v2 section
References: <pull.1095.git.git.1632628082841.gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 13:09:38 -0700
In-Reply-To: <pull.1095.git.git.1632628082841.gitgitgadget@gmail.com> (Orgad
        Shaneh via GitGitGadget's message of "Sun, 26 Sep 2021 03:48:02
        +0000")
Message-ID: <xmqqwnn1pypp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8482074-1FCE-11EC-A947-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgads@gmail.com>
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

Makes sense.  Thanks.
