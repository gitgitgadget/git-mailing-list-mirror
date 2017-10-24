Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF631FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 16:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbdJXQpJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 12:45:09 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:10280 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbdJXQpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 12:45:08 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3yLzdt4mHbz5tlL;
        Tue, 24 Oct 2017 18:45:06 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A604F208D;
        Tue, 24 Oct 2017 18:45:05 +0200 (CEST)
Subject: Re: [PATCH v2 1/1] completion: add remaining flags to checkout
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20171012122059.17242-1-thomas.braun@virtuell-zuhause.de>
 <20171024131931.18221-1-thomas.braun@virtuell-zuhause.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <be2e0547-5ef7-c9d9-baad-44f5fa9d3c31@kdbg.org>
Date:   Tue, 24 Oct 2017 18:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171024131931.18221-1-thomas.braun@virtuell-zuhause.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.10.2017 um 15:19 schrieb Thomas Braun:
> In the commits 1fc458d9 (builtin/checkout: add --recurse-submodules
> switch, 2017-03-14), 08d595dc (checkout: add --ignore-skip-worktree-bits
> in sparse checkout mode, 2013-04-13) and 32669671 (checkout: introduce
> --detach synonym for "git checkout foo^{commit}", 2011-02-08) checkout
> gained new flags but the completion was not updated, although these flags
> are useful completions. Add them.
> 
> The flags --force and --ignore-other-worktrees are not added as they are
> potentially dangerous.
> 
> The flags --progress and --no-progress are only useful for scripting and are
> therefore also not included.
> 
> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>   contrib/completion/git-completion.bash | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d934417475..eb6ade6974 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1250,7 +1250,8 @@ _git_checkout ()
>   	--*)
>   		__gitcomp "
>   			--quiet --ours --theirs --track --no-track --merge
> -			--conflict= --orphan --patch
> +			--conflict= --orphan --patch --detach --ignore-skip-worktree-bits
> +			--recurse-submodules --no-recurse-submodules
>   			"
>   		;;
>   	*)
> 

Looks good to me. Thanks,
-- Hannes

