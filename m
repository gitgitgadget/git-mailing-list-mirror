Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6C32C6A
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxpIPq2S"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e5701cbbaso11658075e9.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 08:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704990619; x=1705595419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/GhY1D8Ot84ujCWbPTgFQHX5btlmRjPpvMi6AOxLKhM=;
        b=bxpIPq2STutUvui4/aIZCNU2TTT6Uk4IrAluNXBoYQbnJwMh+1UUj5dV9EsyFNTKbj
         UejYGzgPsqU9iYEDuH24SHtQec/PlFX3tImR+YFIJfVNPV+XdV/ewGUMJp+/AqQZHw/W
         IcSVIDbpy6tTVKL8R8Pq0lEEHKgTx45uGuUdtQTYg+DanPDLw/SGbSWyWo99WRrnAgcT
         u12hjZApACEh9UftPQfdDwlhSONXdnZ2fy0gUX500j1UzZZAfOolawcmV9vyGPdP+7Gh
         XCQ5euCTIJDIofzgKMmAXC0vg/J0uwOY0bmyW+mRyWvFx3SlhMHBVmAODIw03AuR33bq
         4KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704990619; x=1705595419;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GhY1D8Ot84ujCWbPTgFQHX5btlmRjPpvMi6AOxLKhM=;
        b=wpdOluItPHfKYO1A137YdSnwNhNSF7c5X51KAfWpihAXDj6x1bLhdSkuVtfRJWs+4C
         ZyTska98aOZMsUrIPqW0BBNdZkBKoEBDT+Gd+M4djOY/86IeTiSYbWdi9jJm4xCnS+6H
         pK7p3wDi/qfjf3grQtbXyjv966IYknzuBDPJB7cgDPtSMX71iF5EugF4HOdr1wvArWpv
         733as6Gp+FQiOZ0ueVc6zpn3u6RHpbm0RAMeRLGyNRfsNf9rI56fKlJ74wJO67u81S4h
         gp1mgpk9u+VTIHReVrGyvr++0hoyfx6cvoZ7iR3JXB5pe1UUixRjvQqcckVSFPb4ahfd
         lPBw==
X-Gm-Message-State: AOJu0YzzW5tS1PpT1jpz3A0w+n/Z5hC8k5pMWWoPnspZg64vQQQLvhxu
	vM0i8ku5oIltBK3uZsNerMI=
X-Google-Smtp-Source: AGHT+IH475qNrCMLJyXfhRdgQRgKPv9vYFVgkp4jlJtPkCt3+1WZz/M0gis9kfeGV+zbygoNyhwJig==
X-Received: by 2002:a05:600c:518d:b0:40d:5f8e:21f3 with SMTP id fa13-20020a05600c518d00b0040d5f8e21f3mr47351wmb.85.1704990619273;
        Thu, 11 Jan 2024 08:30:19 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id t21-20020a05600c451500b0040e3ac9f4c8sm6318297wmo.28.2024.01.11.08.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 08:30:19 -0800 (PST)
Message-ID: <02cf7ef3-6a16-4fe1-a032-ea7c727c9b12@gmail.com>
Date: Thu, 11 Jan 2024 16:30:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] t7501: add tests for --amend --signoff
Content-Language: en-US
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, gitster@pobox.com
References: <20240109165304.8027-2-shyamthakkar001@gmail.com>
 <20240110163622.51182-6-shyamthakkar001@gmail.com>
In-Reply-To: <20240110163622.51182-6-shyamthakkar001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/01/2024 16:35, Ghanshyam Thakkar wrote:
> Add tests for amending the commit to add Signed-off-by trailer. And
> also to check if it does not add another trailer if one already exists.
> 
> Currently, there are tests for --signoff separately in t7501, however,
> they are not tested with --amend.
> 
> Therefore, these tests belong with other similar tests of --amend in
> t7501-commit-basic-functionality.
> 
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>

This version looks good, thanks for re-rolling. I have left one comment 
below but it is not worth re-rolling just for that.

> +test_expect_success 'amend commit to add signoff' '
> +
> +	test_commit "msg" file content &&
> +	git commit --amend --signoff &&
> +	test_commit_message HEAD <<-EOF
> +	msg
> +
> +	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
> +	EOF
> +
> +'

If you do happen re-roll I think we could happily lose the empty line 
before the closing "'" in this test and the next.

Best Wishes

Phillip
