Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8865577F
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="bbrYRLGQ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2745670a12.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 09:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1704993787; x=1705598587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pN+bt5g40W0ItBQQ/g++J0jPeI0w4/iJnzlSZEQuY/8=;
        b=bbrYRLGQ6bSzum9KxQijESZPH2OUqjjPuSL5/qMmF7emaMzsadDTEVD7DwQMiW6JNR
         Nlk+EMgluR7BDO2lku4Ttf9z+Vv6QxygSwa2P93xX+OHH6HNgCdUMNxyrzD22CGxrOW+
         QPTFXQYIHosXrpij0H4Q8/uVSDVHvF9HxcUyhW81X7jRLhgkfGUo0galnIu8w7DbCLDg
         6fUwG/h2YUv8Byv3VL4NcuyBqEh5ZEve/iku9xOEwioO1oa24cU53dDIvhRrDUUup+Vk
         zN+Y34EjBDOHR/Glf2/eSbMMq7rb/0Ab048sk2kh8SXKoiFA6Mc1v+MnSnxhi4KOU5s0
         5gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704993787; x=1705598587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pN+bt5g40W0ItBQQ/g++J0jPeI0w4/iJnzlSZEQuY/8=;
        b=tEEHYzm03Qpy6dt9cVoy0+AkxKnpY/xekYJ4y3kd67VhWkb7PJQFIpYFHcklJhyK0+
         KKjzWiqFAaPFiuXpXh402N5918CDiUk/RTKqM9fH0mPHW9ObPuaq5tDoFDq7uTv7wBHH
         DeP72uEVsvx+tfllXMCLrmDsJs74WgfMI6LaIAu51Cmhxuqf7USa9r3XKm24KCkhip6W
         qgvtOpwdp7PxJ2JsLlI1LRn7rCn7iQ/g0csrB0IAJ6UHcLvhdeb7t3SongeZaNaKvB5W
         BZ7IFeNCkuh9xMVeX6xfeGCUZRJtoa2gSsGP5yW5PKTmIr2ApY0zsZDI4ArbEmXbKvwj
         +o5A==
X-Gm-Message-State: AOJu0Yy1AsnY4pm7gB7GyUKSMF2U6CmlDt+4xkfW0ADt9XY55OCQWDY7
	883NewN6RZ9wXjyhRErhSHIm8AttL7yTTPPcsCEEFVEb
X-Google-Smtp-Source: AGHT+IH2+p7kZ0+WkLRqJETsdmuCVzMTQ+SSQ8kY4NfblclWWxmAd7ZGnocsUdMwOpyLke2b5NAKeA==
X-Received: by 2002:a05:6a21:186:b0:199:e1f3:b554 with SMTP id le6-20020a056a21018600b00199e1f3b554mr171405pzb.100.1704993786755;
        Thu, 11 Jan 2024 09:23:06 -0800 (PST)
Received: from [192.168.50.41] (172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id pv2-20020a17090b3c8200b0028de818854bsm1693172pjb.28.2024.01.11.09.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 09:23:06 -0800 (PST)
Message-ID: <a9afd237-e048-43eb-922a-2734e573a644@github.com>
Date: Thu, 11 Jan 2024 09:23:04 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] t7450: test submodule urls
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <cf7848edffca27931aad02c0652adf2715320d35.1704822817.git.gitgitgadget@gmail.com>
 <xmqqttnmfarm.fsf@gitster.g>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqttnmfarm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +#define TEST_TOOL_CHECK_URL_USAGE \
>> +	"test-tool submodule check-url <url>"
>> +static const char *submodule_check_url_usage[] = {
>> +	TEST_TOOL_CHECK_URL_USAGE,
>> +	NULL
>> +};
> 
> Granted, the entry that follows this new one already uses the same
> pattern, but TEST_TOOL_CHECK_URL_USAGE being used only once here and
> nowhere else, with its name almost as long as the value it expands to,
> I found it unnecessarily verbose and confusing.

This is only used once because I missed the second place it should be used
(in 'submodule_usage[]'). It's still somewhat verbose, but once I fix that
it'll at least have the benefit of avoiding some duplication.

