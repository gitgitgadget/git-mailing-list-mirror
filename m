Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84A41F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfAWXjY (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:39:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46791 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfAWXjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:39:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so4462984wrt.13
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=9ETa7gNTIymbXnXH7o31llBLLySq37lEKYXo51Nl0S8=;
        b=VK4CJqzTGeO7Q36eLAkXxoX7AQwF5wh2tm42S+ktiWKmUR2ahw6SvoFeIQvP0n5N1f
         QOAAZvZgbm3NPVMNt3dlIbHibDed1Rv0A0DjPBJgkXQt42aH/YlR0XNtVk5Yvp+pRrLd
         95KSMaAfRv4QGa44WgYK/ZAi04LRpjHlNyyo3SCdPFnd9lSUuczdY3fn2lpmuMWzBPU9
         UHmaZ5yfBX+blj+oHAzWmIF5pYDNGFq2AcWVIDsk+6sx0886PGwGg1VZ9vGAN7QBsnzz
         ++MOOkpDAaEaCsyPGiepL8D7zYYDmWCLU6jOEClEz8Fo+JtNlIwWm0w+MHPsbOlCi5qY
         fetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=9ETa7gNTIymbXnXH7o31llBLLySq37lEKYXo51Nl0S8=;
        b=igzn96l2xQa5escL7AsOUleCNT5hoAJy207KnZcAsJyQh8ypR47bsPsRat7Z4o+hdK
         UjvGguD7uLEyGCZQDbIqG3EVpJZ34ukYI2QiHLiT7+muhs0oy9H5z6JMXnOZof4CPcvX
         rJPD3MBAgQbCL+0ktfkcPNMBb2T/cbjZPlsumH1tC77c1Ajqr4AQQ6QK3ranJNh/mSD1
         uUQbbAwM5hxmWrIdXwF12lznUTrSqjxZcRpWSico2Le3nk14YKzDvIgXyMR40YF5nkRI
         vxQbS9vizgYjtzZNl5Bp/6o+R5h/gnEW6/1pwiYmLx/rQSlSSb7Z6K+i/PtD4uGv/dbn
         8Dkg==
X-Gm-Message-State: AJcUukf7qXWfuTPXB1ZVHaIKPmb2ORXMO7sVRsYgf3dqe5OQ0WL5l8dZ
        HL4Z3qnY8BJHfleqSZT1Du8=
X-Google-Smtp-Source: ALg8bN6d6fBbDM2pTv1We/XvQFB6tS/GKp2XPWb8kuSePCYVJgu8+esrc9e2crS6K9zypHd6XjG7NA==
X-Received: by 2002:adf:9521:: with SMTP id 30mr4462916wrs.192.1548286754568;
        Wed, 23 Jan 2019 15:39:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y14sm2228055wro.92.2019.01.23.15.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:39:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 17/21] tests: add t/helper/ to the PATH with --with-dashes
Date:   Wed, 23 Jan 2019 15:33:00 -0800
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <966c412f03013902826ffd188ee9af973be60833.1548254412.git.gitgitgadget@gmail.com>
Message-ID: <xmqq1s5354gu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We really need to be able to find the test helpers... Really. This
> change was forgotten when we moved the test helpers into t/helper/
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It is unfortunate that --with-dashes is needed for valgrind and
GIT_TEST_INSTALLED.  Otherwise I do not see why we care about
keeping the option working.

Does any or your test matrix entry actually use --with-dashes and
rely on it working, or is it just the stuff that implicitly depend
on it?

Thanks.

>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9c0ca5effb..c790e98fd2 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1227,7 +1227,7 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
>  	GIT_EXEC_PATH=$GIT_BUILD_DIR
>  	if test -n "$with_dashes"
>  	then
> -		PATH="$GIT_BUILD_DIR:$PATH"
> +		PATH="$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
>  	fi
>  fi
>  GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
