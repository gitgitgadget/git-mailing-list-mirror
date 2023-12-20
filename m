Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215D3F8D0
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0sq1V67"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c2308faedso67581825e9.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 07:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703085502; x=1703690302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UCQirOzAQPOYpZGevYo1Q0IEt66AMKiSIEPO4UiFSRw=;
        b=I0sq1V67xjKxFU+FzYXJFeRs97PHlARi98UwtkmI9eJ9N2eD+SDFlHYApkRa2KgZmS
         aI1iOfFgNdNyjzWxNF0+btvuu2rQ585+HcvI2CnFTP+9Gsor8Wd2QVLr5+D+uGAgWibo
         YowhvzgCGaQxxX5rauT90+HKAxNgKLRVlmaTZQtcWm22irbgVNEx1m7bw4Ui50lvDco5
         A4FOjeec3HvrcVMYuWbKBDHDPjBCU/RaAX/C23KbZQ9YP/aAvHQLTb8wg/t46f530rrP
         fC9NxeWMCwl787UFcBMlVpX5ELpalie+t1rJjzzsvnNmvaqaj1LMjOjap4MpRPg74xPo
         E5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703085502; x=1703690302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCQirOzAQPOYpZGevYo1Q0IEt66AMKiSIEPO4UiFSRw=;
        b=Ok+Iiy/arCJ3BEH5pUmbU07aEwIvAZ8g0FKtjuzB9BSSaSBD+weVlRQupoZWFYxTKH
         ccfLv5Nx9vyVLgvzG7BKVQTCjjfWuSQHCYVykbQF4sJZCMIcIyc6GWcpQUrsv06Ofp3V
         Vdsdzjrebh0FfEmSuUmOEIzhKoa2w9oUicdocMpuqaGjryUNsZCdILinEayN/VDyJJwQ
         8JkqX5PNil3ECVDZpSWzFJCgO/5t/U2AX1MGnfjVN+1weum3EECCV8ur4rXASdcOTIrN
         NONYjyUTF2D5nqLD9y8x1zkDxQtr+OkTdcd3SOdb96IngvEyPdSTPjCRaQNjkGI5SpS5
         fr1A==
X-Gm-Message-State: AOJu0Ywn9ISljSNVjW8zzf8jofWCgRuYxFpvN1CRb++sAs/y1rKBQw5s
	Ko9CWrt1BGS2DN3orQiRo3BgZqbztxg=
X-Google-Smtp-Source: AGHT+IFe9zoApDAfEQZdiD4WWALjNl8t2Q1LLVuzZCQm3GLcHRUR73Al4rq1RV/6wD+HurHn+MkU+w==
X-Received: by 2002:a05:600c:45d0:b0:40c:4575:2044 with SMTP id s16-20020a05600c45d000b0040c45752044mr10107043wmo.174.1703085501971;
        Wed, 20 Dec 2023 07:18:21 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056000400600b003367ff4aadasm599119wrb.31.2023.12.20.07.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 07:18:21 -0800 (PST)
Message-ID: <35fc350d-018a-49cf-a28e-e5ce21fe7dec@gmail.com>
Date: Wed, 20 Dec 2023 15:18:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/8] SubmittingPatches: update extra tags list
Content-Language: en-US
To: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Josh Soref <jsoref@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <e5c7f29af439c48f59b2f35af93a7972e66a5b6b.1702975320.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <e5c7f29af439c48f59b2f35af93a7972e66a5b6b.1702975320.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh

On 19/12/2023 08:41, Josh Soref via GitGitGadget wrote:
> From: Josh Soref <jsoref@gmail.com>
> 
> Add items with at least 100 uses:
> - Co-authored-by
> - Helped-by
> - Mentored-by
> - Suggested-by

Thanks for adding these, they are widely used and should be documented. 
The patch also adds a mention for "Noticed-by:" - I'm less convinced by 
the need for that as I explain below.

> Updating the create suggestion to something less commonly used.

I'm not quite sure I understand what you mean by this sentence.

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 32e90238777..694a7bafb68 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -348,6 +348,8 @@ If you like, you can put extra tags at the end:
>   
>   . `Reported-by:` is used to credit someone who found the bug that
>     the patch attempts to fix.
> +. `Noticed-by:` liked `Reported-by:` indicates someone who noticed
> +  the item being fixed.

I wonder if we really need a separate "Noticed-by" footer in addition to 
"Reported-by". Personally I use the latter to acknowledge the person who 
reported the issue being fix regards of weather I'm fixing a bug or some 
other issue.

>   . `Acked-by:` says that the person who is more familiar with the area
>     the patch attempts to modify liked the patch.
>   . `Reviewed-by:`, unlike the other tags, can only be offered by the
> @@ -355,9 +357,17 @@ If you like, you can put extra tags at the end:
>     patch after a detailed analysis.
>   . `Tested-by:` is used to indicate that the person applied the patch
>     and found it to have the desired effect.
> +. `Co-authored-by:` is used to indicate that multiple people
> +  contributed to the work of a patch.

Junio's comments in [1] may be helpful here

     If co-authors closely worked together (possibly but not necessarily
     outside the public view), exchanging drafts and agreeing on the
     final version before sending it to the list, by one approving the
     other's final draft, Co-authored-by may be appropriate.

     I would prefer to see more use of Helped-by when suggestions for
     improvements were made, possibly but not necessarily in a concrete
     "squashable patch" form, the original author accepted before
     sending the new version out, and the party who made suggestions saw
     the updated version at the same time as the general public.

So I think we should be clear that "Co-authored-by:" means that multiple 
authors worked closely together on the patch, rather than just 
contributed to it.

[1] https://lore.kernel.org/git/xmqqmth8wwcf.fsf@gitster.g/

> +. `Helped-by:` is used to credit someone with helping develop a
> +  patch.
> +. `Mentored-by:` is used to credit someone with helping develop a
> +  patch.

I think we use "Montored-by:" specifically to credit the mentor on 
patches written by GSoC or Outreachy interns and "Helped-by:" for the 
general case of someone helping the patch author.

> +. `Suggested-by:` is used to credit someone with suggesting the idea
> +  for a patch.
>   
>   You can also create your own tag or use one that's in common usage
> -such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
> +such as "Thanks-to:", "Based-on-patch-by:", or "Improved-by:".

What's the difference between "Improved-by:" and "Helped-by:"? In 
general I'd prefer for us not to encourage new trailers where we already 
have a suitable one in use.

Thanks for working on this, it will be good to have better descriptions 
of our common trailers.

Best Wishes

Phillip
