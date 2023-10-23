Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A61BDE8
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOeB4zVQ"
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1D19D
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 08:43:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40806e4106dso19957255e9.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698075814; x=1698680614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tlaw39WasdbtR+Ng7jK1awxOoaed4iGMWodsfsAEp70=;
        b=FOeB4zVQ1q80D3LveEXie7ZHcomDZKGDHt91eDiiSJiiNt0AP+wHo57TqlkdO5LMVT
         rI+KqUGAJ6LiJSbp36r0dnpnA3E9UwFj8lmOJfaTOT3V/XmeChwApT/Ah2WvfBub0an5
         7phciQqiRYy8JzkUfIIQAoQfAKkAZ4FL80cmz17Ll6Lk5m+Ab7QxU0wC6olTNe7MqWEf
         JMaW+oGKWoMr/wbeq/pM10Yl9ki6K1z4zN+xoxdinE3SrkIlfcQhqiFZP2vWGP77wB3D
         KFtIomHaTG9RD2XTul5uEKNuXtNjbI3h1imTpCM5ruu/8eYxVrkDv6Un4yzqxeBQac7W
         BmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698075814; x=1698680614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tlaw39WasdbtR+Ng7jK1awxOoaed4iGMWodsfsAEp70=;
        b=Z5v4ky6dh74xzP/fvVcdvesw5xJpkk5yhTrEaUHI/BrHoqyVO+M25hvI1ME3d8tAaH
         QRcr6gdTILtA3I0ehpwAKVmkyivUHAjx8ptdtrMaKhEtSFYDpTdIbTrWDrgwpm5Nayb7
         01OWf9sjbkBeJv0t0TwcvRB3ww9c7jgQBKgDnrz/MpAmpzDqTpz052Xi7iWJl512PjPG
         YMKf7MbP0YyBE5nu+mPslE97Pfk/HjadPe7g3OJHWmjFFrncOP9ZsDxSnKw9D88I6wof
         Eqzcaoxe8pPv9BCe8sW2PRYrxQnWhuoE8k+Nf8T7BWfZ91hzPkkpchJSg6pFllHNxBfU
         Kj7w==
X-Gm-Message-State: AOJu0YwLRUYi/+ler2AKu9G0rw/Pcp4d0XGMrU+484CpPGHwEPWG6fy1
	+6cgUT1UL+wdtnog/quSFxM=
X-Google-Smtp-Source: AGHT+IG4ECAnj912CeWyh5NwMPb+7h7k7Sv0x10j1V+KZCu+jj9h58WavofQk1wn5xDb88SyWSMDUA==
X-Received: by 2002:a05:600c:45cc:b0:402:ea8c:ea57 with SMTP id s12-20020a05600c45cc00b00402ea8cea57mr8532228wmo.7.1698075813720;
        Mon, 23 Oct 2023 08:43:33 -0700 (PDT)
Received: from [192.168.1.12] (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id n15-20020a7bcbcf000000b004060f0a0fdbsm14436140wmi.41.2023.10.23.08.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 08:43:33 -0700 (PDT)
Message-ID: <4f8616d1-35f2-418d-9d28-b230ca45090d@gmail.com>
Date: Mon, 23 Oct 2023 16:43:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/3] rebase refactoring
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
References: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
 <20231020093654.922890-1-oswald.buddenhagen@gmx.de>
 <xmqq5y31osmg.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq5y31osmg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/10/2023 23:07, Junio C Hamano wrote:
> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
> 
>> broken out of the bigger series, as the aggregation just unnecessarily holds it
>> up.
>>
>> v3: removed "stray" footer. so more of a RESEND than an actual new version.
>>
>> Oswald Buddenhagen (3):
>>    rebase: simplify code related to imply_merge()
>>    rebase: handle --strategy via imply_merge() as well
>>    rebase: move parse_opt_keep_empty() down
>>
>>   builtin/rebase.c | 44 ++++++++++++++------------------------------
>>   1 file changed, 14 insertions(+), 30 deletions(-)
> 
> Looking quite straight-forward and I didn't see anythihng
> potentially controversial.

Yes they look good, thanks Oswald

Best Wishes

Phillip

