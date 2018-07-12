Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C5D41F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 21:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbeGLVfj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 17:35:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36228 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732547AbeGLVfj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 17:35:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so7466728wmc.1
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ctxlckhbyxLwRcTeVfoIHR7yUnApSMfTXeoNxQw9sNQ=;
        b=NfAiu3+4H3aILCkqhLytLJ37XICG6Mrt1paf7CuWLWmiZpNlpjGbaehAHtVxbSKu09
         BaBch2CyN2X4yJlUpvSR9wQoD+orHfEYDMfg5h5SGOOw+VzZVOLNN8kKCr0YqKeuuELM
         FqM8bM8r0vWcKnn7al6+iUUicmnVh/ozrN8WGvgs4+FIUPTLPSig2GvB9YgD+5N6FySG
         jmEcsDwqysTA1DtV5sHz0f0aF0eOMVIrwSzEcUtX/A5UT+XpKGlSgcb+2KqqxKGTpS94
         gm6BGhmO94BN8gNP5A7y6kXCZ4ujkVREun6hmNd6utxsbdZSigrBjQhT908SVB2T0E7Q
         hOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ctxlckhbyxLwRcTeVfoIHR7yUnApSMfTXeoNxQw9sNQ=;
        b=gW0zmf0zmYk8L+cW/EbqS2SO3HHWp4cAukA9nRbg9sYQiQRxYJx55ZSdaHUgBjvRgW
         1o/MEK94tiL5MgcNsCYalj1bJrlKuB8eiI4n/38QROE3HfowDMSAMD+vQmDtfP3u4I2g
         bJHc++IWyDEOKK+kj01e4l0XGJbTKn4wVmswdQmsJzdBcsMjd4vRBwr3ltgsGEBfTg/t
         9stlnN9sUxN7xa9DghC7dntFGVH6ADp68u6kSf2FDrDyu52I/LvC5oJjGi3GNP6qcrPL
         2BwF17a2+Auj+OG/0oE0WxsYaTehXekFk5epsTLCd94Sivdk0q+3VKlEm83yucCsudKR
         9cXw==
X-Gm-Message-State: AOUpUlExRHU8V7WW3Outm9h6/d/RysGwU4xPgj6lALi+qCPRxZ0QW91U
        IQqnb7DV5ZuJkPOpdO/9wqLCHc/9
X-Google-Smtp-Source: AAOMgpeVvKL6jCT3e3AYLcycf5E5PnE81us2MUslqEa8SpMnEAPrmgjNYPLrSjzgjR4y4vXX8+0qnQ==
X-Received: by 2002:a1c:2352:: with SMTP id j79-v6mr2285568wmj.124.1531430654460;
        Thu, 12 Jul 2018 14:24:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z3-v6sm19477710wru.27.2018.07.12.14.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 14:24:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] git-submodule.sh: rename unused variables
References: <20180712194754.71979-1-sbeller@google.com>
        <20180712194754.71979-3-sbeller@google.com>
Date:   Thu, 12 Jul 2018 14:24:13 -0700
In-Reply-To: <20180712194754.71979-3-sbeller@google.com> (Stefan Beller's
        message of "Thu, 12 Jul 2018 12:47:50 -0700")
Message-ID: <xmqq601kuozm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The 'mode' variable is not used in cmd_update for its original purpose,
> rename it to 'dummy' as it only serves the purpose to abort quickly
> documenting this knowledge.

It seems that

 (1) the while loop in git-submodule.sh we see in this patch is the
     only thing that read from submodule--helper update-clone; and

 (2) the mode/sha1/stage output from prepare_to_clone_next_submodule()
     is shown only when update_clone_get_next_task which in turn is
     run only during update-clone task

so this conversion will not have unintended bad effect on other
codepaths that use similarly formatted (but already different)
output used by the users of module_list.  

Which tells us that this step is safe.

I am not sure how much it buys us not having to format mode into hex
and not having to call ce_stage(), when we have cache entry anyway
in the codeflow, though.  IOW, it is unclear at this second step in
the six-patch series if we get to the end of the tunnel sooner by
having this step here.  Let's keep reading ;-).




> The variable 'stage' is also not used any more in cmd_update, so remove it.
>
> This went unnoticed as first each function used the commonly used
> submodule listing, which was converted in 74703a1e4df (submodule: rewrite
> `module_list` shell function in C, 2015-09-02). When cmd_update was
> using its own function starting in 48308681b07 (git submodule update:
> have a dedicated helper for cloning, 2016-02-29), its removal was missed.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 5 ++---
>  git-submodule.sh            | 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 20ae9191ca3..ebcfe85bfa9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1571,9 +1571,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  	needs_cloning = !file_exists(sb.buf);
>  
>  	strbuf_reset(&sb);
> -	strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
> -			oid_to_hex(&ce->oid), ce_stage(ce),
> -			needs_cloning, ce->name);
> +	strbuf_addf(&sb, "dummy %s %d\t%s\n",
> +		    oid_to_hex(&ce->oid), needs_cloning, ce->name);
>  	string_list_append(&suc->projectlines, sb.buf);
>  
>  	if (!needs_cloning)
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8a611865397..56588aa304d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -531,9 +531,9 @@ cmd_update()
>  		"$@" || echo "#unmatched" $?
>  	} | {
>  	err=
> -	while read -r mode sha1 stage just_cloned sm_path
> +	while read -r quickabort sha1 just_cloned sm_path
>  	do
> -		die_if_unmatched "$mode" "$sha1"
> +		die_if_unmatched "$quickabort" "$sha1"
>  
>  		name=$(git submodule--helper name "$sm_path") || exit
>  		if ! test -z "$update"
