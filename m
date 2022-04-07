Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C4DC433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 14:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbiDGOsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 10:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344341AbiDGOs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 10:48:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE85939E
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 07:46:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CF8A17B1E9;
        Thu,  7 Apr 2022 10:46:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KiZAmnlmfC04jAmvEr853sFdBNM7Bq7QuRJUP/
        krYmU=; b=TMBPSzotWNtWMhVUzO3QwbVkZsLSu/Tf+o63YYAx4UudVavflrBhdF
        XV1m/k+XynDsAG2CLfYiIQhiFl8W9EtztcPfJaH690iyz+gZ618BdsBqgqsSbT+0
        WsKfkVxo3wOZJvkn3JeWqoJIn7CjcU7NATr1zZyC7GFNCI+s53sjs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15B6417B1E8;
        Thu,  7 Apr 2022 10:46:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 71A1117B1E6;
        Thu,  7 Apr 2022 10:46:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fangyi Zhou <me@fangyi.io>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] submodule-helper: Fix a missing space
References: <20220406203256.16100-1-me@fangyi.io>
Date:   Thu, 07 Apr 2022 07:46:06 -0700
In-Reply-To: <20220406203256.16100-1-me@fangyi.io> (Fangyi Zhou's message of
        "Wed, 6 Apr 2022 21:32:57 +0100")
Message-ID: <xmqqilrluf2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7530A1A6-B681-11EC-8152-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fangyi Zhou <me@fangyi.io> writes:

> The missing space at the end of the line makes the closing square
> bracket sticking to the dash in the next line
>
> Found during localisation v2.36.0 round 1
>
> Signed-off-by: Fangyi Zhou <me@fangyi.io>
> ---

As this is new in 2.36, let's queue it for -rc1.

Thanks.

>  builtin/submodule--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c3e0d4570f..0b8b226c8f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1902,7 +1902,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	const char *const git_submodule_helper_usage[] = {
>  		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
>  		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
> -		   "[--single-branch] [--filter <filter-spec>]"
> +		   "[--single-branch] [--filter <filter-spec>] "
>  		   "--url <url> --path <path>"),
>  		NULL
>  	};
