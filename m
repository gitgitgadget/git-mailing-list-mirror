Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E38C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7511861108
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhEaF0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 01:26:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61136 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhEaF0d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 01:26:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9069D4BA5;
        Mon, 31 May 2021 01:24:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=wofGmv2dG55iUYCpzzAgdrhaTRM8MiBH1PvxhMcmFo0=; b=ZZVm
        mE+FyWv7XVvy1WlHZvSrRfV/mYfCeTYtqIYsLlQIx1Q5Hod0irp80VAqVkS0Z0tX
        kUsYNiW5EAV1pkB5H/a6wS31iL4eZHBRgz8vyGD5wWkBMHEY4+EIuhMdw8w3v3lV
        wBl83nB92A5Nu0O14nn9NCtbV7EaLJgauggV2SU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1C98D4BA4;
        Mon, 31 May 2021 01:24:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6BA54D4BA2;
        Mon, 31 May 2021 01:24:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-completion.bash: Add --anchored
References: <20210530113135.5778-1-thomas.braun@virtuell-zuhause.de>
Date:   Mon, 31 May 2021 14:24:51 +0900
Message-ID: <xmqqpmx7wk4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86D8135E-C1D0-11EB-B78E-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> Subject: Re: [PATCH] git-completion.bash: Add --anchored

	completion: add --anchored to diff's options 

> This flag was introduced in 2477ab2e (diff: support anchoring line(s),
> 2017-11-27) but back then, the bash completion script did not learn
> about the new flag. Add it.
>
> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---

OK.  Thanks.

>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 3c5739b905..4dd268470a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1729,6 +1729,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
>  			--indent-heuristic --no-indent-heuristic
>  			--textconv --no-textconv
>  			--patch --no-patch
> +			--anchored=
>  "
>  
>  __git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
