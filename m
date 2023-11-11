Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280D14AAB
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHzfe892"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23B73868
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:33:59 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40839652b97so21866575e9.3
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699709638; x=1700314438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/A+Bb++H5t9OZIJf2oBfeqKAkKYwP/r21VLJ43pXjRY=;
        b=DHzfe892UTOdQKD1Sepufu2xZkfkrDiwDLOTCBqKn6jLpNHSPzvTsArzMoNUv/MovQ
         qFAWVupwu+8TAKiL4pJV7cPa89ur6+tJRn8R9MEZBjQRa5Bs6OUhGR9hGGYNZ0G0x4T8
         clHKYmPgZgC3/WNEzUTQ+TVdO5Kv78wxcJxRaZiF5Tm1DjL4vAaTSQclG9gtBWMF/qnX
         xZlGDWHcfk5uwx5ultTmnfyYKpzEERK+MfwodTBHGamIRR4+Ffs7GrAvvuXHi+FAfyim
         d5swDt6np3d/3JOyRlxkLwwMYN65+BS6BQ3wq70xnZ/y+eLbQOOlAzyB9e43YbxTu2iN
         iQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699709638; x=1700314438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/A+Bb++H5t9OZIJf2oBfeqKAkKYwP/r21VLJ43pXjRY=;
        b=fJFGJdquEeCUj71gVTqVeoS7FTEiTEbsC6jfZfcxdGX1OxzDq6hnrSWhxJfpqpPYlD
         KRh1qnulUXYbhmGNUie4UviULMYEfTP4xyu/ERdDS17c1hqMDheNzBSvlqv6Xdjzky4F
         a7AEScXwwpC1EIxVsfaxqCGBRlcruVP2mwR9av5F3JCX3ULQ4aFdsve5RsOExmv8iqlT
         /zIDCSmiFiJXGVU9gZbqMK4qkW9ZkPCH80uTdOKY2gOlMtC4iI1DoeMLreqTARJ6WSs0
         AAW2GncyPvhcBM2BY4ZRd7U1K5yPo/v73jYF1Iu/unvup04kFNeFzcQLOmvt/BneRfYc
         nQnQ==
X-Gm-Message-State: AOJu0YwrJs+PG/U5TF5/3Jv9Un765IXqIok7O89X76MSuBufxZIpG7X+
	eI9MtcqvMJa6m8awJxUMHATxTnuD47U4TQ==
X-Google-Smtp-Source: AGHT+IEc8gQhitzd0diPeddEc9F+PSfy7hQCXLXG7YQ3A9wW8/AYL5AdtwKykL3gmjh8Tzf5lJgTzQ==
X-Received: by 2002:a05:600c:524e:b0:406:53aa:7a5f with SMTP id fc14-20020a05600c524e00b0040653aa7a5fmr1776326wmb.10.1699709638254;
        Sat, 11 Nov 2023 05:33:58 -0800 (PST)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id fk11-20020a05600c0ccb00b003feea62440bsm2201059wmb.43.2023.11.11.05.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 05:33:57 -0800 (PST)
Message-ID: <1a05cc48-041a-4c1d-a980-8140d762eade@gmail.com>
Date: Sat, 11 Nov 2023 13:33:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] docs: rewrite rebase --(no-)autosquash description
Content-Language: en-GB
To: git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com
References: <20231105000808.10171-1-andy.koppe@gmail.com>
 <20231111132720.78877-1-andy.koppe@gmail.com>
 <20231111132720.78877-5-andy.koppe@gmail.com>
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <20231111132720.78877-5-andy.koppe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Disregard this one in favour of the other patch 4/4 please:
"[PATCH v4 4/4] rebase: rewrite --(no-)autosquash documentation"

Sorry I failed to notice that I still had this lying around from the 
previous iteration.

On 11/11/2023 13:27, Andy Koppe wrote:
> Rewrite the description of the rebase --(no-)autosquash options to try
> to make it a bit clearer. Don't use "the '...'" to refer to part of a
> commit message, mention how --interactive can be used to review the
> todo list, and add a bit more detail on commit --squash/amend.
> 
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
