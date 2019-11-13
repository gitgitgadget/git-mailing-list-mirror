Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9305D1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 03:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfKMDpp (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 22:45:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56971 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfKMDpp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 22:45:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6359923C8D;
        Tue, 12 Nov 2019 22:45:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9b0IQMeyhAAL8JiX2tAKULDpY5M=; b=HDO1rG
        o9brsJutD4k1aKGwS0Ok8NLs9Ceyh+4gjDoafHzZrcOPhXRz4bau3Z0iQnNkxUmY
        SmrzfgKLBwZPv79X7IkF90IzS0VOwVw5dj0/hijochLVGntfLWZ1AhpTPzxotkN7
        Grju9pu2STpusTx3ZKghte7SMeo3FM2iGNAtE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bpLYfqsoWtVVp9yVjedsIjsdEEuVsY9A
        YI0aYuzR01B1HItrO2hibTznYjPvMzQ/KznI5AYKx1BNLizSUAN8LBtDHn4XR74+
        MdHT/6jqt6Ru/191UMtUMPXLlAEP4AQBIln8/aDsITOPVjIT2axO82MJmWULUQ5+
        ku5+wgi3N0U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A9C123C89;
        Tue, 12 Nov 2019 22:45:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B8B8323C86;
        Tue, 12 Nov 2019 22:45:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "James Shubin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, James Shubin <james@shubin.ca>
Subject: Re: [PATCH 1/1] contrib: Add --recursive flag for bash completion
References: <pull.461.git.1573606072.gitgitgadget@gmail.com>
        <ac8cb233ecea69d46ba5a0af0e63bc7c03963cbf.1573606072.git.gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 12:45:41 +0900
In-Reply-To: <ac8cb233ecea69d46ba5a0af0e63bc7c03963cbf.1573606072.git.gitgitgadget@gmail.com>
        (James Shubin via GitGitGadget's message of "Wed, 13 Nov 2019 00:47:52
        +0000")
Message-ID: <xmqqlfskbfru.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11295A02-05C8-11EA-AFF4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"James Shubin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: James Shubin <james@shubin.ca>
> Subject: Re: [PATCH 1/1] contrib: Add --recursive flag for bash completion

The title must make it clear which git subcommand learned the
"--recursive" (unless the patch adds it to everything, that is).

    Subject: [PATCH] completion: tab-complete "git svn --recursive"

By the way, it is pointless to send a cover letter for a single
patch topic like this; you may want to tell GGG not to do so.

> This flag was missing from the list, and I use it quite often :)

Makes sense.

Thanks.  Will queue with title updated locally.

>
> Signed-off-by: James Shubin <james@shubin.ca>
> ---
>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 00fbe6c03d..79fe29ef03 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2843,6 +2843,7 @@ _git_svn ()
>  			--log-window-size= --no-checkout --quiet
>  			--repack-flags --use-log-author --localtime
>  			--add-author-from
> +			--recursive
>  			--ignore-paths= --include-paths= $remote_opts
>  			"
>  		local init_opts="
