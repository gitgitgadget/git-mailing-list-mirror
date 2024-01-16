Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E71BF33
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH6bT6C6"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3376ead25e1so7833176f8f.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 06:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705417134; x=1706021934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4h/7JirPHaZexX3VQRKZ/clD+Knr80HvNqpPSNIsNDw=;
        b=PH6bT6C6bAiaLQKs9TbCTpYAwaT93lLvz9ylFDZVm5Fj/A87qqMm02/BDYRvT3s0YH
         dfGtzRpkEgbCr+n5JMDKP+pkmNqn9ug4LOUQ0whVPCf7rAlO0vUMSLktloXq6tzCx8LE
         Pif8Uoh2EZbsO+xSJbWeItRZz6pVnMFBq5lyf4xPybi9LXOtNu/6pf9bThSbdJxjPAgy
         a9zX59i1EeQ9+MbXkUZT7GvcmxlCWIUXqxuVcAeQUxCxtnpmAdJH1LX9YTAtQTBzTEzN
         kdvy+Gi99f+fkLtpS09IV+T6kxA0EkAAL49hW2N054iJPOHNZ1CbqiW7pr7hN22UABqP
         K4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705417134; x=1706021934;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4h/7JirPHaZexX3VQRKZ/clD+Knr80HvNqpPSNIsNDw=;
        b=ab6HUlGFTSeyR/yo41g+juIGankQFwUfkhUmuQ4TQcJjqYPeSKHhwKfGLK7cYiAtaA
         zSMSLnn1LmxB+tDjpwg+UVyeeQAvxVISfjlYfiQC6aKnu1l8Xy89Dm2NKP2lScrK1r9L
         qEuTyEVm5O5afEjaA99Ik8Bf+lp2Qu5qeMKNsSdJYV5oR6sg4YJKCznsA3e/RsXfWxyo
         +v/mG1g20qQYhWJWLHIkNvo1PkeOgCg6cYhzpfU8OixoImE379moJ6kZlNTQR+g5xRdh
         4SZoGs0xi5bdECIG+v80G48NaVPZj85uKSKcUdXDe0J0uEvQ/m++Czsa1TRvBZKPmWug
         bgeQ==
X-Gm-Message-State: AOJu0YwPZejV4MUJSlVGHVS08exwch2VxF5mIeGBH/MiY05iTLehdqoe
	Fe24A4hbPN6O8x5+mzJetMY=
X-Google-Smtp-Source: AGHT+IEjCAWHU56KEzEv3qVp7Bq3Ql6deeIaNgqZ+SsK7g3p0OUDXh4v1mLyZjZAPaPF6cbfbSig7Q==
X-Received: by 2002:a05:6000:11cc:b0:337:6e32:1812 with SMTP id i12-20020a05600011cc00b003376e321812mr3463128wrx.35.1705417134234;
        Tue, 16 Jan 2024 06:58:54 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id o10-20020a056000010a00b00336cbbf2e0fsm14724669wrx.27.2024.01.16.06.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 06:58:53 -0800 (PST)
Message-ID: <61115e68-3d63-4e08-85f7-ae6650f3724e@gmail.com>
Date: Tue, 16 Jan 2024 14:58:53 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] ci: add macOS jobs to GitLab CI
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1705318985.git.ps@pks.im>
 <d196cfd9d01fe3b52c75a1e4e0aca9f67567ab43.1705318985.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <d196cfd9d01fe3b52c75a1e4e0aca9f67567ab43.1705318985.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 15/01/2024 11:45, Patrick Steinhardt wrote:
> Add two macOS-based jobs to GitLab CI, one for Clang and one for GCC.

This doesn't match whats in the rest of the commit message where you 
explain why there is no gcc job. The patch itself looks good to me and 
it is nice that we'll now be testing on arm64 with the GitLab runners.

> This matches equivalent jobs we have for GitHub Workflows, except that
> we use macOS 14 instead of macOS 13.
> 
> Note that one test marked as `test_must_fail` is surprisingly passing:
> 
>    t7815-grep-binary.sh                             (Wstat: 0 Tests: 22 Failed: 0)
>      TODO passed:   12
> 
> This seems to boil down to an unexpected difference in how regcomp(1)

nit: regcomp(3)?

Best Wishes

Phillip

> works when matching NUL bytes. Cross-checking with the respective GitHub
> job shows though that this is not an issue unique to the GitLab CI job
> as it passes in the same way there.
> 
> Further note that we do not include the equivalent for the "osx-gcc" job
> that we use with GitHub Workflows. This is because the runner for macOS
> on GitLab is running on Apple M1 machines and thus uses the "arm64"
> architecture. GCC does not support this platform yet.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   .gitlab-ci.yml | 26 +++++++++++++++++++++++++-
>   ci/lib.sh      |  9 ++++++++-
>   2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 793243421c..9748970798 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -7,7 +7,7 @@ workflow:
>       - if: $CI_COMMIT_TAG
>       - if: $CI_COMMIT_REF_PROTECTED == "true"
>   
> -test:
> +test:linux:
>     image: $image
>     before_script:
>       - ./ci/install-docker-dependencies.sh
> @@ -52,6 +52,30 @@ test:
>         - t/failed-test-artifacts
>       when: on_failure
>   
> +test:osx:
> +  image: $image
> +  tags:
> +    - saas-macos-medium-m1
> +  before_script:
> +    - ./ci/install-dependencies.sh
> +  script:
> +    - ./ci/run-build-and-tests.sh
> +  after_script:
> +    - |
> +      if test "$CI_JOB_STATUS" != 'success'
> +      then
> +        ./ci/print-test-failures.sh
> +      fi
> +  parallel:
> +    matrix:
> +      - jobname: osx-clang
> +        image: macos-13-xcode-14
> +        CC: clang
> +  artifacts:
> +    paths:
> +      - t/failed-test-artifacts
> +    when: on_failure
> +
>   static-analysis:
>     image: ubuntu:22.04
>     variables:
> diff --git a/ci/lib.sh b/ci/lib.sh
> index f631206a44..d5dd2f2697 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -252,7 +252,14 @@ then
>   	CI_COMMIT="$CI_COMMIT_SHA"
>   	case "$CI_JOB_IMAGE" in
>   	macos-*)
> -		CI_OS_NAME=osx;;
> +		# GitLab CI has Python installed via multiple package managers,
> +		# most notably via asdf and Homebrew. Ensure that our builds
> +		# pick up the Homebrew one by prepending it to our PATH as the
> +		# asdf one breaks tests.
> +		export PATH="$(brew --prefix)/bin:$PATH"
> +
> +		CI_OS_NAME=osx
> +		;;
>   	alpine:*|fedora:*|ubuntu:*)
>   		CI_OS_NAME=linux;;
>   	*)
