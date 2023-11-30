Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iExm/UPc"
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B6383
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 07:42:09 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32faea0fa1fso654496f8f.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 07:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701358928; x=1701963728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l9XqebOMjyLtuOf7vwBmEtTv5F/MOqxBRl+5LNMwvnI=;
        b=iExm/UPctnzEnUEwBeV/c/wUGtFFvdKfoleKYzX5ym+8HRT0+cL42ZjB60Ymwi1ttJ
         Zfy9sseZwubVt+m8yDo9zj8yIWqMMceny+bz1MY7kciSH/c+Biz4dGSSjFQsVXefO3Fd
         yeDVy49cp44Ahg3KhBCs5L5Okr4kgdJtfqDrZl96OvlXust+FSQqOp50NwWe9ocqTCfx
         q7ApYe+8noY9wLfVJyBFUbFwMQyZZtP2GgL/o2d8W5fQU6UsjyqbmBLty3QR74eQtJWn
         46mM3KdGULHLy96QpRhDTuI7TtMufDKpCNfA34M2I75EyopJHrrqP8w4q+o5m9UXBx2L
         FbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701358928; x=1701963728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9XqebOMjyLtuOf7vwBmEtTv5F/MOqxBRl+5LNMwvnI=;
        b=DU28key044qcT2ZIizmR0g30v35qnlPayS7pPUul4kp9fobiGV9fBv5rbjv4i+oU53
         brarYxIy6y2t2aiCq7PX1c1eHf7mYCm7oyQcIxzHpDw813xgnq61tMwj6lYDbzCRYjcq
         ix7AghE0RXw3Y2UzXu5n4Pc0/1ZSRrfyIdhqgk2nxgN5n0pyVtVefSjTZ5Pv6pLpE9jV
         JebNzLWt1Ocobekb/QhcWpQSw/ujykxMaSjyWpfEpTXk1GVZtkmTHtynU/AmkJ2WZAg5
         RpX4pROjJG5Xz1kC7R+0khrPbQm1BC5AiYiH6OG+eWL+jPUKfy7o9Y7X9cn/WYRmMYz0
         4Z9g==
X-Gm-Message-State: AOJu0YyRgj+xW7dGort4S3y9n4I9lvDkW22ln9VXiMPbbbfjOWYibFHw
	K0J12OPE6yyBrCJEWyVs6f0=
X-Google-Smtp-Source: AGHT+IF1ZGlJ/GdxCz5FJ/NnsIIhv+nqYYB28wsh2SMFt/vmRHUPbYQKTwK/bbbbh4a2T3+Tgmh1NQ==
X-Received: by 2002:a5d:4887:0:b0:333:1b9f:dc3c with SMTP id g7-20020a5d4887000000b003331b9fdc3cmr4167306wrq.2.1701358927619;
        Thu, 30 Nov 2023 07:42:07 -0800 (PST)
Received: from [192.168.1.212] ([90.247.162.103])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d6705000000b003316ad360c1sm1828233wru.24.2023.11.30.07.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 07:42:07 -0800 (PST)
Message-ID: <15f67e21-c05f-4a72-9557-2a09a1311f25@gmail.com>
Date: Thu, 30 Nov 2023 15:42:06 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] refs: complete list of special refs
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: hanwenn@gmail.com
References: <cover.1701243201.git.ps@pks.im>
 <0e38103114a206bedbbbd7ea97cb77fa05fd3c29.1701243201.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <0e38103114a206bedbbbd7ea97cb77fa05fd3c29.1701243201.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

Thanks for working on this. I've left a couple of thought below.

On 29/11/2023 08:14, Patrick Steinhardt wrote:
> +static int is_special_ref(const char *refname)
> +{
> +	/*
> +	 * Special references get written and read directly via the filesystem
> +	 * by the subsystems that create them. Thus, they must not go through
> +	 * the reference backend but must instead be read directly. It is
> +	 * arguable whether this behaviour is sensible, or whether it's simply
> +	 * a leaky abstraction enabled by us only having a single reference
> +	 * backend implementation. But at least for a subset of references it
> +	 * indeed does make sense to treat them specially:
> +	 *
> +	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
> +	 *   carries additional metadata like where it came from.
> +	 *
> +	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
> +	 *   heads.
> +	 *
> +	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
> +	 *   rebases, where keeping it closely together feels sensible.

I'd really like to get away from treating these files as refs. I think 
their use as refs is purely historic and predates the reflog and 
possibly ORIG_HEAD. These days I'm not sure there is a good reason to be 
running

     git rev-parse rebase-merge/orig-head

One reason for not wanting to treat them as refs is that we do not 
handle multi-level refs that do not begin with "refs/" consistently.

     git update-ref foo/bar HEAD

succeeds and creates .git/foo/bar but

     git update-ref -d foo/bar

fails with

     error: refusing to update ref with bad name 'foo/bar'

To me it would make sense to refuse to create 'foo/bar' but allow an 
existing ref named 'foo/bar' to be deleted but the current behavior is 
the opposite of that.

I'd be quite happy to see us refuse to treat anything that fails

     if (starts_with(refname, "refs/") || refname_is_safe(refname))

as a ref but I don't know how much pain that would cause.

> +	const char * const special_refs[] = {
> +		"AUTO_MERGE",

Is there any reason to treat this specially in the long term? It points 
to a tree rather than a commit but unlike MERGE_HEAD and FETCH_HEAD it 
is effectively a "normal" ref.

> +		"BISECT_EXPECTED_REV",
> +		"FETCH_HEAD",
> +		"MERGE_AUTOSTASH",

Should we be treating this as a ref? I thought it was written as an 
implementation detail of the autostash implementation rather than to 
provide a ref for users and scripts.

Best Wishes

Phillip
