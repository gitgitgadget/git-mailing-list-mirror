Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFFD3D38C
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WJmSai0v"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78315243c11so239517485a.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 10:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704825719; x=1705430519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+rM9/ogFvrcUCwr2imZHgQQbDJJUF4vEGOyg7crJf+o=;
        b=WJmSai0v3yasiYA0cfQd6srJ8SIpfhw5703Fq8OtqWl7a2dlyj9F3PGA5nGrIHz2Qw
         tkdj+9knd7NdyoKpPp4WB9DcVJ3DF3eNm+oQ/acidK4k2DdxuCY2d0CZddSP1BAMYqSd
         Lot8NJJmemJY7MzbAAjSwY48uplMmuewpyqsyuWmY2qkyzpv5zL4yTdYFEzMpwBntq/6
         Xbxf2cYqdL0/iH70P08TXGCMFpxkl4jfj46J3Wuty7vS7HPNVn1oqjlPkAzWYk064+J6
         4qO0wXbIqlaa6hH4Ej2jpxmB2hyMfKBLfvrXPeCOZLN9B6Y9iqADkCF1mpVrwppwyXO0
         0wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825719; x=1705430519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rM9/ogFvrcUCwr2imZHgQQbDJJUF4vEGOyg7crJf+o=;
        b=mHQH+xeSj/pqbesCjaO71H6KfgCJJt0JmBSe9N5ejv9Frw0pMt/ekS7nEAsztka9xw
         gu/FEc2hONR6TTSzI5zQgfH2IPbkEIAjepF2WLKnUBfLgXxi8a0KG3sWBGtW7Xav+gj3
         fO5Qe9b9/dUcfh/HYyK5WYjFJ5l6X4eZSDMgcWZR36tbbePeAfwUnTAG+7iAyWBJkEgt
         bgLQq2ZpabrbsvJUjwaeXXNI+aY162Wv1BMFs0aPAX0YguAytx/ISe//l3nBYZKjDlZa
         mFUrRV3V0zxgbXCN3vt5vJQPWclEecyBoPsPNc9Kj/zeIu83aZHYWYAiZus4mrgCrNBx
         8UUg==
X-Gm-Message-State: AOJu0YwlsmbiSfYU7SqOmvmGWKg1clmSYdbBpUT9CuO4O2hko+oLJ3X5
	vL9EeF14/dZQtZap6Z2QydOfNAsaopyyOSfFQZdBmoiNmZ5IXg==
X-Google-Smtp-Source: AGHT+IFs90dCuGhvsCWPRFsnNvVfi7Whne0+KUdQzJzduNffAchNfl2HgFE1QdeIyqeqY7qp12ZwjQ==
X-Received: by 2002:a05:6214:2482:b0:680:40d:5f90 with SMTP id gi2-20020a056214248200b00680040d5f90mr6824170qvb.92.1704825718986;
        Tue, 09 Jan 2024 10:41:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p15-20020a05621421ef00b0067f80dbd535sm1087876qvj.8.2024.01.09.10.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:41:58 -0800 (PST)
Date: Tue, 9 Jan 2024 13:41:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] t1300: mark tests to require default repo format
Message-ID: <ZZ2TdYlcrLN9zckR@nand.local>
References: <cover.1704802213.git.ps@pks.im>
 <ec1b5bdd176e6a3f093b76b732fd9e960a7880ca.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec1b5bdd176e6a3f093b76b732fd9e960a7880ca.1704802213.git.ps@pks.im>

On Tue, Jan 09, 2024 at 01:17:04PM +0100, Patrick Steinhardt wrote:
> The t1300 test suite exercises the git-config(1) tool. To do so we
> overwrite ".git/config" to contain custom contents. While this is easy
> enough to do, it may create problems when using a non-default repository
> format because we also overwrite the repository format version as well
> as any potential extensions.
>
> Mark these tests with the DEFAULT_REPO_FORMAT prerequisite to avoid the
> problem. An alternative would be to carry over mandatory config keys
> into the rewritten config file. But the effort does not seem worth it
> given that the system under test is git-config(1), which is at a lower
> level than the repository format.

I think I am missing something obvious here ;-).

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t1300-config.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index f4e2752134..1e953a0fc2 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1098,7 +1098,7 @@ test_expect_success SYMLINKS 'symlink to nonexistent configuration' '
>  	test_must_fail git config --file=linktolinktonada --list
>  '
>
> -test_expect_success 'check split_cmdline return' "
> +test_expect_success DEFAULT_REPO_FORMAT 'check split_cmdline return' "
>  	git config alias.split-cmdline-fix 'echo \"' &&
>  	test_must_fail git split-cmdline-fix &&
>  	echo foo > foo &&
> @@ -1156,7 +1156,7 @@ test_expect_success 'git -c works with aliases of builtins' '
>  	test_cmp expect actual
>  '

Looking at this first test, for example, I see two places where we
modify the configuration file:

  - git config alias.split-cmdline-fix 'echo \"'
  - git config branch.main.mergeoptions 'echo \"'

I think I am missing some detail about why we can't do this when we have
extensions enabled?

Thanks,
Taylor
