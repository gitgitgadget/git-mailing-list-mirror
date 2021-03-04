Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37818C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1016B64EF8
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhCDBRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:17:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63676 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhCDBQw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 20:16:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E3F5111053;
        Wed,  3 Mar 2021 20:16:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=orRLeL1LEyBrr7Vxoz4aVTl1i5c=; b=a/5rfI
        LnqCf6zArQP4eb4vlMJU/ha4EQrzFQc6yr6VYfkB5Yn1NsQBODNtuHvKjSlIDkkq
        Y2iuNeKaJgotIA0m1e8tY6tvfXW3sEl3agP2nqG379cvindrFkKpNWRL6F2O2jRv
        ZIHDX6Pj+EPx4uSGKBQ9oESPydJaUth2pOOxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dGfgUq5k91R7ND/PBOdT/4YegKdlaPrD
        aAuZvrjBQqOmv4lkYDXSPQThACUQ9IG5boCFLngqT+UXeB3nWbAWTgm8jshuE5Dz
        2Pwj+aNucGfWlOw7Z4fyX8qriSLtZ133TFlpY1276pNixUvvYmQjcBQ+v4TlZrfb
        bC4zKY1iWp8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36C92111051;
        Wed,  3 Mar 2021 20:16:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 774F7111050;
        Wed,  3 Mar 2021 20:16:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Julien Richard via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Julien Richard <jairbubbles@hotmail.com>,
        Julien Richard <julien.richard@ubisoft.com>
Subject: Re: [PATCH] Fix small typo in .gitignore documentation
References: <pull.972.git.git.1614775254623.gitgitgadget@gmail.com>
Date:   Wed, 03 Mar 2021 17:16:05 -0800
In-Reply-To: <pull.972.git.git.1614775254623.gitgitgadget@gmail.com> (Julien
        Richard via GitGitGadget's message of "Wed, 03 Mar 2021 12:40:54
        +0000")
Message-ID: <xmqqzgzjen1m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3286A88A-7C87-11EB-8095-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Julien Richard via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index d47b1ae29637..5751603b13f4 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -153,7 +153,7 @@ EXAMPLES
>  --------
>  
>   - The pattern `hello.*` matches any file or folder
> -   whose name begins with `hello`. If one wants to restrict
> +   whose name begins with `hello.`. If one wants to restrict
>     this only to the directory and not in its subdirectories,
>     one can prepend the pattern with a slash, i.e. `/hello.*`;
>     the pattern now matches `hello.txt`, `hello.c` but not

Thanks, will queue.

