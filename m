Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA3C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 22:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiCCW0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiCCW0T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 17:26:19 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A46F3EB8D
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 14:25:33 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B507127655;
        Thu,  3 Mar 2022 17:25:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1jqjkYu8ZUKFhqQaszKZZ+iY/bHEHThLQF0PZV
        Qm9E8=; b=O2Y1IbktscwTAJQXxno0PUZpcKdjGx7Wmhx+D0NsclnrNL+3IXSY+f
        RHp42lVbaKjsM4ANyZtyvacM3HPYM+MqNhVstKWYDQajnvvP6phAxlG/RJFkz/oO
        m21xDtniCfVbGh6ny6Lt2GUKNH2U0oJhuKHN0DQem+5EegNFQwI1g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53C38127654;
        Thu,  3 Mar 2022 17:25:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2611127653;
        Thu,  3 Mar 2022 17:25:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nihal Jere <nihal@nihaljere.xyz>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: git-read-tree: separate links using commas
References: <20220303161542.11616-1-nihal@nihaljere.xyz>
Date:   Thu, 03 Mar 2022 14:25:30 -0800
In-Reply-To: <20220303161542.11616-1-nihal@nihaljere.xyz> (Nihal Jere's
        message of "Thu, 3 Mar 2022 10:15:43 -0600")
Message-ID: <xmqqzgm67jxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D646F802-9B40-11EC-9DFF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nihal Jere <nihal@nihaljere.xyz> writes:

> This makes it consistent with the rest of the documentation.

Indeed it does.  Thanks, will queue.

>
> Signed-off-by: Nihal Jere <nihal@nihaljere.xyz>
> ---
>  Documentation/git-read-tree.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
> index 8c3aceb832..8cbf0c82f3 100644
> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -420,8 +420,8 @@ support.
>  
>  SEE ALSO
>  --------
> -linkgit:git-write-tree[1]; linkgit:git-ls-files[1];
> -linkgit:gitignore[5]; linkgit:git-sparse-checkout[1];
> +linkgit:git-write-tree[1], linkgit:git-ls-files[1],
> +linkgit:gitignore[5], linkgit:git-sparse-checkout[1]
>  
>  GIT
>  ---
