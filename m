Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3684C1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 19:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeHOWZG (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 18:25:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38701 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeHOWZG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 18:25:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so2048428wro.5
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 12:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ryyilxWRJZz6PQWybfCM1JrUJM3gFDrx5/LfL+8buI=;
        b=E9P8Z7vZ79vZfBloGvSUsUrrLyYfxyJnN6EFzSSmGAD/e6r6iMjRqelTgQUsIK4JNb
         CGIkq5DKrflH4PYaMI6PnOYU+AHePtKt81aGsiyXrLRu5x/XaeLsnmwpCWd2jJkqqt66
         E6/La3IG3c4CHtACOqsd2AA/CEKkOJf+Y3frdTYtiIc/QAx0e4EizTfVB+mvae57ckPv
         nwG34uSeOEGgnXrq+9O7TGd/QhSg5zYSzy+Z/RRWW8zifKlnwi9Og6xBvjw9Fe3ExRNA
         zzVKtAfRN1e01lPrKV3ndoWIVw1jdQL5nwI0kwAWQKd/gW3wqjal/r9HHQwsFYXnGro3
         nVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ryyilxWRJZz6PQWybfCM1JrUJM3gFDrx5/LfL+8buI=;
        b=mN8mzoTTxDh2i6uT76rcAFYIeShnZNnfQFPZKHWpHt1K0cWcU/5MklHIrBojuxhfKM
         45+nN67p1cGU+cLFr8KWdO0xm/w4GS7Ea7wElOkkeT68DknIXkF6nI+zSFPwzxGnRZ+H
         XnyXGk5jDQnUU+7RTHyChXETW+kBuYu3nXNTAyFexdU+/PTyr9Y3EpgQxY0wxXfAgerQ
         HQcCunbPsDlDBVc7A5ZqLJxi3fXgILq0Nd+5eT80dD4ndk4Fig7i/ZQHt4YPEiK2DvwH
         E0mZ/O+XyPyPJSqE7USGcQtkl3ZS2IhptqlR2RivmQeArM3K/afy3OJhb/Qu9s4K9YTl
         wELQ==
X-Gm-Message-State: AOUpUlH5DEQ6RCz/2/jGwaz2xlrYpCvPPJ5dcyzaKq/uwoJ47LwylxKp
        z7SOaAgZhdjDDDfo7iBrDRuJ/euc
X-Google-Smtp-Source: AA+uWPxiN2pAOAmvOG/2Fhk+e06bWUAtyincLJa+lnufDHXTotD9LgrgZJmhW0BfB6YT9/5n+AaMnA==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr17349611wra.120.1534361495298;
        Wed, 15 Aug 2018 12:31:35 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id q70-v6sm5496209wmd.39.2018.08.15.12.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 12:31:34 -0700 (PDT)
Date:   Wed, 15 Aug 2018 20:31:33 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 04/26] stash: renamed test cases to be more
 descriptive
Message-ID: <20180815193133.GJ2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <cb70dc2317b8bdbe640a50de7050cb405067c0f0.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb70dc2317b8bdbe640a50de7050cb405067c0f0.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: Re: [GSoC][PATCH v7 04/26] stash: renamed test cases to be more descriptive

Please use the imperative mood in the title and the commit messages
themselves.  From Documentation/SubmittingPatches:

    Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
    instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
    to do frotz", as if you are giving orders to the codebase to change
    its behavior.

From a quick skim over the rest of the series, this also applies to
some of the subsequent patches in the series. 

On 08/08, Paul-Sebastian Ungureanu wrote:
> Renamed some test cases' labels to be more descriptive and under 80
> characters per line.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  t/t3903-stash.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index de6cab1fe..8d002a7f2 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -604,7 +604,7 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_success 'stash drop - fail early if specified stash is not a stash reference' '
> +test_expect_success 'drop: fail early if specified stash is not a stash ref' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD && git stash clear" &&
>  	git reset --hard &&
> @@ -618,7 +618,7 @@ test_expect_success 'stash drop - fail early if specified stash is not a stash r
>  	git reset --hard HEAD
>  '
>  
> -test_expect_success 'stash pop - fail early if specified stash is not a stash reference' '
> +test_expect_success 'pop: fail early if specified stash is not a stash ref' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD && git stash clear" &&
>  	git reset --hard &&
> @@ -682,7 +682,7 @@ test_expect_success 'invalid ref of the form "n", n >= N' '
>  	git stash drop
>  '
>  
> -test_expect_success 'stash branch should not drop the stash if the branch exists' '
> +test_expect_success 'branch: should not drop the stash if the branch exists' '

Since we're adjusting the titles of the tests here I'll allow myself
to nitpick a little :)

Maybe "branch: do not drop the stash if the branch exists", which
sounds more like an assertion, as the "pop" and "drop" titles above.

>  	git stash clear &&
>  	echo foo >file &&
>  	git add file &&
> @@ -693,7 +693,7 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
>  	git rev-parse stash@{0} --
>  '
>  
> -test_expect_success 'stash branch should not drop the stash if the apply fails' '
> +test_expect_success 'branch: should not drop the stash if the apply fails' '
>  	git stash clear &&
>  	git reset HEAD~1 --hard &&
>  	echo foo >file &&
> @@ -707,7 +707,7 @@ test_expect_success 'stash branch should not drop the stash if the apply fails'
>  	git rev-parse stash@{0} --
>  '
>  
> -test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
> +test_expect_success 'apply: shows same status as git status (relative to ./)' '

s/shows/show/ above maybe?  This used to be a full sentence
previously, where 'shows' was appropriate, but I think "show" sounds
better after the colon.

>  	git stash clear &&
>  	echo 1 >subdir/subfile1 &&
>  	echo 2 >subdir/subfile2 &&
> @@ -1048,7 +1048,7 @@ test_expect_success 'stash push -p with pathspec shows no changes only once' '
>  	test_i18ncmp expect actual
>  '
>  
> -test_expect_success 'stash push with pathspec shows no changes when there are none' '
> +test_expect_success 'push: <pathspec> shows no changes when there are none' '

Maybe "push <pathspec>: show no changes when there are none"?  "push
<pathspec>" would be the rest of the 'git stash' command, having the
colon in between them seems a bit odd.

>  	>foo &&
>  	git add foo &&
>  	git commit -m "tmp" &&
> @@ -1058,7 +1058,7 @@ test_expect_success 'stash push with pathspec shows no changes when there are no
>  	test_i18ncmp expect actual
>  '
>  
> -test_expect_success 'stash push with pathspec not in the repository errors out' '
> +test_expect_success 'push: <pathspec> not in the repository errors out' '

This one makes sense to me.

>  	>untracked &&
>  	test_must_fail git stash push untracked &&
>  	test_path_is_file untracked
> -- 
> 2.18.0.573.g56500d98f
> 
