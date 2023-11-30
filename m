Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jguk.org header.i=@jguk.org header.b="OadCyLYh"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1195D194
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 12:19:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4079ed65582so13092975e9.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google; t=1701375551; x=1701980351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMQAJwGcXQVah6GLaL6geSOl653G6WLDMv4NuFewwVE=;
        b=OadCyLYhWVE3B3ggRyXYx/INiEO3r+nRVCcPlS3ue97VF0prWOEOvCR4yq6kOteNIi
         FxdseiNmQHXvH2sc9cePVQIL+vuLqTi4ciURmfyiNhnc/frKVpIJyIZk/lRLwyCCTHrU
         MpKVQQ6B5q09tVrsW2xsmyMn5MRpgnYBGhNGJbsKcw5JqWW5Sgi6vdgnsO/3m+fhYRAY
         stWXd97gSBz8ExOT8HxTdCfSB1FHOqAZGYKnYHnsOwYALWSsrCk34ELr2GpPTLabB22O
         prV2osycfel4PH53TkRX1d1yQunjxaQMafN6iCCUFMuTkK9E5EuSWPo5Rq1cpLvC3uyi
         5UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375551; x=1701980351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMQAJwGcXQVah6GLaL6geSOl653G6WLDMv4NuFewwVE=;
        b=SOpzuNy6qvvGO1aP5fRbooGVxh+1motwT8PafEfCnobYMi20WsehpY9g66Gz9fvOJL
         b2CCs9sFcn5aNlKm9cfdCt6+yI90Dq2Nsy9QHThwupUwWYZMIhxxH1Js31/6Yp9u+x7t
         LAWm1b7pdjrvD+UNcPvOh48Y4VdTg0d+15jqwldk2QnzTInkkoI/59iFxITn1U3USd1b
         cCrD1u7L0QlHS/vz1YlZhcTEGrmG+9vAzB1IBJuZw5+FcnHOp/5YKK/zH83yOGJnr18q
         hyrWze0qj8Bv5sH8S5bNumYlHithUZh2ce22ufvKLaEtovoJXNkyNPOEl7sClv0YCkUW
         g0GQ==
X-Gm-Message-State: AOJu0YxzH0PWEE7GyXHK2/3F4PrU3IZAadTBNCOa9QONrI33VV7ShZQ1
	735x8APp91TWk/w627dqzNUNZwN+S3tLbYD33oc=
X-Google-Smtp-Source: AGHT+IEo7baYt18WfXuhXoWfAkGNYJZKxR3HPgrArQv28Q0GYh6qEXsWNDNg1rxdye63k0bMP4uL6w==
X-Received: by 2002:adf:fd12:0:b0:333:2fd2:51d5 with SMTP id e18-20020adffd12000000b003332fd251d5mr71350wrr.78.1701375551462;
        Thu, 30 Nov 2023 12:19:11 -0800 (PST)
Received: from [192.168.0.12] (cpc87345-slou4-2-0-cust172.17-4.cable.virginm.net. [81.101.252.173])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d584f000000b003331c7b409asm2398841wrf.78.2023.11.30.12.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 12:19:11 -0800 (PST)
Message-ID: <c3efb95a-7317-421a-bc87-fcc234be16c0@jguk.org>
Date: Thu, 30 Nov 2023 20:19:09 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Consider dropping the decimal places for KiB/s 52.00 KiB/s
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
References: <637be919-0b04-4e5c-8f2e-43340521e6d1@jguk.org>
 <ZWjdatp3SRb4mN6G@nand.local>
Content-Language: en-GB
From: Jonny Grant <jg@jguk.org>
In-Reply-To: <ZWjdatp3SRb4mN6G@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/11/2023 19:07, Taylor Blau wrote:
> On Thu, Nov 30, 2023 at 06:11:57PM +0000, Jonny Grant wrote:
>> Hello
>>
>> May I suggest taking off the .00 KiB/s suffix, has that been
>> considered? As the decimal places don't appear to change, they're
>> stuck on .00.
> 
> I wonder if you have a throttled connection that is locked to 52KiB/s
> exactly.

You're right - I changed to https and it went to 6 MiB/s. Seems throttled on git://
I should have checked that first.

>  The progress code that generates the throughput is in
> progress.c::display_throughput(), which computes the rate. It's computed
> in bytes/misec, and then passed to throughput_string() (really,
> `strbuf_humanise_rate()`), which formats it appropriately.
> 
> If you're in the KiB range, it will print the decimal component, which
> is:
> 
>     ((bytes & ((1<<10)-1)) * 100) >> 10
> 
>> $ git clone git://gcc.gnu.org/git/gcc.git git_1
>> Cloning into 'git_1'...
>> remote: Enumerating objects: 2949348, done.
>> remote: Counting objects: 100% (209238/209238), done.
>> remote: Compressing objects: 100% (14579/14579), done.
>> Receiving objects:   7% (210878/2949348), 76.33 MiB | 52.00 KiB/s
> 
> On my machine:
> 
>     $ git.compile clone git://gcc.gnu.org/git/gcc.git
>     [...]
>     Receiving objects:  11% (342176/2949348), 108.09 MiB | 24.01 MiB/s
> 
> I suppose we could consider dropping the decimal component if it's a
> round number, but I think that it may produce awkward flickering if the
> rate oscillates between a round number and a non-round number.

Now I can see the advantage of it as it is. wget is similar.
Kind regards, Jonny


