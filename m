Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF16C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D86613C5
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhDPTM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 15:12:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59237 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhDPTM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 15:12:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D62312BC2E;
        Fri, 16 Apr 2021 15:12:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ADMmWrb/luFbRj2TIdMhzuEqPrE=; b=EvOX8r
        DiKaOCoihVvqEcK4WAjB4NFyeMONWS1qz0IRISlBkIDid2ZoQ8HXXm2EreMtyE2f
        Yk10I+3IDmNG7qO6kDTPsKxCAiv4gk/SCEt0gl0O+8FXGjYlJXr+UMKu7huWVfcU
        Xh0pSZNuuUxJxW1ZJf6+cjoDl/Uo4OnqQoml0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t3f426KtaCBzze6vgtjFcnb11ldxg5y6
        Os+8oY2S8gPAjqVzr4cZuWVfkSCoRjhk8T6fcCGoRAsncAD+rhQIUuayxAcdZCEt
        YM3ZcT2iyshbDeW/6Lc/+SrfT/Us8a9IgfiYbknd6Mr7nXfnFvHwvKUwAHKrazNx
        /1DvI6uhork=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95F7A12BC2D;
        Fri, 16 Apr 2021 15:12:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CDCC812BC2A;
        Fri, 16 Apr 2021 15:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v10 1/2] [GSOC] docs: correct descript of
 trailer.<token>.command
References: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <8129ef6c476b4f35be59eae71367de5b83888068.1618562875.git.gitgitgadget@gmail.com>
Date:   Fri, 16 Apr 2021 12:11:57 -0700
In-Reply-To: <8129ef6c476b4f35be59eae71367de5b83888068.1618562875.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Fri, 16 Apr 2021 08:47:54
        +0000")
Message-ID: <xmqq7dl2m4ci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DE4F65E-9EE7-11EB-9F25-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v10 1/2] [GSOC] docs: correct descript of trailer.<token>.command

s/descript/&ion/ (no need to resend only to fix this).

> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 96ec6499f001..6f2a7a130464 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -232,25 +232,30 @@ trailer.<token>.ifmissing::
>  	that option for trailers with the specified <token>.
>  
>  trailer.<token>.command::
> +	This option can be used to specify a shell command that will be called:
> +	once to automatically add a trailer with the specified <token>, and then
> +	each time a '--trailer <token>=<value>' argument to modify the <value> of
> +	the trailer that this option would produce.
>  +
> +When the specified command is first called to add a trailer
> +with the specified <token>, the behavior is as if a special
> +'--trailer <token>=<value>' argument was added at the beginning
> +of the "git interpret-trailers" command, where <value>
> +is taken to be the standard output of the command with any
> +leading and trailing whitespace trimmed off.
>  +
> +If some '--trailer <token>=<value>' arguments are also passed
> +on the command line, the command is called again once for each
> +of these arguments with the same <token>. And the <value> part
> +of these arguments, if any, will be used to replace the first
> +occurrence of substring `$ARG` in the command. This way the
> +command can produce a <value> computed from the <value> passed
> +in the '--trailer <token>=<value>' argument.
>  +

Makes quite a lot of sense.  I wouldn't have got confused by the
behaviour of .command if it were documented like the above from day
one.  Very nice.

> +For consistency, the first occurrence of substring `$ARG` is
> +also replaced, this time with the empty string, in the command
> +when the command is first called to add a trailer with the
> +specified <token>.

OK, so "for consistency" is about consistency between the "execute
once first without being asked" case (where there is no plausible
source of $ARG), and "execute because we were asked by a command
line option (where we are given <value> to replace $ARG).

Makes sense.

Will queue.  Thanks.




