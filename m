Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD2134D9
	for <git@vger.kernel.org>; Sat, 16 Dec 2023 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGHvaAC4"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so7960335e9.0
        for <git@vger.kernel.org>; Sat, 16 Dec 2023 02:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702724178; x=1703328978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ZS1yuDOPmbVJyyXqHDa8z7nDgvSVfmDImF+JqX8+yU=;
        b=iGHvaAC4kKtSa3Dd5fdoCOi1ad+85Jt6zUR+njUqOqLvnB5ymyF2zs9BcsFuA9Y1OI
         Q53r2KX3sJMyMEI3jPbEe8wxNXN8V/AdmfTaxsIWAcsWNPep4oh1K4GUC87sD+TERQn9
         wDWXCnpgnQzDvmjlmcx7fHSesfXd8wxLc+74yRQ3LqW4MPGwR5bCwwNfqJJeqVEUYjtl
         82gPq3NFPr7Dhc+tNTMCIfvCR0j3asXXREppsnDlE7k9iZT3bm30jXnLnnwZPcsWjpqk
         XD9SO2p7M1PF9FUnJix6NGyeri2wNVaNSDJ1UPeieGMZrelfqF6MeybsiOEx8mjO55w0
         5pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702724178; x=1703328978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZS1yuDOPmbVJyyXqHDa8z7nDgvSVfmDImF+JqX8+yU=;
        b=fcpbud2iKb5ohSRAWaV2g/ekKaDDhaRs3XcvsVLPwFc3Xmff1O+vFBLq2fzyxYWNV9
         JFyfs5ZbXzeaQ3RbItyVQzS961v+pVN+fRTW4aOFBYE1v4R10xOvIYO89ZgMrR4a+byG
         ys6yL5QZWOASve92U+tNAxNhJbaTyptmMOY6x/XaHqh/NdmhOa/ceWjwKX7TCpxVz6tr
         kZOBYi5pwqSeJTohhSGfssT11dKLTZ88LbbzFTqSnOHbwDliKDWmGAYIb0+t2CFixDhe
         P+bLfUC1AT64JjBEp+6r0pFCqlKpXvt3sEyJUST3+2z3u10IyhYXqqbekEgIQUKJZzzO
         rHCg==
X-Gm-Message-State: AOJu0Ywy9wzch5m8zh9wLpDlAhkSaewymJqrwWJYWL9G8XHBu3T8ewUi
	ztpGHSbWi7okx8J2s16YCXw=
X-Google-Smtp-Source: AGHT+IGdEDs1J9r1E87U1lUZdJLZFh+Mk+wj7ZxUCS8oAmHz7kUr8haRGX2uoRQBaw1wHkNAdzI6rw==
X-Received: by 2002:a05:600c:8a4:b0:40c:69ac:bbe3 with SMTP id l36-20020a05600c08a400b0040c69acbbe3mr1447249wmp.151.1702724178016;
        Sat, 16 Dec 2023 02:56:18 -0800 (PST)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b0040b37f1079dsm35611774wmr.29.2023.12.16.02.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 02:56:17 -0800 (PST)
Message-ID: <ade1666d-9e58-43cb-9e50-8ce04f8d9063@gmail.com>
Date: Sat, 16 Dec 2023 10:56:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] make room for "special ref"
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <20231215203245.3622299-1-gitster@pobox.com>
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <20231215203245.3622299-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2023 20:32, Junio C Hamano wrote:
> A pseudo ref is merely a normal ref with a funny naming convention,
> i.e., being outside the refs/ hierarchy and has names with all
> uppercase letters (or an underscore).

I know what you mean, but gitglossary defines pseudorefs as separate 
from refs, albeit behaving like refs. Their name itself implies the same.

Although the 'ref' entry then goes on to say that "there are a few 
special-purpose refs that do not begin with 'refs/', the most notable 
example being HEAD."

That implies that at least some of the pseudorefs are refs after all, 
while keeping in mind that "HEAD is not a pseudoref,  because it is 
sometimes a symbolic ref" according to the 'pseudoref' entry.

I think a clearer answer on whether pseudorefs are refs is needed, or at 
least a better-defined fudge, such as "pseudorefs are refs except when ...".

Defining everything under "refs/" as refs, and the stuff outside it 
including HEAD itself as pseudorefs, would draw clearer lines. The fact 
HEAD is usually symbolic doesn't seem all that relevant from the 
perspective of a user trying to get a grasp of refs and pseudorefs.

Regards,
Andy
