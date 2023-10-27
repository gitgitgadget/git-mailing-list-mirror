Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18961799B
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfF0AJDv"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666F1AC
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 03:19:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so15456645e9.3
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698401945; x=1699006745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:reply-to:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGUCDnYcF2cZWFio1qBCStIBp7fq+U1WvaWvQXpf+RM=;
        b=UfF0AJDv5byxPjvYbjIvMmmWyx2vQGpFSowtEmQ7bvaZmH5R3dx9x0ESCKfuhTMUBw
         TRC9MG+X4iPf6mHkE+IKU0Ye2CTtGyG8U+SLn9kd6M/GPrRkdrjqDDTLgoPPEXMeWTJC
         34CFivXJehUICCiOWJIe3yTI7mvYVpn7D43PUoyD6VXwx6lpmRVk2LKa7m+hvJcW5t02
         7ARlpFJ4nCzt0m0XF9jxgY/cFsBiVxfbQPqr6aR0zZYLC59/JEcjXkKCyB3l9ogBjVBw
         L9zzVxchpBPT+reOMnrPLRVW9rRCet2GzYRubA1TiwSSsJ5RKHqu+nGdgySzhjaxoQAC
         dG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401945; x=1699006745;
        h=content-transfer-encoding:in-reply-to:from:reply-to:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGUCDnYcF2cZWFio1qBCStIBp7fq+U1WvaWvQXpf+RM=;
        b=pbcfeUoaBiSYN72QsYR7owsUxQUods5cDsJ2Hw4VtBeJX4ZanOgXruHAzDjCpn+eEa
         c1kZza1qrzsyqHzuyFlGKGWCh38RpoxJqDqi6dEabTpzdmaM+4sbHmFsC27ecOtHcZqm
         Q+8nSNPPyim2GCAtZB6MNM3k86xmQQMwr+t+0M5wVVl25TaZUNrfC8BVSC45QcinVyAS
         6VpKN6ws+4NRep32+eKiw/xrEmtUSojr4/yIH7AmLI0GtRHSEpDds/td216dMK4PJMdJ
         y5c9+3rLYJtrdMOjClGnggOI3equ9BALHcyerOZA70woJlwhZC2s6wzYECEfACYcgTJL
         lzwA==
X-Gm-Message-State: AOJu0YzMwRaMvuCY076XrcNJkrARkZJA0rvDAsbUUw1usfp7rwUVVaoe
	A3YSnlSfirZCdshdOMkTtrY=
X-Google-Smtp-Source: AGHT+IGUYENmaJqAu5tltnrqF1KXNlvvGrXNa9IlFdpEZBbxqBq5OOjzK5yKbbd5P0Xj4QQySFwvCA==
X-Received: by 2002:a05:600c:1c04:b0:407:5b7c:2f6a with SMTP id j4-20020a05600c1c0400b004075b7c2f6amr1931332wms.0.1698401944923;
        Fri, 27 Oct 2023 03:19:04 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id u14-20020a05600c4d0e00b003fef5e76f2csm1034536wmp.0.2023.10.27.03.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 03:19:04 -0700 (PDT)
Message-ID: <0d889da1-7fd8-4e21-965f-6222e4433ecf@gmail.com>
Date: Fri, 27 Oct 2023 11:19:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <cover.1698305961.git.ps@pks.im> <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
Reply-To: phillip.wood@dunelm.org.uk
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2023 10:25, Patrick Steinhardt wrote:
> We already support Azure Pipelines and GitHub Workflows in the Git
> project, but until now we do not have support for GitLab CI. While it is
> arguably not in the interest of the Git project to maintain a ton of
> different CI platforms, GitLab has recently ramped up its efforts and
> tries to contribute to the Git project more regularly.

I agree we don't want to support too many CI platforms but I think 
adding support for GitLab is good as it helps to stop us being too tied 
to GitHub Actions (which should make it easier if we ever need to 
transition to a different platform in the future) and provides an 
alternative for contributors who want to use a different platform.

> Part of a problem we hit at GitLab rather frequently is that our own,
> custom CI setup we have is so different to the setup that the Git
> project has. More esoteric jobs like "linux-TEST-vars" that also set a
> couple of environment variables do not exist in GitLab's custom CI
> setup, and maintaining them to keep up with what Git does feels like
> wasted time. The result is that we regularly send patch series upstream
> that fail to compile or pass tests in GitHub Workflows. We would thus
> like to integrate the GitLab CI configuration into the Git project to
> help us send better patch series upstream and thus reduce overhead for
> the maintainer.
> 
> The integration does not necessarily have to be a first-class citizen,
> which would in practice only add to the fallout that pipeline failures
> have for the maintainer. That being said, we are happy to maintain this
> alternative CI setup for the Git project and will make test results
> available as part of our own mirror of the Git project at [1].

Having someone committed to on-going maintenance is great.

> This commit introduces the integration into our regular CI scripts so
> that most of the setup continues to be shared across all of the CI
> solutions.
> 
> [1]: https://gitlab.com/gitlab-org/git
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   .gitlab-ci.yml                    | 51 +++++++++++++++++++++++++++++++
>   ci/install-docker-dependencies.sh |  9 +++++-
>   ci/lib.sh                         | 49 +++++++++++++++++++++++++++++
>   ci/print-test-failures.sh         |  6 ++++
>   4 files changed, 114 insertions(+), 1 deletion(-)
>   create mode 100644 .gitlab-ci.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> new file mode 100644
> index 00000000000..43d3a961fa0
> --- /dev/null
> +++ b/.gitlab-ci.yml
> @@ -0,0 +1,51 @@
> +default:
> +  timeout: 2h
> +
> +workflow:
> +  rules:
> +    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
> +    - if: $CI_COMMIT_TAG
> +    - if: $CI_COMMIT_REF_PROTECTED == "true"
> +
> +test:
> +  image: $image
> +  before_script:
> +    - ./ci/install-docker-dependencies.sh
> +  script:
> +    - useradd builder --home-dir "${CI_PROJECT_DIR}"
> +    - chown -R builder "${CI_PROJECT_DIR}"
> +    - sudo --preserve-env --set-home --user=builder ./ci/run-build-and-tests.sh

It's really good that you're running the tests as an unprivileged user. 
This is something we used to do when we were using Travis that got lost 
in the transition to Azure Pipelines which means some tests that rely on 
httpd are now skipped as they refuse to run as root. 
ci/run-docker-build.sh is currently bit-rotting, I wonder if it is 
possible to update it so that we can run the dockerized tests in the 
same way on all CI platforms.

> +  after_script:
> +    - |
> +      if test "$CI_JOB_STATUS" != 'success'
> +      then
> +        sudo --preserve-env --set-home --user=builder ./ci/print-test-failures.sh
> +      fi
> +  parallel:
> +    matrix:
> +      - jobname: linux-sha256
> +        image: ubuntu:latest
> +        CC: clang
> +      - jobname: linux-gcc
> +        image: ubuntu:20.04
> +        CC: gcc
> +        CC_PACKAGE: gcc-8
> +      - jobname: linux-TEST-vars
> +        image: ubuntu:20.04
> +        CC: gcc
> +        CC_PACKAGE: gcc-8
> +      - jobname: linux-gcc-default
> +        image: ubuntu:latest
> +        CC: gcc
> +      - jobname: linux-leaks
> +        image: ubuntu:latest
> +        CC: gcc
> +      - jobname: linux-asan-ubsan
> +        image: ubuntu:latest
> +        CC: clang
> +      - jobname: linux-musl
> +        image: alpine:latest
> +  artifacts:
> +    paths:
> +      - t/failed-test-artifacts
> +    when: on_failure

This file is pleasingly small.

> diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
> index d0bc19d3bb3..1cd92db1876 100755
> --- a/ci/install-docker-dependencies.sh
> +++ b/ci/install-docker-dependencies.sh
> @@ -7,6 +7,9 @@
>   
>   begin_group "Install dependencies"
>   
> +# Required so that apt doesn't wait for user input on certain packages.
> +export DEBIAN_FRONTEND=noninteractive
> +
>   case "$jobname" in
>   linux32)
>   	linux32 --32bit i386 sh -c '
> @@ -16,9 +19,13 @@ linux32)
>   	'
>   	;;
>   linux-musl)
> -	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
> +	apk add --update git shadow sudo build-base curl-dev openssl-dev expat-dev gettext \
>   		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null

It would be helpful to explain the new dependencies in the commit 
message. I can see why you're adding sudo, but how were we getting away 
without installing the other packages for GitHub Actions?

>   	;;
> +linux-*)
> +	apt update -q &&
> +	apt install -q -y sudo git make language-pack-is libsvn-perl apache2 libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl ${CC_PACKAGE:-${CC:-gcc}}
> +	;;
>   pedantic)
>   	dnf -yq update >/dev/null &&
>   	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 9ffdf743903..f518df7e2cb 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -14,6 +14,22 @@ then
>   		need_to_end_group=
>   		echo '::endgroup::' >&2
>   	}
> +elif test true = "$GITLAB_CI"
> +then
> +	begin_group () {
> +		need_to_end_group=t
> +		echo -e "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K$1"
> +		trap "end_group '$1'" EXIT
> +		set -x
> +	}
> +
> +	end_group () {
> +		test -n "$need_to_end_group" || return 0
> +		set +x
> +		need_to_end_group=
> +		echo -e "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K"
> +		trap - EXIT
> +	}
>   else
>   	begin_group () { :; }
>   	end_group () { :; }
> @@ -203,6 +219,39 @@ then
>   	MAKEFLAGS="$MAKEFLAGS --jobs=10"
>   	test windows != "$CI_OS_NAME" ||
>   	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> +elif test true = "$GITLAB_CI"
> +then
> +	CI_TYPE=gitlab-ci
> +	CI_BRANCH="$CI_COMMIT_REF_NAME"
> +	CI_COMMIT="$CI_COMMIT_SHA"
> +	case "$CI_JOB_IMAGE" in
> +	macos-*)
> +		CI_OS_NAME=osx;;
> +	alpine:*|ubuntu:*)
> +		CI_OS_NAME=linux;;
> +	*)
> +		echo "Could not identify OS image" >&2
> +		env >&2
> +		exit 1
> +		;;
> +	esac
> +	CI_REPO_SLUG="$CI_PROJECT_PATH"
> +	CI_JOB_ID="$CI_JOB_ID"

I guess making this explicit is helpful, otherwise someone may wonder 
why CI_JOB_ID is not being set.

> +	CC="${CC_PACKAGE:-${CC:-gcc}}"
> +	DONT_SKIP_TAGS=t
> +	handle_failed_tests () {
> +		create_failed_test_artifacts
> +	}
> +
> +	cache_dir="$HOME/none"
> +
> +	runs_on_pool=$(echo "$CI_JOB_IMAGE" | tr : -)
> +
> +	export GIT_PROVE_OPTS="--timer --jobs $(nproc)"
> +	export GIT_TEST_OPTS="--verbose-log -x"
> +	MAKEFLAGS="$MAKEFLAGS --jobs=$(nproc)"
> +	test windows != "$CI_OS_NAME" ||
> +	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"

This last paragraph feels like it should be common to all the CI 
providers. There are some small differences but if we're going to 
support several providers it would be nice to set the common options 
centrally. I'm pretty sure the --jobs=10 we use for the GitHub and Azure 
is not optimal, using $(nproc) is nice so long as it is supported on all 
the images we use.

I had a quick glance through the previous patches and they all look like 
nice cleanups that make our ci support less dependent on a single 
provider. This series looks like a nice addition to our CI support.

Best Wishes

Phillip

>   else
>   	echo "Could not identify CI type" >&2
>   	env >&2
> diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
> index 57277eefcd0..c33ad4e3a22 100755
> --- a/ci/print-test-failures.sh
> +++ b/ci/print-test-failures.sh
> @@ -51,6 +51,12 @@ do
>   			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
>   			continue
>   			;;
> +		gitlab-ci)
> +			mkdir -p failed-test-artifacts
> +			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
> +			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
> +			continue
> +			;;
>   		*)
>   			echo "Unhandled CI type: $CI_TYPE" >&2
>   			exit 1

