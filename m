Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1D134D9
	for <git@vger.kernel.org>; Sat, 16 Dec 2023 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7/Frv3d"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c317723a8so17512015e9.3
        for <git@vger.kernel.org>; Sat, 16 Dec 2023 03:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702724679; x=1703329479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjbM7eAi9FbXkhbVrWQGEn08vnrqstrY4BM+Kp0FAV4=;
        b=N7/Frv3dvgSiYCrH9laapCl+bFikYXMkhpdGjlL/SBS3qwVubPho/jkBX7sfq0a045
         WZArILwWqb9Q4DQetFW3TXmSzCo12c3iJ2vP7NlMLAh/iAH8jLbLNKTELRN0NDlmf8Jd
         Xue5CT6fTDIqZgSR9QSbPViJ9TunPRUTx0g8C57jKWIhAeQky5xeWo24JOm996lDsTJl
         5kxNiH741MwN4DUgX6LCTy40WoU6YsBOghh6nJ+NYGjKzTbtAApGisg8aITZCBXwJk06
         0hVDr7duuNoQ5FLFkKWRq+oGgs99zC1rJU/Il0U1PjDC81d6I5duF9Z2dwsiW8FUI33F
         G4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702724679; x=1703329479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjbM7eAi9FbXkhbVrWQGEn08vnrqstrY4BM+Kp0FAV4=;
        b=JOocjS3ALN+jRpGPZZs70MjEnew8fzlxuUmPLboxqBX3pi2kZUGcjKbaE3l5/PxNGs
         S3O8MNiZmoBs26hJ7IxLx5FKFLiY8SnSfHg6pJpgQQeBNczUiTIPgH2o59AuttD6QNWw
         EX5P4pmQQ6tawSlg3vL/lqeeVowRQeaVzjWMP0kVd8+RUz+rISJgALrpYbg65TlcqRUh
         G4vpTHeni//f77mA32HjCRyWyj0TaxT/Z/Az8bGWr20TOGuF8oNPTd/6uzcnh37CiLFi
         RGdH2acR/Zt6UGTWW3do5X5sldfe7AEVkM0RtT9ZaGs0rryThp744oCNpaQz1/XkJVEP
         uIHA==
X-Gm-Message-State: AOJu0YwiyECuvxraIkPp3ksS6NEzmZG/go3mgE+yyJ/NVSSu4/LdmjZD
	QGyQRc/1h/x8x4FqgnEbuc4=
X-Google-Smtp-Source: AGHT+IHqxjpnFyg60aStKGcSp+BWAOmm+oCkIm78R+BmDFSkUOeOpWJ1y5FmBT6nGqWCQyd1ZuzDhg==
X-Received: by 2002:a05:600c:1895:b0:40c:3379:ab5e with SMTP id x21-20020a05600c189500b0040c3379ab5emr7174450wmp.0.1702724678576;
        Sat, 16 Dec 2023 03:04:38 -0800 (PST)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b0040b3e26872dsm35427940wms.8.2023.12.16.03.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 03:04:38 -0800 (PST)
Message-ID: <f03779fa-ddf1-4a3f-b140-55f8bcaeca56@gmail.com>
Date: Sat, 16 Dec 2023 11:04:36 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] docs: MERGE_AUTOSTASH is not that special
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20231215203245.3622299-1-gitster@pobox.com>
 <20231215203245.3622299-6-gitster@pobox.com>
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <20231215203245.3622299-6-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2023 20:32, Junio C Hamano wrote:
> A handful of manual pages called MERGE_AUTOSTASH a "special ref",
> but there is nothing special about it.  It merely is yet another
> pseudoref.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   Documentation/merge-options.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index d8f7cd7ca0..3eaefc4e94 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -191,7 +191,7 @@ endif::git-pull[]
>   --autostash::
>   --no-autostash::
>   	Automatically create a temporary stash entry before the operation
> -	begins, record it in the special ref `MERGE_AUTOSTASH`
> +	begins, record it in the ref `MERGE_AUTOSTASH`
>   	and apply it after the operation ends.  This means
>   	that you can run the operation on a dirty worktree.  However, use
>   	with care: the final stash application after a successful

Should that say 'pseudoref' instead of 'ref'?

And since MERGE_AUTOSTASH is documented here, it probably should be in 
gitrevisions as well.

Regards,
Andy
