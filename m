Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D0E543
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccR9AKKS"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d560818b8so34728035e9.1
        for <git@vger.kernel.org>; Thu, 28 Dec 2023 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703775033; x=1704379833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4itXeVMlOw9McWjkzn9V3pI7kYVgEkDevScRlajPRH4=;
        b=ccR9AKKSLYuwBdFuabj7nASLs5O+otRMRiVkpAQJnSdq8xnx85detTLj/mmPFbqodH
         A0036iAiTyW0+PsK/k868YLSEXI0XGMeoJT2hxuvcpiF5fCR55nzFPwuAQjr0m/ssBkB
         OK1ktsKde3qUjBuLM/b7S363n+fbHCvKtF1JGQIAMNI8DIhiJrRs30r6fP0w1jowvHlC
         KA4ej6QxObsKMnWsZv7UXiYlKu4xp3vOn+L3fqlmuKTo+ai02m0Ql4jdUbm6Q78jFzXF
         ON+sRDOZ2MkURAs/UAiiVasPzPuLxrC1ibpwG+7Zo8BSwBvlAu4efNCNZldboXypKE8S
         QEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703775033; x=1704379833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4itXeVMlOw9McWjkzn9V3pI7kYVgEkDevScRlajPRH4=;
        b=PwQvIoWAsuL+jrl2ZOdMCqH2FCyB1LOzwL2blWSe4k2YvQE5oNNWa0mC+gFB5nYBOj
         AzQORSEmNdMSVzluiAFqFWiBCWAkHj0KMzCHsRLHeiAKb+abzHgR2K5z5GS1fBPaDPrP
         S7tMS6xGoyIqxJFCtpJKL3TX6t9yY4imm2y3wSHbnsHx71g8UeuVvLm7SCD3cglOm98f
         HBuy2MHPsoSsNYS1A6Qhu+7aHVb9pLF/1e2kWfxSY9V7by3vFQB2IN7SQMbkWXR29yxk
         /1dI6OQZA5y5sqPDcZc+i/DSgh7n33g76ZvSqSdmXK3KBGHYTe60Dl/NUwVqZOHtlRlw
         oT7Q==
X-Gm-Message-State: AOJu0Yz34337bkWeYZvXOuwTYW9NjVej0gnuuDTdaEa9+NEJjVdX5OKt
	a5ufpZYCpEg9P2GkYyidB4A=
X-Google-Smtp-Source: AGHT+IGeZKkXNGhh/5M0EIQ4N4IksFf0cpEjtxbLMjo+fh8nr+x0MNPMOhcB+q6yAe9iZ4FjAHWjIw==
X-Received: by 2002:a7b:c3c8:0:b0:40c:3f09:57bc with SMTP id t8-20020a7bc3c8000000b0040c3f0957bcmr5270730wmj.175.1703775032859;
        Thu, 28 Dec 2023 06:50:32 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id bl13-20020adfe24d000000b003365fcc1846sm17224215wrb.52.2023.12.28.06.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 06:50:32 -0800 (PST)
Message-ID: <733be0c6-24bf-453f-b539-ac2226955b5f@gmail.com>
Date: Thu, 28 Dec 2023 14:50:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git mirror at gitlab
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, Olliver Schinagl <oliver@schinagl.nl>
Cc: git@vger.kernel.org, gitster@pobox.com,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 psteinhardt@gitlab.com
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
 <ZYQl_G-S4vQibHWn@framework>
 <1D1CDDF3-E0D2-4059-9C9A-796145AB6E24@schinagl.nl> <ZY1YYtoIw4dIpZ6Q@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZY1YYtoIw4dIpZ6Q@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/12/2023 11:13, Patrick Steinhardt wrote:
> On Fri, Dec 22, 2023 at 03:06:08PM +0100, Olliver Schinagl wrote:
>> Hey Patrick,
>>
>> On December 21, 2023 12:48:12 p.m. GMT+01:00, Patrick Steinhardt <ps@pks.im> wrote:
>>> On Thu, Dec 21, 2023 at 12:30:02PM +0100, Olliver Schinagl wrote:
>>> Not to throw a wrench into this, but are you aware of the official
>>> GitLab mirror at https://gitlab.com/git-vcs/git? I myself wasn't aware
>>> of this mirror for a rather long time.
>>
>> Not a wrench at all, and no, I didn't know. How old is it though :p
>> could be that git-vcs was created cause I owned gitscm :)
>>
>> I had chosen gitscm to match the official site, git-scm.org. the
>> hyphen I left out because afaik it wasn't allowed on docker hub.
> 
> No idea when exactly this mirror was created. The first mention of it in
> the "What's cooking" report is in December 2020, 489058b80d (What's
> cooking (2023/12 #05), 2023-12-27).

I think Ævar set it up towards the end of 2018 [1]. I think he used it 
to do some testing using the gcc compile farm [2]

Best Wishes

Phillip

[1] https://lore.kernel.org/git/87k1mecj96.fsf@evledraar.gmail.com/
[2] https://lore.kernel.org/git/875zwm15k2.fsf@evledraar.gmail.com/
