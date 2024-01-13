Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537610797
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8ozlQ+u"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e68ca8b45so16214105e9.0
        for <git@vger.kernel.org>; Sat, 13 Jan 2024 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705173472; x=1705778272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlDvdw/J+DzRwgNg57pc5HPz/cuWvRlIXy4JT0jq/vM=;
        b=F8ozlQ+utmVgBTas0XsTloOZyxK8uMNkw6Zs3lFKL68dloBbkyMunshwRDprG3pouR
         ykjmcHQLKI6Qy1R4pCTIPgs+RLjJWgTinA8v6waJJddIcl6g42G8c+RBoDFnXEaq06RP
         qh0LLPTFbtuIaCA75L8Izkt9Vuz5GhYUioIYP8EelT5+Wet+vrY7bBVvuLVrW90BWAa/
         pqpY3RuHsTG8rs85g+fFs1/hFil5mT2sLjUXjFWUx8l9UDSoS7nVg5PTX8+RSycVi3xH
         6tkkdqU41X0FpnpgrVNeOR4CQjyZ4sGE39vlLarmIF3aULdpZ9qX64THJNSckN+hCm3p
         t2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705173472; x=1705778272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlDvdw/J+DzRwgNg57pc5HPz/cuWvRlIXy4JT0jq/vM=;
        b=N226Zg/YCoVXPnm5lz/5b1wt5bF2lCT6hcL3jkdtg3LD8rDhddJrq+oKB+KwLF7lhY
         ys210YcEGoGEKRi4PDGdp3m4DAUMZbEI0avfcmdrBG9WtmlDLWDtpB52fuw9Ud6SkUWC
         knyOKNUZSZuq/nYKt4nArnJB6+8HBRiK2F73PkeCa/GabRpbywPKl7Ns3zafFOTHBSEf
         ELZMecjg3F2BmLNif6NWU1Tvf4ucxjUgdkQX43RyId2WqPSfFi+hCGAIt9fhknO0EzM5
         Lb1KLR6y9+jJofF06g/JhJA8Qfn7jj7aOBfb72JFFZ9TdkmrLkmvtEct9oXHyazLDzUP
         SlAQ==
X-Gm-Message-State: AOJu0YzqJayhupXG9+twbTUHbwARIZp2AgSuvPx9fEwXV0Ahz2v06mk0
	PQz109U9ZcaU5XoEoUO3PW4=
X-Google-Smtp-Source: AGHT+IF2jMVUUmf7HX8JdI7NIKK0M3QMSiHzXZnkQ9eWHgnFgMd1zvzK+ozvIfcUhhbp8qIqRrKByQ==
X-Received: by 2002:a05:600c:314a:b0:40e:6238:e95d with SMTP id h10-20020a05600c314a00b0040e6238e95dmr2129613wmo.5.1705173471611;
        Sat, 13 Jan 2024 11:17:51 -0800 (PST)
Received: from localhost (84-236-78-166.pool.digikabel.hu. [84.236.78.166])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040d62f89381sm10300359wmn.35.2024.01.13.11.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 11:17:50 -0800 (PST)
Date: Sat, 13 Jan 2024 20:17:49 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Stan Hu <stanhu@gmail.com>
Subject: Re: [PATCH 2/2] completion: silence pseudoref existence check
Message-ID: <20240113191749.GB3000857@szeder.dev>
References: <cover.1704969119.git.ps@pks.im>
 <24563975fca8df6ae73917e9ee3534933d47c429.1704969119.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24563975fca8df6ae73917e9ee3534933d47c429.1704969119.git.ps@pks.im>

On Thu, Jan 11, 2024 at 11:41:59AM +0100, Patrick Steinhardt wrote:
> In 44dbb3bf29 (completion: support pseudoref existence checks for
> reftables, 2023-12-19), we have extended the Bash completion script to
> support future ref backends better by using git-rev-parse(1) to check
> for pseudo-ref existence. This conversion has introduced a bug, because
> even though we pass `--quiet` to git-rev-parse(1) it would still output
> the resolved object ID of the ref in question if it exists.
> 
> Fix this by redirecting its stdout to `/dev/null` and add a test that
> catches this behaviour. Note that the test passes even without the fix
> for the "files" backend because we parse pseudo refs via the filesystem
> directly in that case. But the test will fail with the "reftable"
> backend.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  t/t9902-completion.sh                  | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 8c40ade494..8872192e2b 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -146,7 +146,7 @@ __git_pseudoref_exists ()
>  	if __git_eread "$__git_repo_path/HEAD" head; then
>  		b="${head#ref: }"
>  		if [ "$b" == "refs/heads/.invalid" ]; then

Nit: I guess these last two lines above came from the git prompt
script, where we do need the name of the ref, but here we don't need
that, so the condition could have simply been

  if [ "$head" = "ref: refs/heads/.invalid" ]

With a single = instead of ==, because there is no pattern matching
here.

> -			__git -C "$__git_repo_path" rev-parse --verify --quiet "$ref" 2>/dev/null
> +			__git -C "$__git_repo_path" rev-parse --verify --quiet "$ref" >/dev/null 2>&1

You don't need the '-C $__git_repo_path' option and you don't have to
redirect stderr either, because the purpose of the __git wrapper
function is to take care of both.

>  			return $?
>  		fi
>  	fi
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 78cb93bea7..b14ae4de14 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1927,6 +1927,14 @@ test_expect_success 'git checkout - --orphan with branch already provided comple
>  	EOF
>  '
>  
> +test_expect_success 'git reset completes modified files' '

The description of the test case mentions 'git reset' ...

> +	test_commit A a.file &&
> +	echo B >a.file &&
> +	test_completion "git restore a." <<-\EOF

... but it invokes 'git restore'.

Anyway, I think it would be better to add a dedicated test or two to
exercise the __git_pseudoref_exists helper function instead (or
perhaps in addition).

> +	a.file
> +	EOF
> +'
> +
>  test_expect_success 'teardown after ref completion' '
>  	git branch -d matching-branch &&
>  	git tag -d matching-tag &&
> -- 
> 2.43.GIT
> 


