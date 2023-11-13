Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB834224D5
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPG+4prn"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2222D73
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 09:02:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4083740f92dso38009315e9.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 09:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699894941; x=1700499741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U4GrxJXebzyXA5SJRA6AN0gYS4864V86JXhr6aZbdwU=;
        b=mPG+4prnXm7e++96E30AyxMemkgJJff7qr0ByMLBb215NZiELS0DyET4P55m8nXUxE
         7Ce+w26xhWzG3/d24wYDSNigZLLWp6D0VP/d1J5bU23wUAQeUFqI69uLChANcmUc4WD8
         LIMiXGU5FF+Y6UX0uBiNfABhQ8pZoLRKG98UHsyUj47toKzNKacfWEZFuUYPXnxOhZqj
         5rvVeF5K9RrgC2aGZ5H3bwUaddZhe+zNyNbS707OGtoLI6NJhSmJSSlIrKnd68EP2Mx+
         roAn/iuIzof/gHK3cwRNEYSbjh5WPpaaNVDr4zih0DIKOnsweuHQVBtQXDWPxXXehAAh
         2XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699894941; x=1700499741;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4GrxJXebzyXA5SJRA6AN0gYS4864V86JXhr6aZbdwU=;
        b=swK85nA5lTSmvra9/wvaycx9EKffYH1V/Kh9DuRjrv6XNy66sBDAjBb/9TipjfUr8g
         /9Csj0rYu/midI+Wmo1ysQm3y9CWtjdrnfw5jDO4U+C4cuEQqXer7Yg4z+vmVRr7SE/6
         0WqDA6oMXVx4Ktg5qHXmD1TgjvGCNAzo8USDUxT/so6wN3JFg4scOet+2gjnb+20gvqs
         z8xLsmZ1ZauUi9Z5tpkx4RsgO2vUJPFl5Ju2MZiIwViwj303HfcnEnmGv+MrSOhcfx3k
         YjZW3LyNZQfn5y2CsWlLC+lqzryaeOQTpSjSz/SGy6939xK0fRzYIyWH0rvlUltXikjw
         80yg==
X-Gm-Message-State: AOJu0Yz3cQ2sdIf7inzXXQfzFqr6OyTZya69zjZprn3Y77qrci9vE2GN
	crd32x9agF8bHPetzGsc0jng1KyMggs=
X-Google-Smtp-Source: AGHT+IGw1dgYnvLz65SdAamDyU9MSbZEPF3T6wPcoqY4JZHdbsSTKvwjIXRTaTT1nr18ASHmhLV9+Q==
X-Received: by 2002:a05:600c:6022:b0:409:c1e:7fe8 with SMTP id az34-20020a05600c602200b004090c1e7fe8mr5872500wmb.19.1699894940997;
        Mon, 13 Nov 2023 09:02:20 -0800 (PST)
Received: from [192.168.1.101] ([84.64.93.134])
        by smtp.googlemail.com with ESMTPSA id m6-20020a05600c3b0600b004077219aed5sm14543234wms.6.2023.11.13.09.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 09:02:20 -0800 (PST)
Message-ID: <dac6405e-9b8d-40f5-9dda-b248a3548a42@gmail.com>
Date: Mon, 13 Nov 2023 17:02:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/4] rebase: rewrite --(no-)autosquash documentation
Content-Language: en-US
To: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com
References: <20231105000808.10171-1-andy.koppe@gmail.com>
 <20231111132720.78877-1-andy.koppe@gmail.com>
 <20231111132720.78877-6-andy.koppe@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231111132720.78877-6-andy.koppe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy

On 11/11/2023 13:27, Andy Koppe wrote:
> Rewrite the description of the rebase --(no-)autosquash options to try
> to make it a bit clearer. Don't use "the '...'" to refer to part of a
> commit message, mention how --interactive can be used to review the
> todo list, and add a bit more detail on commit --squash/amend.

This version looks good to me, thanks for working on it

Best Wishes

Phillip

> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
>   Documentation/git-rebase.txt | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 10548e715c..1dd6555f66 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -589,21 +589,27 @@ See also INCOMPATIBLE OPTIONS below.
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
> +	previous commits being rebased.  If a commit message starts with
> +	"squash! ", "fixup! " or "amend! ", the remainder of the subject line
> +	is taken as a commit specifier, which matches a previous commit if it
> +	matches the subject line or the hash of that commit.  If no commit
> +	matches fully, matches of the specifier with the start of commit
> +	subjects are considered.
>   +
> -If the `--autosquash` option is enabled by default using the
> -configuration variable `rebase.autoSquash`, this option can be
> -used to override and disable this setting.
> +In the rebase todo list, the actions of squash, fixup and amend commits are
> +changed from `pick` to `squash`, `fixup` or `fixup -C`, respectively, and they
> +are moved right after the commit they modify.  The `--interactive` option can
> +be used to review and edit the todo list before proceeding.
> ++
> +The recommended way to create commits with squash markers is by using the
> +`--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
> +linkgit:git-commit[1], which take the target commit as an argument and
> +automatically fill in the subject line of the new commit from that.
> ++
> +Settting configuration variable `rebase.autoSquash` to true enables
> +auto-squashing by default for interactive rebase.  The `--no-autosquash`
> +option can be used to override that setting.
>   +
>   See also INCOMPATIBLE OPTIONS below.
>   

