Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFEDB1F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 09:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbeKQTUQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 14:20:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61821 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeKQTUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 14:20:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 654BB1ED8D;
        Sat, 17 Nov 2018 04:04:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pad4qLTE8io4FJBPhpyzwEDFP7Y=; b=hWwslu
        qnJREz+ahcKsIncEIRBbeerQQ63cGItgbSTm5h2EIwyyJFHAOuwIRDrLMw7XUa4D
        Ww8g5vOO2BzLRK/3+9hm24v62jFx2f5GdnE0WUbLLV/OFwrhGrdALIlo6wb+ZyUG
        f9VSpjW1b6ml3q5SNVGFdeYVoRYS52ddvxHWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kUhcs0SlfEk3v845eEestog0Nm11qDlp
        ytDs8buPq2VXwD5RYTr18hc3wPwLaP38o4VzQYLSTwXY5CWpkhEQ9/QQobhll26B
        5e3LIVRXu7lJXMa9HgfWpYgNuBqALrUNtiTI2ysmnOkT7Ga+gEM0dYSJOoV6aoWo
        nxYJmgwSqn8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D9291ED8C;
        Sat, 17 Nov 2018 04:04:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CAD21ED8B;
        Sat, 17 Nov 2018 04:04:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH-2] Change writing style
References: <01020166741c381f-bd183f7f-725d-4b4f-9f5f-804560b2b00b-000000@eu-west-1.amazonses.com>
        <010201671ebf523a-da55f2d8-876a-4b3b-a6fe-29d790bed2c1-000000@eu-west-1.amazonses.com>
Date:   Sat, 17 Nov 2018 18:04:09 +0900
In-Reply-To: <010201671ebf523a-da55f2d8-876a-4b3b-a6fe-29d790bed2c1-000000@eu-west-1.amazonses.com>
        (Jacques Bodin-Hullin's message of "Fri, 16 Nov 2018 22:58:34 +0000")
Message-ID: <xmqqtvkggjna.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFB3BA24-EA47-11E8-9EF0-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com> writes:

> Subject: Re: [PATCH-2] Change writing style

Let's do the usual "<area>: summary" instead.  Perhaps

    Subject: parse-options: lose an unnecessary space in an error message

It is obvious why it is done, so I do not see a need for any other
description in the body of the message for this change.

We still need the patch signed-off.  cf. Documentation/SubmittingPatches

> ---
>  parse-options.c          | 4 ++--
>  t/t0040-parse-options.sh | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

All changes look good to me.


> diff --git a/parse-options.c b/parse-options.c
> index 3b874a83a0c89..f5ef24155950b 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -352,7 +352,7 @@ static void check_typos(const char *arg, const struct option *options)
>  		return;
>  
>  	if (starts_with(arg, "no-")) {
> -		error ("did you mean `--%s` (with two dashes ?)", arg);
> +		error("did you mean `--%s` (with two dashes)?", arg);
>  		exit(129);
>  	}
>  
> @@ -360,7 +360,7 @@ static void check_typos(const char *arg, const struct option *options)
>  		if (!options->long_name)
>  			continue;
>  		if (starts_with(options->long_name, arg)) {
> -			error ("did you mean `--%s` (with two dashes ?)", arg);
> +			error("did you mean `--%s` (with two dashes)?", arg);
>  			exit(129);
>  		}
>  	}
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index 5b0560fa20e34..c442f9ae15ff8 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -222,7 +222,7 @@ test_expect_success 'non ambiguous option (after two options it abbreviates)' '
>  '
>  
>  cat >typo.err <<\EOF
> -error: did you mean `--boolean` (with two dashes ?)
> +error: did you mean `--boolean` (with two dashes)?
>  EOF
>  
>  test_expect_success 'detect possible typos' '
> @@ -232,7 +232,7 @@ test_expect_success 'detect possible typos' '
>  '
>  
>  cat >typo.err <<\EOF
> -error: did you mean `--ambiguous` (with two dashes ?)
> +error: did you mean `--ambiguous` (with two dashes)?
>  EOF
>  
>  test_expect_success 'detect possible typos' '
>
> --
> https://github.com/git/git/pull/540
