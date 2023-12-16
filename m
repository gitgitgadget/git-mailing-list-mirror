Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD64F1428A
	for <git@vger.kernel.org>; Sat, 16 Dec 2023 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs9PYrdA"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3360ae2392eso1129414f8f.2
        for <git@vger.kernel.org>; Sat, 16 Dec 2023 02:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702722012; x=1703326812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19JkIOfvuOi85MWcoLkyFA0/Y9affwAAdeQstMrArbQ=;
        b=Vs9PYrdA2KSoo5Y5JW1uCSpcIuDtqHKPR8e0J7J1og60ye4OvmJgTm4a0U4qtHh4dv
         mJ7uCcm2vIVbGr5Ja3v4fkErKvSlOQbvj6IzhX7MovGt4UKuMKTs3Zf6u6+1H9VLUXaF
         7SRBUh1JVUoncSq2hmiHDtQr+qYV4myWbWaOTcIoVk1tfnFdRHrCExCwu4zC2E/Tw3MI
         +HOVwn73Fu98QtV9V0orRQ5A1a38k4CATdi7bAvvg7W3SEtIgCngLiTEHcXqMFByO/WL
         7vf6qN/jp/TSZf382muOpW8v2Goy5UCJPzNGlbhWT6O+1y4Nm8Zmh7YpYVNUhUwUehA1
         roJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702722012; x=1703326812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19JkIOfvuOi85MWcoLkyFA0/Y9affwAAdeQstMrArbQ=;
        b=My0Awh0mIYmEdaRnqJ/RT0cOEMrUXBuLUEMMeNR4IY7m9aA2wAEJ2ZyBdtEnEEZEZ7
         clp+drWkCbtXIIOnLloIaKgX9+4sGkx9h/Sc9LCE/Gts1ROIMNOHLpe3vpqWJH3fBgdy
         hEWFJW4tY4GVfFWI/Wk++ZjjheYMEU3TXEnp2k0GSDjQBXR3E6IJGj9hKWgpY9XJhjeW
         Wj7M6RWp00113AdSJjaldtiGrAwdRbKGkYPbUJ0zedsA8ZbqR0rw+VN1wLqOB5T1T33O
         KSOiOr6dgB5T+avF0TqSNOsEst4BIdapYf6OBwJNjdtRpJMbHxm6LiEzBbq94ffxfrBN
         3Hbg==
X-Gm-Message-State: AOJu0Yyl9bzDdm+87Kg+zbhRobG+XSELfhlqT/4qu5VmCrcOrHtI0snW
	pQztDEls8Yli40F9v4Hk5Q+wng5+Zjg=
X-Google-Smtp-Source: AGHT+IHWyQaikWKKQnyeSKtfO6BL8oWxRmUuJKifen/w6e/W48qmjdp3qkcF1JKpG1XnzL6sk01QUQ==
X-Received: by 2002:a5d:50ca:0:b0:336:5bd0:8b2 with SMTP id f10-20020a5d50ca000000b003365bd008b2mr605052wrt.126.1702722011896;
        Sat, 16 Dec 2023 02:20:11 -0800 (PST)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id z6-20020adff746000000b003365fb3247csm722112wrp.32.2023.12.16.02.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 02:20:11 -0800 (PST)
Message-ID: <132a3daf-23fa-4575-a77f-bdf0a96fb5d8@gmail.com>
Date: Sat, 16 Dec 2023 10:20:09 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] make room for "special ref"
Content-Language: en-GB
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20231215203245.3622299-1-gitster@pobox.com>
 <xmqq5y0zkvqx.fsf@gitster.g>
 <321b8084-fddb-4b5d-86af-7f88cb3edf7b@ramsayjones.plus.com>
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <321b8084-fddb-4b5d-86af-7f88cb3edf7b@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2023 22:44, Ramsay Jones wrote:
> On 15/12/2023 21:21, Junio C Hamano wrote:

>> If somebody is reading FETCH_HEAD and acting on its contents (rather
>> than merely consuming it as a ref of the first object), perhaps
>> feeding it to "git fmt-merge-msg", they will be broken by such a
>> change (indeed, our own "git pull" will be broken by the change to
>> "git fetch", and the second bullet point above is about fixing the
>> exact fallout from it), but I am not sure if that is a use case worth
>> worrying about.
> 
> Yes, I was going to suggest exactly this, after Patrick pointed out
> that there were only two 'special psuedo-refs' (I had a vague feeling
> there were some more than that) FETCH_HEAD and MERGE_HEAD.

According to the pseudoref entry of gitglossary, CHERRY_PICK_HEAD also 
stores additional data (which would imply that REVERT_HEAD does too).
Looking at CHERRY_PICK_HEAD during a pick though, I only see a single 
hash, even when picking multiple commits.

Regards,
Andy
