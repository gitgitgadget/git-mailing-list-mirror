Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9308CC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 17:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B0C6197E
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 17:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhCSRz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 13:55:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54014 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhCSRzS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 13:55:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD04C11703F;
        Fri, 19 Mar 2021 13:55:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6VT4unTG3k0bco4PCGRFmktRzz8=; b=CPw0rN
        RTdRLhJF7e8OG/9XR+g458tmcUvQz6z1Qw0higiXEe/UwcncuayJHEyaB5s0CQfL
        RuoE6x7aBK7LmnyBaXdTbCfjpW+5gnuJ0iT8+m4k+LdmShc8bI84fnucg7axurT5
        +k0aAmq5Gs37RA6Fdf2T62UTsS9fdyJFZioFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uh5EmqKMk2mvhasq1w+joTNiZF2OhvjV
        qUFqqA5Z7WMDrqeAh2NPvM9D20c3wDP5GEggG6KhFScuDVxm6MaiSgfkifHyYLpi
        egsbEUuP1xnZ1WJiNXZBql2PHhgDu9jjR+9iHnyflX9pOZLEgg3Vlog8jPfv6vBM
        w74oNV4joTo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B624A11703E;
        Fri, 19 Mar 2021 13:55:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F64A11703D;
        Fri, 19 Mar 2021 13:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nils Leif Fischer via GitGitGadget" <gitgitgadget@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Nils Leif Fischer <hello@nilsleiffischer.de>,
        Nils Leif Fischer <nils.fischer@aei.mpg.de>
Subject: Re: [PATCH] Fix a typo in git-maintenance documentation
References: <pull.984.git.git.1616149021392.gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 10:55:13 -0700
In-Reply-To: <pull.984.git.git.1616149021392.gitgitgadget@gmail.com> (Nils
        Leif Fischer via GitGitGadget's message of "Fri, 19 Mar 2021 10:17:01
        +0000")
Message-ID: <xmqqv99nm3jy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4242C1B2-88DC-11EB-A704-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nils Leif Fischer via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Nils Leif Fischer <nils.fischer@aei.mpg.de>
>
> Signed-off-by: Nils Leif Fischer <nils.fischer@aei.mpg.de>
> ---
>     Fix typo in git-maintenance documentation
>     
>     Just a small typo.

This is from the very beginning at 2057d750 (maintenance: create
basic maintenance runner, 2020-09-17), I think.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-984%2Fnilsleiffischer%2Fnilsleiffischer-patch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-984/nilsleiffischer/nilsleiffischer-patch-1-v1
> Pull-Request: https://github.com/git/git/pull/984
>
>  Documentation/git-maintenance.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 80ddd33ceba0..8023504dc65d 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -106,7 +106,7 @@ any object transfer.
>  
>  gc::
>  	Clean up unnecessary files and optimize the local repository. "GC"
> -	stands for "garbage collection," but this task performs many
> +	stands for "garbage collection", but this task performs many

Isn't this merely an American style vs British style issue?


>  	smaller tasks. This task can be expensive for large repositories,
>  	as it repacks all Git objects into a single pack-file. It can also
>  	be disruptive in some situations, as it deletes stale data. See
>
> base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f


cf.

https://www.grammarly.com/blog/quotation-marks
https://www.thepunctuationguide.com/british-versus-american-style.html
https://owl.purdue.edu/owl/general_writing/punctuation/quotation_marks/more_quotation_mark_rules.html
