Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886F5CBC
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1YiJCCH"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E8E129
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:02:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40859c464daso16440245e9.1
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698411726; x=1699016526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1zOIrY581mztdFneTLengF65GCws1ZzWlZzhvDifCkk=;
        b=K1YiJCCH4qNoR965MC8ltU219/vBjkaYQqrzEj3tnrj6AXgdD59wPQUJbVkBL+Xues
         YA5069f+by0H7L285Orhu+Ik9aic52DAnlfor2905/LGzv36dcM2/Xh0WT/AsUYfpAJj
         eirergpS+nKe6NVt0fZOR2wwQlR8D/ZeTrEcAF2TiLLmrkQzmhjr3eh82RAW1b/X900T
         BXq7Tg6oDAdUWmZIMT4SWtyXf9VYIspYqKK/NK6bvwpF5WMM1Sd00n/oEGms71UtVEEA
         EaYfzvzpukdBzEf5MCaxGyLmpq+eTOetdn3vHbLM8Ui3pXO0JRRcCnrYa7wi4fNYqoti
         4PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698411726; x=1699016526;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zOIrY581mztdFneTLengF65GCws1ZzWlZzhvDifCkk=;
        b=l6rs2AMMenuQ0B4Bg3OaPTSSFrVQsAKGKXK5NnVpV0SLBbtJrtjNoY4O8mfwZw9oiH
         FUd5vf+7fjAa49OwOxVYx3HecULcxDO/jOUbWbjkc1xTOcMSuy/hBTAO2mN9HzNyYDJa
         6PuDBC1+E+aLVXBAUosYCWFnNtIf1BvqmZj0mjTQTDAwZUHoGghcfS8GI2eTNGaXJFTl
         ct2EKY2ECty6mb0dq2I0SoazGvBN9KFd/UV26Hl2piL582kXFkDOfDJgIqlteULrTGKH
         qXQKllDKO8S6S6rDWOpxTnD7axdrlxm75AnmnkEArSOrIJt5PF2VFGkUK7wKTTx7szZc
         qSmg==
X-Gm-Message-State: AOJu0YzgXl61X6J5q99FKubD7FI/f22/yVe4KzfLRypGji1Ze+MWP8PD
	KKz25P4fzvNULpI40fu8Ofg5bA49TIY=
X-Google-Smtp-Source: AGHT+IGHJVHiSvu3u5BLGXcYdvltlQHSKwgMCDH4jomJmwCI03oIloytF+RhXIdAtSegoC6zLbl2RQ==
X-Received: by 2002:a05:600c:4514:b0:408:7abb:b0ee with SMTP id t20-20020a05600c451400b004087abbb0eemr2120283wmo.26.1698411725684;
        Fri, 27 Oct 2023 06:02:05 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c1c9300b004030e8ff964sm5166253wms.34.2023.10.27.06.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 06:02:05 -0700 (PDT)
From: Phillip Wood <phillip.wood31459@gmail.com>
X-Google-Original-From: Phillip Wood <phil@crinan.ddns.net>
Message-ID: <6ee43015-1abc-4269-b710-0647ce80d7a2@crinan.ddns.net>
Date: Fri, 27 Oct 2023 14:02:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <cover.1698305961.git.ps@pks.im> <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
 <0d889da1-7fd8-4e21-965f-6222e4433ecf@gmail.com> <ZTucxlBR1VrJPuSK@tanuki>
 <ZTulo_rh_G-lfICQ@tanuki>
In-Reply-To: <ZTulo_rh_G-lfICQ@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2023 12:57, Patrick Steinhardt wrote:
> Hum. After having a look at `ci/run-docker-build.sh` I don't feel like
> it's sensible to update it. It's not even used anymore by our CI but
> only by `ci/run-docker.sh`, which seems to be more of a developer-facing
> script?
> 
> As you said, this smells like rotting bits that might rather be removed.
> But in any case, as they don't relate to our current CI infrastructure
> except for being in "ci/" I'll leave them be for now.

I was trying to suggest that we start using these scripts again. The 
fact that we run the dockerized tests as root on the other CI platforms 
is a regression from what we used to do. I'm not an expert but I think 
for the builds that use docker we're essentially using the some build 
environment regardless of the CI provider so it would make sense to 
handle them all in the same way. I think the existing script uses "su" 
but we could change it to use "sudo" like you're doing here.

Best Wishes

Phillip

