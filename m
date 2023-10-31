Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5B1CF83
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ManyKICS"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4D2DB
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 04:43:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083f61322fso43216335e9.1
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 04:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698752600; x=1699357400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iFBdgPxJICQ7bFl8mDeu+6I05TisNCv/JZ/9oX07QyM=;
        b=ManyKICSyTq6/M+4m1il4mSfa+RUcoASaV1CFEqPYhkl9BROWTfrAUFiERFTXqj/94
         Ck39c+ZHlaQT/5koD+2OIA7RDEvwfzNp8aC5wO8/vLFDbyPq0UgRfrZRxbULQPfz01UT
         OysGZ3jypK+tXNmyGM7/Niso4KTjAJfaYbz7dpy4EbNuup/lo35eRxpw0Qcmr04ntQ1s
         7JYhgUsWF+9toNViALX3v2J0TZvKHIiI5f66clLGnXfkRiLdWBEzO6F+HW4PY1i7ot/h
         cb7/6PAYTxlfdPFYxJRZs+M3/7EQtzcF8GTxU+OJKfDi4ZaPKYAWwCwCzFfaGNMnMyyD
         PnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698752600; x=1699357400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFBdgPxJICQ7bFl8mDeu+6I05TisNCv/JZ/9oX07QyM=;
        b=xD9OTEXvW2+EB8u448vfaFjl37fKUescR0g3d60y63pwMdiOo3xQDDQ+CCkr/m3yOY
         SXtU7bjJ+ZFRcbY9l0tQwmvUwtJuTFgHk2wFZvGXAG+iJpoHrk6QufFVzJxOuP4ojYCn
         rCo4vRRHo5MY+2dDZHcD1aLkrVKTwGNT7SKMHf85Zk6I4O0gkA0yW5XkQ2Ufj2KAbcFI
         asJK7DMR44jPh6qd4zIlcEo6qKgg2fRpHOPWeCYki+mWdhZW1jaUIUrn2OqHZjGMbKVf
         fq3tKt15NtpFRW/t6rYrRnD8q/H92eD0YhkizVvaqHeDJEwXhK9tUgBEhKvlhFp1cdpW
         UOYA==
X-Gm-Message-State: AOJu0YwNCJTVm4FaaVkac+u7DrhJ49qzHyLQURRFev9MZb6xxPS6P25R
	RwjzdA0qhndi+l2zm8sok0s=
X-Google-Smtp-Source: AGHT+IGIh57eit39HSuG5qGQghDEt87A17xMK8uz59FeGolha2R3+IaLlVPg3/VVP8AHw9fW69TBnQ==
X-Received: by 2002:a05:600c:190b:b0:401:b53e:6c3b with SMTP id j11-20020a05600c190b00b00401b53e6c3bmr10170664wmq.6.1698752600317;
        Tue, 31 Oct 2023 04:43:20 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id j20-20020a05600c485400b004063cd8105csm1520413wmo.22.2023.10.31.04.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 04:43:20 -0700 (PDT)
Message-ID: <e37d2943-3cb3-4cf9-9f69-26fb42bf1027@gmail.com>
Date: Tue, 31 Oct 2023 11:43:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] sequencer: remove use of comment character
Content-Language: en-US
To: Tony Tung via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Tony Tung <tonytung@merly.org>
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
 <pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
 <10598a56d64f5c2b4d8d05d7e7b09a18ef254f88.1698728953.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <10598a56d64f5c2b4d8d05d7e7b09a18ef254f88.1698728953.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tony

On 31/10/2023 05:09, Tony Tung via GitGitGadget wrote:
> From: Tony Tung <tonytung@merly.org>
> 
> Instead of using the hardcoded `# `, use the
> user-defined comment_line_char.  Adds a test
> to prevent regressions.

Well spotted and thanks for fixing this. Normally we wrap the commit 
message at ~72 chars.

> Signed-off-by: Tony Tung <tonytung@merly.org>
> ---
>   sequencer.c                   |  5 +++--
>   t/t3404-rebase-interactive.sh | 39 +++++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index d584cac8ed9..8c6666d5e43 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6082,8 +6082,9 @@ static int add_decorations_to_list(const struct commit *commit,
>   		/* If the branch is checked out, then leave a comment instead. */
>   		if ((path = branch_checked_out(decoration->name))) {
>   			item->command = TODO_COMMENT;
> -			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
> -				    decoration->name, path);
> +			strbuf_commented_addf(ctx->buf, comment_line_char,
> +					      "Ref %s checked out at '%s'\n",
> +					      decoration->name, path);
>   		} else {
>   			struct string_list_item *sti;
>   			item->command = TODO_UPDATE_REF;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8ea2bf13026..076dca87871 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1839,6 +1839,45 @@ test_expect_success '--update-refs adds label and update-ref commands' '
>   	)
>   '

Thank you for taking the time to add a test. I think it could be 
simplified though as all we really need to do is check that the expected 
comment is present in the todo list. Something like (untested)

test_expect_success '--update-refs works with core.commentChar' '
	git worktree add new-branch &&
	test_when_finished "git worktree remove new-branch" &&
	test_config core.commentchar : &&
	write_script fake-editor.sh <<-\EOF &&
	grep "^: Ref refs/heads/new-branch checked out at .*new-branch" "$1" &&
	# no need to rebase
	>"$1"
	EOF
	(
		test_set_editor "$(pwd)/fake-editor.sh" &&
		git rebase -i --update-refs HEAD^
	)
'

Best Wishes

Phillip

> +test_expect_success '--update-refs works with core.commentChar' '
> +	git checkout -b update-refs-with-commentchar no-conflict-branch &&
> +	test_config core.commentChar : &&
> +	git branch -f base HEAD~4 &&
> +	git branch -f first HEAD~3 &&
> +	git branch -f second HEAD~3 &&
> +	git branch -f third HEAD~1 &&
> +	git commit --allow-empty --fixup=third &&
> +	git branch -f is-not-reordered &&
> +	git commit --allow-empty --fixup=HEAD~4 &&
> +	git branch -f shared-tip &&
> +	git checkout update-refs &&
> +	(
> +		write_script fake-editor.sh <<-\EOF &&
> +		grep "^[^:]" "$1"
> +		exit 1
> +		EOF
> +		test_set_editor "$(pwd)/fake-editor.sh" &&
> +
> +		cat >expect <<-EOF &&
> +		pick $(git log -1 --format=%h J) J
> +		fixup $(git log -1 --format=%h update-refs) fixup! J : empty
> +		update-ref refs/heads/second
> +		update-ref refs/heads/first
> +		pick $(git log -1 --format=%h K) K
> +		pick $(git log -1 --format=%h L) L
> +		fixup $(git log -1 --format=%h is-not-reordered) fixup! L : empty
> +		update-ref refs/heads/third
> +		pick $(git log -1 --format=%h M) M
> +		update-ref refs/heads/no-conflict-branch
> +		update-ref refs/heads/is-not-reordered
> +		update-ref refs/heads/update-refs-with-commentchar
> +		EOF
> +
> +		test_must_fail git rebase -i --autosquash --update-refs primary shared-tip >todo &&
> +		test_cmp expect todo
> +	)
> +'
> +
>   test_expect_success '--update-refs adds commands with --rebase-merges' '
>   	git checkout -b update-refs-with-merge no-conflict-branch &&
>   	git branch -f base HEAD~4 &&

