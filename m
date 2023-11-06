Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532BD1A58A
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqS0yLC2"
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37D134
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 03:07:18 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c5720a321aso57561421fa.1
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 03:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699268836; x=1699873636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DMppQbsl+n4exxLUV8K6SdfOslFjSzvn1xLFS4DPSZc=;
        b=XqS0yLC2SEgs6tpNGtRV0dZLFSYre4ya7/t53KGrKxDdJKmMz3YhGOjTIh9IigGAyI
         0jE0d5rPY/FkhFRfhE2R3MnMNYN2k7KnIoR+e7dpTBZIRilv/3RfnV8eCg0x+lWPsrqG
         pgRWoCIDK+EZBQr5en43edturZbw8VvD50VUdEXoE2yS2QB4DZHMBAi6//qxpvFMOKTt
         YmU68p0wMdg1xcq0RhrDYUxK7VgmZM+//dtUK/2UzdFmEqhhc0a7Vm5N10R2T+Fk6MCy
         o42V1deNQTQd2fhbl16UZZi7dDzO8pEYORZZV4JPe7qSSkmYAHkjtREGt1Ve98seK32F
         SqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699268836; x=1699873636;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMppQbsl+n4exxLUV8K6SdfOslFjSzvn1xLFS4DPSZc=;
        b=E3KV9fD+UJFuQ3cuxGz6/uoppB7FlPXJ8KsD/rccJqnD7ksdJDU+rkPXdck5sXhoAx
         JTvz7GCENbgQ9IqB06FyBWjMDeYb/upD77xlczRi8Tsks670ZJz+gF5o027ll4YW11Ji
         6u8UoO09l5TC02NZ+7x/BhzTqcIEqfka/Ht/r+Pq30KTVZtkvjvFl8Wqxr+zC8XOFy6E
         0tzGBPz8kDe/G489IJrD3DHdeNbPZiNkSfCNehHvyVIQk8+y71NQaBVOhlLiWC5u7uu9
         DBODPGg394M/Ctx8LNQyZnNoLAY0w58151uWFhkubJdi/gcpj+mCe+knD/PeHqRSO2dJ
         veXA==
X-Gm-Message-State: AOJu0YwYIobixDQtzOnbPZkIOYnEEhi96+/R0keJ5Ky9PNelJkFO926m
	1UjVRRoKxwpUyomXLjFHefKyBNE1WCE=
X-Google-Smtp-Source: AGHT+IF4qStp47H4SMgIhKJLv7FvMXYKDXL3ynsA9qvwLSI8dq0h/ILhPs+mIXBfAViU3iFB5RNx7g==
X-Received: by 2002:a05:651c:1305:b0:2c5:2132:24f6 with SMTP id u5-20020a05651c130500b002c5213224f6mr22073266lja.12.1699268836447;
        Mon, 06 Nov 2023 03:07:16 -0800 (PST)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id n5-20020a05600c3b8500b004064e3b94afsm12051132wms.4.2023.11.06.03.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 03:07:16 -0800 (PST)
Message-ID: <a4679ee0-b36f-441f-9350-b4c9c02f6e2d@gmail.com>
Date: Mon, 6 Nov 2023 11:07:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/2] docs: rewrite rebase --(no-)autosquash description
Reply-To: phillip.wood@dunelm.org.uk
To: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com
References: <20231104220330.14577-1-andy.koppe@gmail.com>
 <20231105000808.10171-1-andy.koppe@gmail.com>
 <20231105000808.10171-2-andy.koppe@gmail.com>
Content-Language: en-US
In-Reply-To: <20231105000808.10171-2-andy.koppe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy

On 05/11/2023 00:08, Andy Koppe wrote:
> Rewrite the description of the rebase --(no-)autosquash options to try
> to make it a bit clearer. Don't use "the '...'" to refer to part of a
> commit message,

Thanks for doing that, it is a definite improvement, I'm a bit concerned 
about the loss of detail in other areas though - see below.

> mention how --interactive can be used to review the
> todo list, and add a bit more detail on commit --squash/amend.
> 
> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
>   Documentation/git-rebase.txt | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 102ff91493..594158fcbc 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -589,21 +589,25 @@ See also INCOMPATIBLE OPTIONS below.
>   
>   --autosquash::
>   --no-autosquash::
> -	When the commit log message begins with "squash! ..." or "fixup! ..."
> -	or "amend! ...", and there is already a commit in the todo list that
> -	matches the same `...`, automatically modify the todo list of
> -	`rebase`, so that the commit marked for squashing comes right after
> -	the commit to be modified, and change the action of the moved commit
> -	from `pick` to `squash` or `fixup` or `fixup -C` respectively. A commit
> -	matches the `...` if the commit subject matches, or if the `...` refers
> -	to the commit's hash. As a fall-back, partial matches of the commit
> -	subject work, too. The recommended way to create fixup/amend/squash
> -	commits is by using the `--fixup`, `--fixup=amend:` or `--fixup=reword:`
> -	and `--squash` options respectively of linkgit:git-commit[1].
> +	Automatically squash commits with specially formatted messages into
> +	previous commits.  If a commit message starts with "squash! ",
> +	"fixup! " or "amend! ", the remainder of the subject line is taken
> +	as a commit specifier,

I like this change as I think saying "remainder of the subject line" is 
clearer than using `...`

> which matches a previous commit if it matches
> +	the start of the subject line or the hash of that commit.

This simplification glosses over some details, in particular it is no 
longer clear we prefer an exact subject match to a prefix match so that

	pick 123 foo
	pick 456 foo bar
	pick 789 fixup! foo

will be re-arranged to
	
	pick 123 foo
	fixup 789 fixup! foo
	pick 456 foo bar

and not

	pick 123 foo
	pick 456 foo bar
	fixup 789 fixup! foo

>   +
> -If the `--autosquash` option is enabled by default using the
> -configuration variable `rebase.autoSquash`, this option can be
> -used to override and disable this setting.
> +In the rebase todo list, commits marked for squashing are moved right after
> +the commits they modify, and their action is changed from `pick` to `squash`,
> +`fixup` or `fixup -C`, depending on the squash marker.

Here we have lost the documentation that told users which marker 
corresponds to which action which is unfortunate.

Best Wishes

Phillip

>  The `--interactive`
> +option can be used to review and edit the todo list before proceeding.
> ++
> +The recommended way to create commits with squash markers is by using the
> +`--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
> +linkgit:git-commit[1], which take the target commit as an argument and
> +automatically fill in the subject line of the new commit from that.
> ++
> +The configuration variable `rebase.autoSquash` can be used to enable
> +`--autosquash` by default.  See the CONFIGURATION section below for details.
> +The `--no-autosquash` option overrides that setting.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   
