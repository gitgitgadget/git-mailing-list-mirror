Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960C30CFC
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="c7RqnziB"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42619AF
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 11:30:24 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc131e52f1so231515ad.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 11:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1699385424; x=1699990224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bYSS5EVqAnTf4pT6dcLPPEa0Y3H+P6g/HNg6oao8Oqg=;
        b=c7RqnziBdkJOh1fXy4ehFjmx2crKgdA5nBVE3LT9eE+mmxCUr7YX0sFvJbh8D0XaOk
         MVJW/nrPrFOlspv8ecT9pSigTTgt6rIU1qXTl8MeDI5bKXCRfVo3oR05BOQ8ajvq6BUg
         F0pCfQudCw/8kAQUQ4dHdhyTJ7iPMh0RM3azNh/VvKu09hgM2Okm0TEm+H4TlGwKlkZR
         BaUjVZRa1t8B1dDwnlNLhwFv4bXlW5INyRjpk/EwDxofsTxWNQO4VM9cYe3ZtjmiSLiD
         CMOCe1vuB6j35WlRtMJVSfFG1MmigZ27Q63aIgjd0b0uAugriiEABZqDRvlUDB1MuhGM
         KCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699385424; x=1699990224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYSS5EVqAnTf4pT6dcLPPEa0Y3H+P6g/HNg6oao8Oqg=;
        b=MV9p2ge9Wuxpyu6i5yJSkDbZq5/R9LRDVD9y478luFg72R/ZJrbxJYTJwYda1SPTGB
         ogQWle+Ok4mPvF+CQv9BNVk4Hb69hiVn07C5oIM6SEmE7lk2P3RHzuS2fbJMW7pTYJlS
         qKE9ssmbpyJBTB8W3xHyE0GWOSYxo1ZdhPxT1L7JAxx85AYRzkwFj7DC4temBLCte6by
         LNx9y/pr+Z2EhiavOKMihuB7O/UZgEkSesn3TpG359RLBliNRW7qqMXBF/NRr8eE8Ck2
         himbZwB+1Xm2tX9JF17vAvKu9VxXEi8fBguME6BC9Pe8HLhMS7jHKSfvDkGxUNNWPndf
         N5ZA==
X-Gm-Message-State: AOJu0Yw5nqwRPKavTL1w31+AIfDn33TCp5UM311N0JKGmwcgVDdlTmRF
	RWyOanU9RQSu0BBeTH7qRpZmKhJbdRrHWVnUYw==
X-Google-Smtp-Source: AGHT+IHJ01HVR4imBZNKA+RXSA3PadU6e/pox50wXxpwEvoCkV65KSv+9fZIDh0aZRq1s7gv8YFTXQ==
X-Received: by 2002:a17:902:ce88:b0:1cc:332f:9e4b with SMTP id f8-20020a170902ce8800b001cc332f9e4bmr5767449plg.1.1699385423737;
        Tue, 07 Nov 2023 11:30:23 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id jn14-20020a170903050e00b001c74718f2f3sm180079plb.119.2023.11.07.11.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 11:30:23 -0800 (PST)
Message-ID: <e166abeb-3566-4acf-a252-bc493ee37f41@github.com>
Date: Tue, 7 Nov 2023 11:30:22 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] for-each-ref: clarify interaction of --omit-empty &
 --count
Content-Language: en-US
To: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>, gitgitgadget@gmail.com
Cc: git@vger.kernel.org
References: <88eba4146cd250fcabfb9ffa9b410ce912a82ce7.1699320362.git.gitgitgadget@gmail.com>
 <20231107192326.48296-1-oystwa@gmail.com>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <20231107192326.48296-1-oystwa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Øystein Walle wrote:
> Hi Victoria,
> 
> Victoria Dye <vdye@github.com> writes:
> 
>> Update the 'for-each-ref' builtin documentation to clarify that refs
>> "omitted" by --omit-empty are still counted toward the limit specified
>> by --count. The use of the term "omit" would otherwise be somewhat
>> ambiguous and could incorrectly be construed as excluding empty refs
>> entirely (i.e. not counting them towards the total ref count).
> 
> I implemented --omit-empty and I completely overlooked --count!
> 
> (If I were to do it all over again I probably would have implemented it
> so that so-called omitted refs did not count towards the total. It makes
> sense to me since e.g.  `git log -3 -- git.c` prints the three most
> recent commits that touch git.c regardless of how many commits were
> walked in the process.)

Since the interaction isn't clearly defined at the moment, we could probably
still update it to work like you're describing here. I'm happy to drop this
patch and implement your recommendation in a follow-up series. Let me know
what you think!

> 
> This is a good and welcome clarification. 
> 
> Acked-by: Øystein Walle <oystwa@gmail.com>

