Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8B31F424
	for <e@80x24.org>; Thu,  5 Apr 2018 06:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbeDEGxc (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 02:53:32 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39778 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEGxb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 02:53:31 -0400
Received: by mail-wm0-f48.google.com with SMTP id f125so3718903wme.4
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 23:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ldVJUNLmzWij+0ap30bIdW4mbkHvMX6/t1ARi3PCAs8=;
        b=ezlSMC2o1rgaz9e2JnbeeGky8Xq0OvvYrb/eKcR1OeS3l7YRJhIQA6B4W5Ncyf81OB
         aPkm3f7KszfnDp0jZytTJvw1apa1S9+mciHcWrSYe34OoE7Bv4GRjMV3AbbV1fBHmRvD
         y1WX8RxyBjGT+LGmbNo0eh43EDFftZFwwlpH0sMftWz8fGsX0SjfIG0HPcZccG0gy57V
         9OWvzN8CsulY7cEpYvA6eZJqHWW7Y0chXTnNRYQ/zpps8L7FMKutyXFhej+ru+HCbsLw
         ne+IUcWxeGtzUK6RfL+9ZV6CNx61QmJmhul+1TSDvpCD5NDP9I/MwicPid81Mp1slEKe
         nsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ldVJUNLmzWij+0ap30bIdW4mbkHvMX6/t1ARi3PCAs8=;
        b=KZ3rvLueQAI3wPRrJBUJ7njXaTyer34DBrfmWmQ9dc2zshUyaTUz7MxaSUdKClrE0B
         5tuHbOtEGhUqf6GySQqumaOHDEdShYamT3j8j4XS6ZRvxhU/J2u03you1itAFkkf5vUP
         nQ4aWmaC61skjmXOm0WfSD1aLcSwiD4XsfQzrofCpQkHaURefUWyjpEi2VRrjdlVJStY
         l08qtaGkPHzjWyREAWOo7SC6nuFEtgYJtdvYIG0IbLUL0PtnHAURIM0m402UTryPX5RM
         0wNcOnyDSbB1E76lbSgMVjz5eXmnfGkWIFq/UfE/f7KKdPHsNzTcyRYTvhnP1KRs207G
         X96A==
X-Gm-Message-State: ALQs6tAs57vo42tl6/ZDR3ZUD1yd8Gk7eaAkh4lhGmvmkukn+RPiJl/2
        ej3okjSs3AaJtC3FiIuH3gME6s+y
X-Google-Smtp-Source: AIpwx4/c+b4Uw6hFawFOb0sJvu5qmVI6tnUJCMgVxaJ2ZlSqx47b/VDJnjBmj8s6sGVA0DaFv6Yl2g==
X-Received: by 10.80.142.21 with SMTP id 21mr1760880edw.127.1522911210290;
        Wed, 04 Apr 2018 23:53:30 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id m7sm4417171eda.36.2018.04.04.23.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Apr 2018 23:53:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stephon Harris <theonestep4@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] specify encoding for sed command
References: <0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com>
Date:   Thu, 05 Apr 2018 08:53:28 +0200
Message-ID: <87605616vr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 05 2018, Stephon Harris wrote:

> Fixes issue with seeing `sed: RE error: illegal byte sequence` when running git-completion.bash
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index b09c8a23626b4..52a4ab5e2165a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -282,7 +282,7 @@ __gitcomp ()
>
>  # Clear the variables caching builtins' options when (re-)sourcing
>  # the completion script.
> -unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
> +unset $(set |LANG=C sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null

This is getting closer to the issue than your previous patch, but
there's still some open questions:

1) What platform OS / version / sed version is this on?

2) What's the output from "set" that's causing this error? Do we have an
   isolated test case for that?

3) There's other invocations of "sed" in the file, aren't those affected
   as well?

4) Any reason we wouldn't just set LC_AlL=C for the whole file? I see we
   already do it for our invocation to "git merge".
