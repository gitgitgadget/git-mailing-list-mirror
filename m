Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1D3FB05
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ctwo+0zH"
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038CE183
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 04:28:19 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c7c7544c78so63249671fa.2
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 04:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699964896; x=1700569696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/vzgMg7Im2hdtKtXa6YCzuWN72OdatmYT/rfOJqW9Lg=;
        b=Ctwo+0zHPgUfpoBkp/A2lMqQjEp2Sx9lMzm2EullI2S4B8sm4v82DRlB0unXG/uo8s
         BZfp+AfZuFRQ/7DXm5CjAzVmUf01WwgPO4H7cvBGwhdKzvaI7UkPidPJM1HmKX2Oi4xG
         K+uyBpfy6EBu23RE5IXri+KmQ97hQeAFd1OZ7RyVnNntt/DWsxdN45OHC78D2qwBeOuT
         nZJJ1/0EGz7CuaI6jxrL0dxJurzEZFiTvZwaaqnYOi+DockZMjIgewuiEmrLHsCdHbG5
         0o+7j/+AMo12dRiokNvGfee+eU37EI//AcXUD0q/NGRJ6su7zw1bpQ96Q8/vw+OzsLdj
         UJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699964896; x=1700569696;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vzgMg7Im2hdtKtXa6YCzuWN72OdatmYT/rfOJqW9Lg=;
        b=qwEYPaUDWrMMBoDfd47VMux7rD5Z22HaX9+EOmU7Z+Orcwo/g4NqGpp9FYs0MZs/8e
         djhiHinntsGVsnc1bTDVini8yYZ4TzmggGU06PIAw/JS/Z9BnZjoVnTIODyJw8KWRZ42
         aS3kWskkBuwgdiHebB7XQS2UOIsPVW2WBeMti93zAc0SK4HQ9vZkHdDzjD+ajeNtPW0v
         l1nBFhHg4ze950Nxc64q1DeXYujjhArvqJ8dF933fr3etIyNxRY1RsVStxXpCVBQ38iN
         3cmNO7SXkIehCpgeJ7oh321FbUpkfckNTXzn9GOjIhyKgutVJgkPJYWd4Gv9VgMTH23e
         oXlQ==
X-Gm-Message-State: AOJu0YwTDPsl53S3JPHl13QwQtULxXmMJuAzqe85dq/YymxUr8q69S2y
	/GBF5khO3ClciYVJDHE+tptFcqqZ24Q=
X-Google-Smtp-Source: AGHT+IFWFJULb05bZIigN7SVv1hdwCoILXxxBs10Q+tm1kckRXaQh0yo42cEHy+x+5HR5HWyNvGfWw==
X-Received: by 2002:a2e:958d:0:b0:2c6:f1a9:e74 with SMTP id w13-20020a2e958d000000b002c6f1a90e74mr1676016ljh.34.1699964896206;
        Tue, 14 Nov 2023 04:28:16 -0800 (PST)
Received: from [192.168.1.212] ([84.64.93.134])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b003fee8793911sm11189569wmb.44.2023.11.14.04.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 04:28:15 -0800 (PST)
Message-ID: <47fa8400-1e5f-437f-84b8-50bb09580325@gmail.com>
Date: Tue, 14 Nov 2023 12:28:14 +0000
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
To: Ondra Medek <xmedeko@gmail.com>, git@vger.kernel.org
References: <CAJsoDaFX7YdncsTy7UsjxaM1GCKs36-H5RhJ6kzgBUFBJyoGZQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAJsoDaFX7YdncsTy7UsjxaM1GCKs36-H5RhJ6kzgBUFBJyoGZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ondra

On 14/11/2023 10:16, Ondra Medek wrote:
> Hello,
> I am working on a tol which should fetch changes from a remote
> repository on a user click. I want to limit fetch on the current
> remote tracking branch (something like "origin/master"), but
> surprisingly, it's hard to get it for all corner cases like a fresh
> clone of an empty repository or detached head, etc. E.g see this SO
> thread https://stackoverflow.com/questions/171550/find-out-which-remote-branch-a-local-branch-is-tracking/52896538

I think you can do this by calling

	git symbolic-ref --quiet HEAD

to get the full refname of the current branch. If HEAD is detached it 
will print nothing and exit with exit code 1. Then you can call

	git for-each-ref --format="%(upstream:short)" $refname

to get the upstream branch

Best Wishes

Phillip
