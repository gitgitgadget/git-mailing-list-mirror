Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D56124
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhguVv+4"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4AD1AE
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 00:41:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5cd27b1acso4151375ad.2
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 00:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697787684; x=1698392484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YZPD2gjOWOExjx9Rb5cGBQ0oMQpXAenYkmIu4LDu18=;
        b=DhguVv+4ZLzBGpcGsVieQhNAA9hlvQuwUuvNGoaZcvNpNu1fIZK1rdm/SYqHgfMYMY
         GFclnSzhOSBulY7yOnbEgMnozAXASUym0ABxo2UTCvy7r9GODeer9M4pVEXU6MvDWZlV
         bxYcc/ghIfMp9qE4qvVHfZCK3d1hy0AkKuZdmy9u6mNGtgU1FQT09gSdBuo7Xkas4dDf
         lPRK55IzW5KqlytZyusa701mHFL6TTzIUT0ysvHdP/xbd+ylVGOqLIoWxjer8XFmZatw
         63UtomsbGZoQCqC49bR8egc7ckhAzQLHirG1Z82ltagG+gUlIJL7fsmL2FLaV8anRuUZ
         O/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697787684; x=1698392484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YZPD2gjOWOExjx9Rb5cGBQ0oMQpXAenYkmIu4LDu18=;
        b=NWtAqyHHmHYGjz/dw3M2WAe9DhbB/VEx4yk37MIG8uhmm0h9g4l8kUBrsqDEH4Przw
         i/zIl3IcKVsc/LyQFKfblIGL8FODL9fmWABBKuyQ20PSsdE7zdQqhFugKuhk8NBN5wci
         bWJ2vboGzLZ2yZYXR+99jtCael42bkvvphV72i2s5evE7bsrpOINkt8mUluk/OGc8wuP
         Hsv0Us6mBRh3IZEiscqTUBTmcIUItKtRckqa7PANH4YJ99L91XfmBl1EiX4U0bTtjslj
         oRvfCkdwreV1foifjql6d/pvE9uf5NYLFZkRi2vUwo1hhOY1CatD6cscwrid5F0+3+Gy
         1HVw==
X-Gm-Message-State: AOJu0YzbI6bwUDSChEa/GpVrDAR/ngKW778nM7p/Okm2ZGaiuBUnHWau
	oTtgtarfmKMinnNX0fCjcdajKtRsRD4=
X-Google-Smtp-Source: AGHT+IHMXsJGzmRRshlGDTPenDbb9w6nuNVBueXDY45e+4WvYt9RYGEC50G4A9ua3PfZkfcwOftwug==
X-Received: by 2002:a17:903:2310:b0:1c9:d46e:d52d with SMTP id d16-20020a170903231000b001c9d46ed52dmr1164427plh.64.1697787683708;
        Fri, 20 Oct 2023 00:41:23 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001c3267ae317sm882883pls.165.2023.10.20.00.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 00:41:23 -0700 (PDT)
Message-ID: <facb06e0-9ad7-40eb-83e3-0a951931496d@gmail.com>
Date: Fri, 20 Oct 2023 14:41:17 +0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] typo: fix the typo 'neeed' into 'needed' in the comment
 under merge-ort.c
To: =?UTF-8?B?546L5bi45paw?= <wchangxin824@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <2DB9ED79-FE58-4072-91E0-B4C51A3F6C5B@gmail.com>
 <xmqq5y32zgnk.fsf@gitster.g> <42D0A6FD-1314-4977-92E6-BF6535D82E8A@gmail.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <42D0A6FD-1314-4977-92E6-BF6535D82E8A@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/10/2023 09:14, 王常新 wrote:
> It is my official name. But the email address is not a valid one. Should I rewrite the commit message?
> 

Please don't top-post, reply inline with appropriate context instead.

Did you mean that you can't receive ML traffic on your @qq.com address?
If so, resend with your @gmail.com address as patch author (you need
to set user.name and user.email accordingly). 

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

