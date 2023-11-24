Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am1boeGw"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DCD1723
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 07:20:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4083f613272so14236325e9.1
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 07:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700839203; x=1701444003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RqZP0tAqadoZX0cctD0qu/66cystZM3tTYPFMJH70bg=;
        b=Am1boeGwJlKFFMUMbmMtvfOaCTivWM6NuN/sPfGxdkOSGnwByzefkcWaFrF1nfxNYA
         5X2Ab228inxRJYm7159II+m9rY+aXYNI+kFVGGn0BAFHRSEN1nxKqIhrgjAsENbqXsLj
         EYohRCZhCvEO/Y24OWzpXcT+USmT6YC4lu21kaY9Wi8orL11Igzm6Xn8bqonoBLgr9JW
         TQFBDc0tl78b2ZLIFb2XngNOq4rEdhMMP9jCIGOiWOXtf7Ys1TqgY3S/qX8Wory5OTPw
         zuQWHO22nYN6FHaGL4hVxCVi2nac49wzCQaLZ8EmBkLz5AHPFuLjaVN8EeK3t+wCm1Zt
         pJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839203; x=1701444003;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqZP0tAqadoZX0cctD0qu/66cystZM3tTYPFMJH70bg=;
        b=wdUGx8n/e50nhxbDd1FKvv7qaYLC1FZkFlraOIu3VW3mS9LtGMNzobtu3ppMALji43
         bI4pvBgm/D0wkUoUzbdarBtZh5kYhqz8LroXO/vT7o8lrlR7VOFok7Xw0iopMyFg5kcX
         uT3Gxspie1hhJwejOM/yKpiN+jlRfTumSKcUkt0GtjR9Mvd1YIUIZVxVzxOqBceh6gD2
         ZcdcvvcvzXoBDGMWS7egHJF4OLAhVgOIhffkx87LXG3GNuNrKIRdw6nRGisCMj+eGStb
         c8p3M2STX2taCokZ3C+CBAWqdMmDarAA3GssUYBesIPjB5t9i6lPO+kIeJlnv9/qVQoY
         0Hfw==
X-Gm-Message-State: AOJu0Yzeu0QD88XCa56GZZnuT8VKmGgfbz/X8PwNXQQNqV8lkWk52Nt0
	K+P+kEMEkRuRRsaKlzxdriMam1ZEemw=
X-Google-Smtp-Source: AGHT+IFaEzQjIpstCquzHotBo/KVBHmmtC6Yqc5/5T/oWCAAn+VcawUeVQevUhh0iyDEFaFFmrCwPg==
X-Received: by 2002:a05:600c:46d3:b0:405:1bbd:aa9c with SMTP id q19-20020a05600c46d300b004051bbdaa9cmr2450659wmo.34.1700839202677;
        Fri, 24 Nov 2023 07:20:02 -0800 (PST)
Received: from [192.168.1.212] ([84.69.146.25])
        by smtp.gmail.com with ESMTPSA id az15-20020a05600c600f00b0040b2b9bf321sm6079524wmb.9.2023.11.24.07.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 07:20:02 -0800 (PST)
Message-ID: <b6e24bb6-a497-4d37-a938-cfbcdbe77a9d@gmail.com>
Date: Fri, 24 Nov 2023 15:19:59 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Unable to split then edit hunk in git interactive add
Content-Language: en-US
To: scarf <greenscarf005@gmail.com>, git@vger.kernel.org
References: <8d7c8313-0f02-4218-ba2a-1716ada7956f@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <8d7c8313-0f02-4218-ba2a-1716ada7956f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2023 08:16, scarf wrote:
> |Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)

Thanks for taking the time to report this. While it is a known 
limitation of "git add -p" that editing a hunk after splitting it can 
cause problems (see below) I am unable to reproduce this particular bug.

When a hunk is split the resulting hunks share the context lines around 
the split. The trailing context lines of the first hunk are the same 
lines as the leading context of the second hunk. If the shared context 
is edited then the lines no-longer match between the hunks which means 
they cannot be applied. In general it is better to avoid splitting a 
hunk if you plan to edit it.

Best Wishes

Phillip
