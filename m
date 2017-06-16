Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D41C01FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 21:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbdFPVYr (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 17:24:47 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35630 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdFPVYq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 17:24:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so8176488pfs.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JqWBF08BgkEN0EFoitNO6PB8eKHh6kI2nvXMI2PponU=;
        b=nZDhBoG79v48CUvEWXcdNyTFcOE4bMtXImN64F7T3ua+cauqUPBcL6WVVENqdKZafj
         4CQYF+15NcbM3PFOIsIHV6iK4Jo5IbxU8mip+fE4OhYRskKztlHRTuWvtBuj5nOPVcSd
         UMnmdeDZeDShVHMUcCg0iyP47IIZTpNh6Af0hi9XSRxDC0EodzoI9SEDyYQ4I9Szd0Z6
         O1WWIEomsLDfeJIYHrSlzUJ0t6zw1uMhFxzTkqhX5iZEBjag4WfCWVwvBbtnNBy7XDVF
         ItGvuNn66CFILtx88gtTDTJH7nEal6ON9TPIi87d41jMcu7enupp+fa+XsfPY7Yc6014
         45wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JqWBF08BgkEN0EFoitNO6PB8eKHh6kI2nvXMI2PponU=;
        b=sQT6UIoGmrcAwMhu25/DQrIpACkBLFLdsYp94aCPQu/QHRhdt7smM+5agTN06shI9U
         U3TF9/8SxRdzOFWA53nkyMJOzOjToZDOkSx9iNTDFSyy5T6/WFVa9x9mfFx2AF2gJ2e0
         V9t0lazC1dVxN5MPiX0PZeEPXYEs0MdpCSJRyXwJmdoORWsD0RYdodf/EClvrJQllYaE
         a9bl3PSMSEIaknzxzbv1ohe/UXGr/3ZyPd1GSPMU+I5emU7xkX6cI/IeVFJn0aFHKWpK
         r2YGo31MBTMXlih8ipiYW2WlUClemoVrtay+BDb9VioakfB3muHh4VxcXbccLnb4qqJg
         F9cg==
X-Gm-Message-State: AKS2vOz2fJAV4Sj4loDv6VKcUzJiT9MT3qL0wHl/0aorr+r0uJs37O8U
        /8ejnw9oFDF/7Q==
X-Received: by 10.84.217.197 with SMTP id d5mr14968916plj.282.1497648285098;
        Fri, 16 Jun 2017 14:24:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id g13sm6080846pgu.54.2017.06.16.14.24.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 14:24:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, houstonfortney@gmail.com,
        kostix+git@007spb.ru, peff@peff.net, sxlijin@gmail.com
Subject: Re: [PATCH 1/3] stash: update documentation to use 'stash entries'
References: <20170616043050.29192-1-liambeguin@gmail.com>
        <20170616043050.29192-2-liambeguin@gmail.com>
Date:   Fri, 16 Jun 2017 14:24:43 -0700
In-Reply-To: <20170616043050.29192-2-liambeguin@gmail.com> (Liam Beguin's
        message of "Fri, 16 Jun 2017 00:30:48 -0400")
Message-ID: <xmqqmv97wrqc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Liam Beguin <liambeguin@gmail.com> writes:

> Most of the time, a 'stash entry' is called a 'stash'
> or a 'stash state'. Lets use 'stash entry' instead.
>
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 70191d06b69e..59979ad31dfe 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -51,18 +51,18 @@ OPTIONS
>  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
>  push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
>  
> -	Save your local modifications to a new 'stash' and roll them
> +	Save your local modifications to a new 'stash entry' and roll them
>  	back to HEAD (in the working tree and in the index).
>  	The <message> part is optional and gives
>  	the description along with the stashed state.
>  +
>  For quickly making a snapshot, you can omit "push".  In this mode,
>  non-option arguments are not allowed to prevent a misspelled
> -subcommand from making an unwanted stash.  The two exceptions to this
> +subcommand from making an unwanted entry.  The two exceptions to this

It is more clear to spell it out as 'unwanted stash entry' in the
context of this sentence.

>  list [<options>]::
>  
> -	List the stashes that you currently have.  Each 'stash' is listed
> -	with its name (e.g. `stash@{0}` is the latest stash, `stash@{1}` is
> +	List the stash entries that you currently have.  Each 'stash entry' is
> +	listed with its name (e.g. `stash@{0}` is the latest entry, `stash@{1}` is
>  	the one before, etc.), the name of the branch that was current when the

Unlike the previous one, 'the latest entry' here is clear enough
that it is talking about 'the latest stash entry' from the context,
and I think this paragraph is good.

> -	stash was made, and a short description of the commit the stash was
> +	entry was made, and a short description of the commit the entry was

So is this one.

> @@ -105,11 +105,11 @@ command to control what is shown and how. See linkgit:git-log[1].
>  
>  show [<stash>]::
>  
> -	Show the changes recorded in the stash as a diff between the
> -	stashed state and its original parent. When no `<stash>` is given,
> +	Show the changes recorded in the stash entry as a diff between the

This is good, but...

> +	stashed entry and its original parent. When no `<stash>` is given, it

... the original phrasing "stashed state" is better than this
rewrite, because a "stash entry" is a vessel that holds a set of
"stashed states" (the working tree state, the state of the index,
and the contents of untracked files).

I think what is shown is "between the stashed contents of the
working tree and the commit back when the stash entry was created".

> @@ -149,26 +149,27 @@ branch <branchname> [<stash>]::
>  +
>  This is useful if the branch on which you ran `git stash save` has
>  changed enough that `git stash apply` fails due to conflicts. Since
> -the stash is applied on top of the commit that was HEAD at the time
> -`git stash` was run, it restores the originally stashed state with
> -no conflicts.
> +the stash entry is applied on top of the commit that was HEAD at the
> +time `git stash` was run, it restores the originally stashed entry
> +with no conflicts.

Again, I do not think the last one should be made into "stashed
entry".  We are restoring the stashed state, recorded in the named
'stash entry'.

>  clear::
> -	Remove all the stashed states. Note that those states will then
> +	Remove all the stashed entries. Note that those entries will then

This is removing 'all the stash entries'.

>  drop [-q|--quiet] [<stash>]::
>  
> -	Remove a single stashed state from the stash list. When no `<stash>`
> +	Remove a single stashed entry from the stash list. When no `<stash>`

A single 'stash entry' is being removed from the list of stash entries.
