Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWIsWPFB"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA351B6
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 14:03:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083f613272so8996005e9.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 14:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700777024; x=1701381824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnegWnfp4kNP1SrQjqa6VTkUCT/SIEdgWzbFjCbh6Sw=;
        b=nWIsWPFBgD18hJ1SJRvrIIcnSGmCVXbBMfC0SEHVBqCoPbktvdSXvj6ILnxZPOI9EF
         rdLpedLdLvoj5IEkQZSBNUf3x+3kDcy+whhx5Hzry9Whmx+byxHk7l6YC9PZYjoPBqAD
         LNBBKAxzlQsHeWHIdTJtDlyTWPe5iyJ+Ymkaa7HdXGMGGyz9BdYUkTU0t26qKs/rwaHw
         DNo8hhzMnXCgk01IGPCXkLvKZyWmJTkAOqF+BOn/TTgFXjWYDQrdpVWOdUZGFaNN0/9a
         k0VvibJ9Y8UooRRxqE1ZzIGNAqSblAtVgOiW1q/++5F3WqXwJw1SqOmMEzKTMFQ5rV0S
         +sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700777024; x=1701381824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnegWnfp4kNP1SrQjqa6VTkUCT/SIEdgWzbFjCbh6Sw=;
        b=C8kKdanvkeHGPVpt/60JAZktC0YIXJ/lZE6NqIcwIgR4kwKMCcFNhn3OiaShv7Fy5d
         tnFJDkH7EN22AVwMRaPtVdolR+hw+vyhl2HI0kG0+3lKHF8enJ8P/IEUDpHaXohVm8JN
         YgCj1BrSWKrlyByNVr89BhZ10uJgcP0yCQISyhP+xLRZNOH1ZcJX2ZgOAC8BZwiSDs/k
         ZNgFyv+p1oyTeFganL62zrsSBn9EfaLn5YmOUn17cgMYBUxdGONhTGRZMKfhagDHRc7A
         9gIL1qn2YV2hsjdyo75DhVK9vmHHQn9F3BLege1QXXYvb9XUAb+EBrPaIAPiZULE889Q
         pbyQ==
X-Gm-Message-State: AOJu0YwBal/zdzADGPFhhqCm2gK/AGZ29iRZ+tTDt+jc7CX2Ai+E7EM1
	hzKTnc5i6bz11qBYoAlYgQk=
X-Google-Smtp-Source: AGHT+IFDWCE7cwFMb71rXQpklhvffg6P/5bjJ/3PrxITyGyrrMV9n895hp3v9j/1peLPnntQfvLR0w==
X-Received: by 2002:a05:600c:1d02:b0:40b:29f3:af02 with SMTP id l2-20020a05600c1d0200b0040b29f3af02mr667059wms.27.1700777024031;
        Thu, 23 Nov 2023 14:03:44 -0800 (PST)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0040b30be6244sm3215816wmq.24.2023.11.23.14.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 14:03:43 -0800 (PST)
Message-ID: <c8f3fcdc-a10c-4c24-b954-899cf413837e@gmail.com>
Date: Thu, 23 Nov 2023 22:03:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git checkout -B <branch> lets you checkout a branch that is
 already checked out in another worktree Inbox
To: Junio C Hamano <gitster@pobox.com>,
 Willem Verstraeten <willem.verstraeten@gmail.com>
Cc: git@vger.kernel.org
References: <CAGX9RpFMCVLQV7RbK2u9AabusvkZD+RZNv_UD=R00cSUrjutBg@mail.gmail.com>
 <xmqqjzq9cl70.fsf@gitster.g> <xmqqv89tau3r.fsf@gitster.g>
Content-Language: en-GB
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqqv89tau3r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2023 05:58, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I guess we could change the behaviour so that
>>
>>      git checkout -B <branch> [<start-point>]
>>
>> fails when <branch> is an existing branch that is in use in another
>> worktree, and allow "-f" to be used to override the safety, i.e.,
>>
>>      git checkout -f -B <branch> [<start-point>]
>>
>> would allow the <branch> to be repointed to <start-point> (or HEAD)
>> even when it is used elsewhere.
> 
> It turns out that for some reason "-f" is not how we decided to
> override this one---there is "--ignore-other-worktrees" option.

Presumably that's because -f means throwing away any local changes that 
are in the way of checking out the new HEAD, which you wouldn't 
necessarily want when trying to replace an existing branch.

Andy
