Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A67C9454
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuWLVnG3"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881FEB7
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 09:27:49 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c5210a1515so54278501fa.0
        for <git@vger.kernel.org>; Sun, 29 Oct 2023 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698596868; x=1699201668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:reply-to:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrSlmSxqHicy9fc77WFvsEImymx40C5r1ycH4rht5wU=;
        b=SuWLVnG33TatlSyq9wz4FWFha1VwVmjyKChCKmktmr1Re/XL7AjEBQkfUCSipWM3VT
         X4yCxvNod9hoyO4P3RXKquOzVVzPm46q9kDLAXn9xLscyizZKvIlkfEH98k9wS5E9cbJ
         skvz02ii5khRDxDAkIN14ZySlEs7NTyW9kPeXe8Uc984PTn61QrA/ugI1JC2eS0rSqVo
         1JEWUyzAO62e6eZN3xkdxz92NgW8v1xg9hFgnFK8eQ3dd9FvSnNo5VbZCGQS6H51EcBf
         Dv550urvWKfqjLMqCgBI8RMI5yTWb6e5nCuBrD/etGu8yQdJFw+Zl90oZi0C4eRd2iQB
         ZX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698596868; x=1699201668;
        h=content-transfer-encoding:in-reply-to:from:reply-to:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrSlmSxqHicy9fc77WFvsEImymx40C5r1ycH4rht5wU=;
        b=YW1ZtXQMpm2y4SszAoWZdVCF+sCb9EbfyygJYQNt+CfBgaFCxoQnREL0EzQPBWVWp8
         bHsfXSEwxNVNkw41WXdmVTIkB2LEcT3EFnxc1uhpXcoBahUEklUQe+auxeHpTQDgTfnt
         homKSyDpNoBRRZ/yrYWVAr4tCnVk4U8z5s5gfVbiqbNzpRGQJhKptIDmAq1ykPI+3w3l
         6f2d3XePzyB+JIB0RcSKECR1iTN7NpQaAp92+VM243abcXDh6SogWw+w07YHQBHmvp83
         pOX8A8KvY4NhyhuEG/DV9Dot+U/dI6cTJf9SD6iHTb4vrOygw4KidhUohl8jPimIpzpN
         0D6A==
X-Gm-Message-State: AOJu0YxGbYtMOZBvw490bWFSDcb7osvw9EyyGdxCsqZdO3xWQPjWI3O+
	dqMZALJht5NC2SkK55rr/gg=
X-Google-Smtp-Source: AGHT+IEcuDHwr2Xg3gYZ50TdGmrXxQgZZDOCQ9vMq5Q7FBwfvaNZ5rQfGTPQ8sdPnfTKMa0RqTxCqg==
X-Received: by 2002:a2e:9598:0:b0:2c5:1073:5f2 with SMTP id w24-20020a2e9598000000b002c5107305f2mr5597885ljh.5.1698596867466;
        Sun, 29 Oct 2023 09:27:47 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b0040586360a36sm10282299wmr.17.2023.10.29.09.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 09:27:47 -0700 (PDT)
Message-ID: <a165fd76-a44b-45c7-b02c-e9b90fda3db3@gmail.com>
Date: Sun, 29 Oct 2023 16:27:44 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <cover.1698305961.git.ps@pks.im> <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
 <0d889da1-7fd8-4e21-965f-6222e4433ecf@gmail.com> <ZTucxlBR1VrJPuSK@tanuki>
Reply-To: phillip.wood@dunelm.org.uk
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZTucxlBR1VrJPuSK@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 27/10/2023 12:19, Patrick Steinhardt wrote:
> On Fri, Oct 27, 2023 at 11:19:04AM +0100, Phillip Wood wrote:
>> On 27/10/2023 10:25, Patrick Steinhardt wrote:
>>> +  parallel:
>>> +    matrix:
>>> +      - jobname: linux-sha256
>>> +        image: ubuntu:latest
>>> +        CC: clang
>>> +      - jobname: linux-gcc
>>> +        image: ubuntu:20.04
>>> +        CC: gcc
>>> +        CC_PACKAGE: gcc-8
>>> +      - jobname: linux-TEST-vars
>>> +        image: ubuntu:20.04
>>> +        CC: gcc
>>> +        CC_PACKAGE: gcc-8
>>> +      - jobname: linux-gcc-default
>>> +        image: ubuntu:latest
>>> +        CC: gcc
>>> +      - jobname: linux-leaks
>>> +        image: ubuntu:latest
>>> +        CC: gcc
>>> +      - jobname: linux-asan-ubsan
>>> +        image: ubuntu:latest
>>> +        CC: clang
>>> +      - jobname: linux-musl
>>> +        image: alpine:latest

I assume you've chosen the configurations from the existing GitHub 
Actions that give the best coverage of the various options. One thing I 
noticed is that the is no equivalent of the "pedantic" job that builds 
git with "DEVELOPER=1 DEVOPTS=pedantic"

>>> diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
>>> index d0bc19d3bb3..1cd92db1876 100755
>>> --- a/ci/install-docker-dependencies.sh
>>> +++ b/ci/install-docker-dependencies.sh
>>> @@ -16,9 +19,13 @@ linux32)
>>>    	'
>>>    	;;
>>>    linux-musl)
>>> -	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
>>> +	apk add --update git shadow sudo build-base curl-dev openssl-dev expat-dev gettext \
>>>    		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
>>
>> It would be helpful to explain the new dependencies in the commit message. I
>> can see why you're adding sudo, but how were we getting away without
>> installing the other packages for GitHub Actions?
> 
> True, that part is missing.
> 
> - Both sudo and shadow are now required because of `useradd` that we use
>    to set up the unprivileged build.
> 
> - Git has been required all along, I think. `save_good_tree ()` is used
>    in our CI scripts, and Toon (fellow GitLabber from my team) has
>    noticed that the CI job warned about missing Git. The warning was
>    mostly benign as it seems, but still, doesn't hurt to fix it while at
>    it.

Oh I had a look at this and the docker based jobs on GitHub do not have 
a git repository so installing git means we now get a repository not 
found error from save_good_tree() instead. We should probably make 
save_good_tree() and check_unignored_build_artifacts() return early if 
there isn't a repository but that's orthogonal to this series.

Looking at the test output from the link in your cover letter we should 
we should also install apache2[1] and gnupg[2]

[1] https://gitlab.com/gitlab-org/git/-/jobs/5349205374#L1444
[2] https://gitlab.com/gitlab-org/git/-/jobs/5349205374#L1167

Best Wishes

Phillip
