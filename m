Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 094251F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 18:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbcJES5s (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 14:57:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55936 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753002AbcJES5r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 14:57:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC6FC447C4;
        Wed,  5 Oct 2016 14:57:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/n/wfdXinJsD0U2/1dDFo/TN+Qc=; b=TJBjK/
        Lt6/+VoHq2pSw4vckn4Z9PPXbdBsOfiCLX9jI5WPonoX33rhUDAN3y9AY3cVK6OH
        kyZFJcgsG+CSfaV30lFXfi7WEVRIcPJ8TgDsaBxB/qyzRLFb7PvaDAEUzflXg51q
        YfoCFeQkn/4FSkwLoD6/YPBVHzhPMO+mjZh0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ad95TYg1N8uS6cyIxfdDshCFD+k8W9Kk
        LChmh3iYxCLEEqRIOZBRP2bgFfYfuLFThnFMGvpi7dpyr3r+CuZDTTzhuDRNerUA
        UXQ2FUB3gEud3L8MZ9ggraJa2/BthzvrwQCFz0A4jCyx6lyiCFD60HfwZlydB2H6
        02Ry28J47yU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4B72447C3;
        Wed,  5 Oct 2016 14:57:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C951447C2;
        Wed,  5 Oct 2016 14:57:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     sorganov@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] Documentation/git-merge.txt: get rid of irrelevant references to git-pull
References: <cover.1475678515.git.sorganov@gmail.com>
        <b91ef5e97c60a85cce1a13f88a19218fd0f05655.1475678515.git.sorganov@gmail.com>
Date:   Wed, 05 Oct 2016 11:57:43 -0700
In-Reply-To: <b91ef5e97c60a85cce1a13f88a19218fd0f05655.1475678515.git.sorganov@gmail.com>
        (sorganov@gmail.com's message of "Wed, 5 Oct 2016 17:46:24 +0300")
Message-ID: <xmqqzimioc7s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99DDCDE2-8B2D-11E6-B99E-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sorganov@gmail.com writes:

> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 351b8fc..ba5fb0a 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -23,10 +23,6 @@ named commits and the current branch, called "merge base", is
>  calculated, and then net changes taken from the merge base to
>  the named commits are applied.
>  
> -This command is used by 'git pull' to incorporate changes from another
> -repository, and can be used by hand to merge changes from one branch
> -into another.
> -

Good.

> @@ -119,18 +115,17 @@ of `git fetch` for merging are merged to the current branch.
>  PRE-MERGE CHECKS
>  ----------------
>  
> -Before applying outside changes, you should get your own work in
> -good shape and committed locally, so it will not be clobbered if
> -there are conflicts.  See also linkgit:git-stash[1].
> -'git pull' and 'git merge' will stop without doing anything when
> -local uncommitted changes overlap with files that 'git pull'/'git
> -merge' may need to update.
> +Before applying outside changes, you should get your own work in good
> +shape and committed locally, so it will not be clobbered if there are
> +conflicts. See also linkgit:git-stash[1]. 'git merge' will stop
> +without doing anything when local uncommitted changes overlap with
> +files that 'git merge' may need to update.
>  
> -To avoid recording unrelated changes in the merge commit,
> -'git pull' and 'git merge' will also abort if there are any changes
> -registered in the index relative to the `HEAD` commit.  (One
> -exception is when the changed index entries are in the state that
> -would result from the merge already.)
> +To avoid recording unrelated changes in the merge commit, 'git merge'
> +will also abort if there are any changes registered in the index
> +relative to the `HEAD` commit. (One exception is when the changed
> +index entries are in the state that would result from the merge
> +already.)

OK, so "git pull and git merge" have been updated to say "git
merge" and there is no other change.  Looks good.

Please do not re-flow and change in the same commit, by the way.

> @@ -138,14 +133,15 @@ will exit early with the message "Already up-to-date."
>  FAST-FORWARD MERGE
>  ------------------
>  
> -Often the current branch head is an ancestor of the named commit.
> +Often the current branch head is an ancestor of the named commit.  In
> +this case, a new commit is not needed to store the combined history;
> +instead, the `HEAD` (along with the index) is updated to point at the
> +named commit, without creating an extra merge commit.
> +
>  This is the most common case especially when invoked from 'git
>  pull': you are tracking an upstream repository, you have committed
>  no local changes, and now you want to update to a newer upstream
> -revision.  In this case, a new commit is not needed to store the
> -combined history; instead, the `HEAD` (along with the index) is
> -updated to point at the named commit, without creating an extra
> -merge commit.
> +revision.

I am not sure if the post-image of this hunk is better than the
original.

