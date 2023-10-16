Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E912E633
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OopLwWXc"
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48814B4
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 08:58:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so3128762a12.1
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697471885; x=1698076685; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XBd9TJFH4AgA2v4pQ8DGjPF0j7ZLzNR2giITHwlz688=;
        b=OopLwWXc3SEBtH0bh+0eQ71HOud8eOUZl6VTeMU4vtXyp2I10Os4bQoVagGW1+0iM7
         Mgot/1/3qxt0qE6znqE3rxj5bjInvHR79CFTYrITmQwkyY1csbRSPkhn5YVSAcvT7zeD
         1+qlBddfz51IdR6KzB8myU3tCl9uGgeUMb3kAbmTzD++OoGKSa6/fIww/wE3Krnhdar6
         4ZSWCBoSSw2E+OeMXcmrDNe/kK+9x8xwXS3XCsC94V0AkGJ/r6tku6vjBwe8E5M2QsKc
         d+IGPiGXf8W0gSZ1BO8I2kb6+FUQZZQ61sECaDkxVhcPPMPiYHco9Kf4TFQs73KqRojj
         8ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471885; x=1698076685;
        h=content-disposition:mime-version:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBd9TJFH4AgA2v4pQ8DGjPF0j7ZLzNR2giITHwlz688=;
        b=O+w3UH4/GeAu2M0MuZTHka7B2Iu8YcjvJkFe58vPUzGR8/o8pmEEN4Xz0Oj/A1qxtw
         cOxIGhL0jWRHgTFlhBHfGDgM4jkTYAb2lOvyJRcFEZ6fcYpD6CaIdhSr6KHtO4Ea7nx6
         ZYpsaZP33q+eF2Gw+fShWtKKroSHSGIumZhSFg1BCRgSK0jZTRYPSo2NTr2vp0C3GvvF
         w5mSHjB0P5b0PlxBLZ2FDjY8LzCmIV3QVVM5A8txvQPJHabfJkX9KIyMXzI6HkiAlZ+m
         7jmVhk+Xdp3agHnwF6j++3oRM0imgCR8GUXcHjTmRgWXdhSHJiBv4mhg3oTaVj+Wj+ML
         AI/w==
X-Gm-Message-State: AOJu0YyjXwOfQ5WnB+svjygBbBfBXdKSCEKoW4fm7h0uiq6QFJb8G1zG
	AhWVaAHeXyNGI3DyrgSIfg==
X-Google-Smtp-Source: AGHT+IF5XEamELEyKiGemh5iY8SKkwijZj3VJt2/LMkDs/XJOAz94SXP2wGIEmD5/VBIpl6OtUgGdQ==
X-Received: by 2002:a17:907:7857:b0:9b2:abb1:a4ab with SMTP id lb23-20020a170907785700b009b2abb1a4abmr27426035ejc.65.1697471884408;
        Mon, 16 Oct 2023 08:58:04 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id qn3-20020a170907210300b009930042510csm4305069ejb.222.2023.10.16.08.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 08:58:03 -0700 (PDT)
Date: Mon, 16 Oct 2023 18:57:59 +0300
From: Dorcas Litunya <anonolitunya@gmail.com>
To: christian.couder@gmail.com
Cc: anonolitunya@gmail.com, git@vger.kernel.org, gitster@pobox.com
Message-ID: <ZS1dh8RcWD8vzBzM@dorcaslitunya-virtual-machine>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_SUBJECT,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Bcc: 
Subject: Re: [PATCH] t/t7601: Modernize test scripts using functions
Reply-To: 
In-Reply-To: <20231016152113.135970-1-anonolitunya@gmail.com>

On Mon, Oct 16, 2023 at 06:21:00PM +0300, Dorcas AnonoLitunya wrote:
> The test script is currently using the command format 'test -f' to
> check for existence or absence of files.
> 
> Replace it with new helper functions following the format
> 'test_path_is_file'.
> 
> Consequently, the patch also replaces the inverse command '! test -f' or
> 'test ! -f' with new helper function following the format
> 'test_path_is_missing'
> 
> This adjustment using helper functions makes the code more readable and
> easier to understand.
> 
> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> ---
>  t/t7601-merge-pull-config.sh | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index bd238d89b0..e08767df66 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -349,13 +349,13 @@ test_expect_success 'Cannot rebase with multiple heads' '
>  
>  test_expect_success 'merge c1 with c2' '
>  	git reset --hard c1 &&
> -	test -f c0.c &&
> -	test -f c1.c &&
> -	test ! -f c2.c &&
> -	test ! -f c3.c &&
> +	test_path_is_file c0.c &&
> +	test_path_is_file c1.c &&
> +	test_path_is_missing c2.c &&
> +	test_path_is_missing c3.c &&
>  	git merge c2 &&
> -	test -f c1.c &&
> -	test -f c2.c
> +	test_path_is_file c1.c &&
> +	test_path_is_file c2.c
>  '
>  
>  test_expect_success 'fast-forward pull succeeds with "true" in pull.ff' '
> @@ -411,8 +411,8 @@ test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
>  	git reset --hard c1 &&
>  	git config pull.twohead ours &&
>  	git merge c2 &&
> -	test -f c1.c &&
> -	! test -f c2.c
> +	test_path_is_file c1.c &&
> +	test_path_is_missing c2.c
>  '
>  
>  test_expect_success 'merge c1 with c2 and c3 (recursive in pull.octopus)' '
> @@ -431,10 +431,10 @@ test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octo
>  	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
>  	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
>  	git diff --exit-code &&
> -	test -f c0.c &&
> -	test -f c1.c &&
> -	test -f c2.c &&
> -	test -f c3.c
> +	test_path_is_file c0.c &&
> +	test_path_is_file c1.c &&
> +	test_path_is_file c2.c &&
> +	test_path_is_file c3.c
>  '
>  
>  conflict_count()
> -- 
> 2.42.0.345.gaab89be2eb
>

Please ignore this version as I had not indicated Outreachy in the
subject header. Thanks.
