Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B264120D
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIRDy7tJ"
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67804114
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 07:02:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32fadd4ad09so3951769f8f.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699974126; x=1700578926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z7tDLPJJSg6gMImIXiooceZTmbydHzODUpxLWBGuNj8=;
        b=EIRDy7tJdCncu4lPIF3OAL+L16zbs+JrrKUAARKSh9EKDxZPXqfHn517Axp72B3wHa
         Uyxr7IjFBdhdQYTeYZCAvwipxBeCZb+YU4IqE+LOBjM35vCpPGJF7ZcMFTWd4INY4uMH
         K7tE2bHUxsTh7IhgZt10HwDH4luUbLKqAMvW210CXk7Trx/AdZ0r6D9JdjrFwLOPYSmn
         vbREBBnZBkFK3iXqNPFTl3EkLB/M0FA9+D0pjizDI0YHecv0q2MgqLCNRXLIfX2luP1a
         A1czpqhYJt0bgOFYeaT8tR7uchMoON8+mDzqb2Ke4dRsltq4jYAXa1lhWjb0238leMhx
         elqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699974126; x=1700578926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7tDLPJJSg6gMImIXiooceZTmbydHzODUpxLWBGuNj8=;
        b=RjibPp/A9c6yZoWwLCNPxGGfOwRFTGsMZwP6TwdmE6Y749OA9jihqMsoVCLl0xmiBp
         bg1mAyR43rZ4MnSRPt5+E7kiny6X2plSMI/a4M8Q+eDldOiF7XOCRV5fjv/HYGjtAV61
         nCQLpDAYqzUY51UiHoANe1qQHKQNxvW/ZyDvcqO4eVUAFnJL6Jxe1W1ptnPSAz4vYglF
         JY0uo5W9HrN4V8DfSRck93dfLVeU2FK6qrKtdqqw/kB5msfQPGOCYx5xJccnROXxMAzC
         LTiLvzif43vAbAg8ufX44HvUoTKJzALIAxrIO5IVZ7ruZP0xvH1/i496P/q/5XBgf907
         rixQ==
X-Gm-Message-State: AOJu0YxFStZecLwiVEOwPbQcQonASm8EczhVTYchyinZvi6FPW0HmMwI
	9+HM7WCKBrm5R6UeSt4OSM0=
X-Google-Smtp-Source: AGHT+IHLSOgnJnrz7RBHxTgL4FI4eh/zyxVK6bnk9PcOj11PzA+obDc8bWqpGW5GuAAACE2xOUftdg==
X-Received: by 2002:a5d:678f:0:b0:32f:7cb7:f66 with SMTP id v15-20020a5d678f000000b0032f7cb70f66mr7340737wru.20.1699974125495;
        Tue, 14 Nov 2023 07:02:05 -0800 (PST)
Received: from [192.168.1.212] ([84.64.93.134])
        by smtp.gmail.com with ESMTPSA id i18-20020a5d6312000000b0032d9a1f2ec3sm8067152wru.27.2023.11.14.07.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 07:02:05 -0800 (PST)
Message-ID: <00033c86-dbd7-4c88-bfbd-8f6766cd66c9@gmail.com>
Date: Tue, 14 Nov 2023 15:02:04 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Feature request: git status --branch-only
Content-Language: en-US
To: Ondra Medek <xmedeko@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
References: <CAJsoDaFX7YdncsTy7UsjxaM1GCKs36-H5RhJ6kzgBUFBJyoGZQ@mail.gmail.com>
 <47fa8400-1e5f-437f-84b8-50bb09580325@gmail.com>
 <CAJsoDaHX3t9bViq0F7gmJPD+PoE-ZqmJS5h=u-W900x9KEMmYA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAJsoDaHX3t9bViq0F7gmJPD+PoE-ZqmJS5h=u-W900x9KEMmYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ondra

On 14/11/2023 12:40, Ondra Medek wrote:
> Hi Phillip,
> 
> it does not work for a fresh clone of an empty repository
> 
>      git for-each-ref --format="%(upstream:short)" refs/heads/master
> 
> outputs nothing, while

Oh dear, that's a shame. I wonder if it is a bug because the 
documentation says that

	--format="%(upstream:track)"

should print "[gone]" whenever an unknown upstream ref is encountered 
but trying that on a clone of an empty repository gives no output.

Best Wishes

Phillip


>      git status -b --no-ahead-behind --porcelain=v2
> 
> outputs
> 
> # branch.oid (initial)
> # branch.head master
> # branch.upstream origin/master
> 
> I.e. it outputs a proper upstream branch.
> 
> Best regards
> Ondra
> 
> Ondra Medek
> 
> 
> On Tue, 14 Nov 2023 at 13:28, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Ondra
>>
>> On 14/11/2023 10:16, Ondra Medek wrote:
>>> Hello,
>>> I am working on a tol which should fetch changes from a remote
>>> repository on a user click. I want to limit fetch on the current
>>> remote tracking branch (something like "origin/master"), but
>>> surprisingly, it's hard to get it for all corner cases like a fresh
>>> clone of an empty repository or detached head, etc. E.g see this SO
>>> thread https://stackoverflow.com/questions/171550/find-out-which-remote-branch-a-local-branch-is-tracking/52896538
>>
>> I think you can do this by calling
>>
>>          git symbolic-ref --quiet HEAD
>>
>> to get the full refname of the current branch. If HEAD is detached it
>> will print nothing and exit with exit code 1. Then you can call
>>
>>          git for-each-ref --format="%(upstream:short)" $refname
>>
>> to get the upstream branch
>>
>> Best Wishes
>>
>> Phillip
> 
