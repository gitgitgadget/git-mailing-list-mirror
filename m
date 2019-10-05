Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A51AE1F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 09:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfJEJCK (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 05:02:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50016 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfJEJCK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 05:02:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4FC059843;
        Sat,  5 Oct 2019 05:02:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y9tFzUEdqbsMuJ9D5jSwcR0eDiY=; b=Mb4DIF
        K/rmGRi+vNsfsQeWf+P1sW8oy7jwX33UqpQK8mYahiLoPpa3zR4uYlxje0ogwC2G
        xaUVkD1ro9MDyIdgGb+XTmmKnFyB/qOWrKrQ3MAbbVDkHL0fyXSm1SvSnDIVvfxZ
        ix0EaUCSKHsme08del8HE3bIsLpWzQFPXh9/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lm2583Dk6N1ngSpyaR2G/4aF/YJnd86X
        OC7UpxOkcA4P9rLDadB08GYk4T0l8+ldvxH2gtRUyjLHc1koNn0VMQ4OJoHcFidZ
        zeDSt7mX/z9v1vK7LIA2GV71fxuOIfuZ5tmmLDg9nRZdj9wCpvhGq0CBghNseQT5
        GqFAEeKQLZk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1C9F59842;
        Sat,  5 Oct 2019 05:02:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D9FC15983E;
        Sat,  5 Oct 2019 05:02:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation: update the location of the git-gui repo
References: <20191004222956.12341-1-me@yadavpratyush.com>
Date:   Sat, 05 Oct 2019 18:02:01 +0900
In-Reply-To: <20191004222956.12341-1-me@yadavpratyush.com> (Pratyush Yadav's
        message of "Sat, 5 Oct 2019 03:59:56 +0530")
Message-ID: <xmqqr23r7egm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD48E2FE-E74E-11E9-9CD2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
>  Documentation/git-gui.txt | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
> index 5f93f8003d..98337b69f1 100644
> --- a/Documentation/git-gui.txt
> +++ b/Documentation/git-gui.txt
> @@ -114,13 +114,9 @@ of end users.
>  
>  A 'git gui' development repository can be obtained from:
>  
> -  git clone git://repo.or.cz/git-gui.git
> +  git clone https://github.com/prati0100/git-gui.git
>  
> -or
> -
> -  git clone http://repo.or.cz/r/git-gui.git
> -
> -or browsed online at http://repo.or.cz/w/git-gui.git/[].
> +or browsed online at https://github.com/prati0100/git-gui[].
>  
>  GIT
>  ---




These days, unlike back when the original of this manpage was
written, we can expect far more people know Git, GitHub and what to
do with it when they see a GitHub URL to a repository.  Hence, a
single GitHub repository URL is sufficient, without "git clone" or
mention of "browsed online", I would think.

IOW, all of the above can now be just two lines, e.g.

	The official repository of `git gui` project can be found at
	https://github.com/prati0100/git-gui.git/

Thanks.
