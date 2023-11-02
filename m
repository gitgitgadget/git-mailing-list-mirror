Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8855223
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdB/t+oY"
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8C31AA
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:01:54 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2b1af964dso353221b6e.1
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 23:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698904913; x=1699509713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jMsOJeVyc/DpmJ3UyKZWdBQGJD2u+ZzLOML63Yu57N0=;
        b=KdB/t+oYZsIhDnaHAyjXuaiS/l2l92fkKxAWntN90xym1y/nMvlvQDbsdzRZ7Yiey8
         0z87X4VDO+ZSfCXENYxjT7AmRByTR0s/SO4mqxnk91AZHi0fTMSeigIS3WAKJNPGcQXO
         u+LBOaAQL2Ozoa8yU9gy29II/29DTkKw9L/E1D4XOa2Dvtzvs+rqULYKoAuTUCvDTYdq
         DHsmDPLLsev54/tehUYmRxAvVKkdEaMGf458+l1jhOM5sVKsE+DVANJ8x6gETFGzIEwH
         BrtIZaorcRkVycH1UAjbgr/JnliB5QM29mHk2UQDxAjNZXkn3NfIUy4Jr7WidmteaNid
         kkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698904913; x=1699509713;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMsOJeVyc/DpmJ3UyKZWdBQGJD2u+ZzLOML63Yu57N0=;
        b=Zm6vfZjn7APSIUS1s9RE1SuNtiBBhJVIzLkWDedANsBMHRmHNJCcBrsq3Opcvk3qOJ
         RsLai/hW5/Ym5su7c6/vnoIDjVX3Ro/RqRksZX8UVzZGpEZtqC44HTnhN3zMhSxlxp8j
         4XvrJXfg4TVUqhKlMay3WUbeNuywsX9lFOf3x8NRW+Wx2Q9FT1yiaCPVRc2rfNK4sm9v
         Tp/MqW5UJgQh29lyxlfgF1E/X7Zw6dx0hHBQM2zvpd97qYK8KBjq0f3mqPyc5/ssMcCa
         3G8yuMHmKAHelwYMlXRk+ChcwDds541QRvRg2RiZ3urSWt+bM3eNWKDk/l7gh8lQb1/u
         3RVQ==
X-Gm-Message-State: AOJu0YwBxee40wOLwC7HWB3EfhlnTC1BlThAPP3QXoDFHd4IUsXd1xFV
	6fFA3d1V0JUqJPCkDo4lPlI=
X-Google-Smtp-Source: AGHT+IGkGCipj0909Ssh1J52AdRlX2arKfmAxJQ+UOnWrxdQhxNYYXycH9J1jDd8j0JCkDzJzxvzxw==
X-Received: by 2002:a05:6808:1a27:b0:3ae:554b:6c57 with SMTP id bk39-20020a0568081a2700b003ae554b6c57mr21516084oib.11.1698904913440;
        Wed, 01 Nov 2023 23:01:53 -0700 (PDT)
Received: from ?IPV6:2605:2a00:8001:dead::3ac? ([2605:2a00:8001:dead::3ac])
        by smtp.gmail.com with ESMTPSA id u6-20020a0cc486000000b0065b2167fd63sm2093534qvi.65.2023.11.01.23.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 23:01:53 -0700 (PDT)
Message-ID: <aefa38cd-d0fa-4dc6-8d10-4358e36b39af@gmail.com>
Date: Thu, 2 Nov 2023 02:01:51 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: why does git set X in LESS env var?
Content-Language: en-US, fr
From: Thomas Guyot <tguyot@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>, Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
 Christoph Anton Mitterer <calestyo@scientia.org>, git@vger.kernel.org
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g> <3946c06e90604a92ad0dddf787729668@manjaro.org>
 <xmqqr0lzhkzk.fsf@gitster.g> <a831af51b6fb46b5d6fcd9768a7fb52d@manjaro.org>
 <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com>
Autocrypt: addr=tguyot@gmail.com; keydata=
 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
In-Reply-To: <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-02 01:48, Thomas Guyot wrote:
> Hey there...

I obviously thought about checking this client's setting the moment I 
hit the send button - if the response is garbled I'll resend it properly.

--
Thomas
