Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E0EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 05:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjGHFjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 01:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjGHFii (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 01:38:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BDD2D41
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 22:37:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 118B619C36A;
        Sat,  8 Jul 2023 01:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4zG1zem5yUq1bufIIG5hBo8lvrBjgQCWVmNjLk
        XpWuU=; b=whHSx7Ts91hPHzFaoTxaxy7JNUvrJtfV5Gof75llqpbem1z2UsGbxr
        ksZ3df7hJJiWvaLuC7hZY+QkET4yfS+aFGqL8neg7vDwekULf+/jX+TsT9UWV3m4
        OZdmP/TXgLAGK3QGNaeOW2us/+zPSdHXCs08jgbH4UajMF0CYPGaE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 092F119C369;
        Sat,  8 Jul 2023 01:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7352219C368;
        Sat,  8 Jul 2023 01:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 1/5] SubmittingPatches: reword awkward phrasing
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
        <cb4a61eba8da376fd1874c12360ec67c81af1bd6.1688778359.git.gitgitgadget@gmail.com>
Date:   Fri, 07 Jul 2023 22:37:17 -0700
In-Reply-To: <cb4a61eba8da376fd1874c12360ec67c81af1bd6.1688778359.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Sat, 08 Jul 2023 01:05:55
        +0000")
Message-ID: <xmqqjzvb6k1e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80C2DE02-1D51-11EE-9B08-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/SubmittingPatches | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index b218e273570..b89678cedc3 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -3,8 +3,8 @@ Submitting Patches
>  
>  == Guidelines
>  
> -Here are some guidelines for people who want to contribute their code to this
> -software. There is also a link:MyFirstContribution.html[step-by-step tutorial]
> +Here are some guidelines for contributing back to this
> +project. There is also a link:MyFirstContribution.html[step-by-step tutorial]
>  available which covers many of these same guidelines.

Obviously better.  Thanks.
