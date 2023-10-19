Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D1C8E7
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="GF1EvTG9"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E637124
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 11:16:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9daca2b85so89735ad.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1697739400; x=1698344200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjI2fbGwoo0qJ0WCPGO3TnEWpIEbKJThY+sv+awuVhc=;
        b=GF1EvTG98NNImtAi/1Baeec4xajfqpwSUPAaSpRcb1j8WNGd000cBQE6+WiQog6a9O
         MxrKssv+/daV8ztbuQwyT7uP4/4/GobQrddOvk6vo2LHFrPb59UbGuHRX4BQmQ6b/CVR
         oUOmfs879VsEdxqa8nmqi/XCoKopAnBIaNNoahKkicHlEdRhQTF4WPjXJZru02D2WXb+
         x9bhOQlxQmNacZo8z6AAVWs8fplCtV8C8Eg5s/V8nIIoHiMQvd5hfL3IwIYsKz2z7B1a
         XL+t5O3x8R9E/fNmbWw6kIaqT49WeixHgIQwZgOhbVu9A6QLnsU8BhlEZDlfonxF0pjD
         kbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739400; x=1698344200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjI2fbGwoo0qJ0WCPGO3TnEWpIEbKJThY+sv+awuVhc=;
        b=JDtDY1JsDTonFYwrmhWi+qbYhPzC+5NqnrXS/NC/FNbax8KBolm6dAqNOPD+DNgASO
         HDVbXgxpbDHhO3aE6fP2AiHAiQJgnWfa0YeXLHYy6ZBi4qBlcuNv/0+dPpqF1SBVZ4Gb
         AcrvpdUh3hlHxq/JNshIV2nRUsxwkZUq/4s97ZE/C6hd5gbtpSMSm7j1b27wB4LXoHTR
         sD2M4McMWxOjFblKM1Jlaedz7GoCrEslemdUOqxnwkDZqFBsYcbPDMPzZQfcS54hrX7D
         ms9knLqXiQLXSF1G1GjH3Y1txd+zAumubq1eVBb+goK1PiY3W6/Jj5ZNn7FTmZ/rYh4C
         7kiA==
X-Gm-Message-State: AOJu0Yx++jQDKwOCo3XO5fSWQtS0qeNUcbxEeh+Ox4F7c+mHM6x7HMOm
	A5b1p1zADLu6dU2FgFz/Rf0C
X-Google-Smtp-Source: AGHT+IGCyl8/4TKUl8ZB4j02Y+khTPKG7Vvawn++txPraBHD8YO48KSJpOYiWZv99I9mV00JSrjxuw==
X-Received: by 2002:a17:902:ec85:b0:1ca:7909:6ed4 with SMTP id x5-20020a170902ec8500b001ca79096ed4mr4161456plg.5.1697739400637;
        Thu, 19 Oct 2023 11:16:40 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id b28-20020aa78edc000000b006be0c9155aasm99735pfr.91.2023.10.19.11.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 11:16:40 -0700 (PDT)
Message-ID: <01569dd1-f807-d56d-a123-5e8f3c930503@github.com>
Date: Thu, 19 Oct 2023 11:16:38 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] diagnose: require repository
Content-Language: en-US
To: =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: ks1322 ks1322 <ks1322@gmail.com>, git@vger.kernel.org
References: <CAKFQ_Q9WjF9i-Rx2jdCw-adPVQrWNfNKrDY-em8Rpa5RNLXz4A@mail.gmail.com>
 <20231014135302.13095-1-martin.agren@gmail.com> <xmqq5y39unvc.fsf@gitster.g>
 <CAN0heSqmZ7QXJbet2Tp=YYCjBLToOHtNy+n=zcf29XYaukYN0w@mail.gmail.com>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <CAN0heSqmZ7QXJbet2Tp=YYCjBLToOHtNy+n=zcf29XYaukYN0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Martin Ågren wrote:
>>> behavior, it seems more helpful to bail out clearly and early with a
>>> succinct error message.
>>
>> Without having thought things through, offhand I agree with your "no
>> repository?  there is nothing worth tarring up then" assessment.
>>
>> Because "git bugreport --diag" unconditionally spawns "git
>> diagnose", the former may also want to be extra careful, perhaps
>> like the attached patch.
> 
> Good point. TBH, I had no idea about `git bugreport --diagnose`.
> 
>> +       if (!startup_info->have_repository && diagnose != DIAGNOSE_NONE) {
>> +               warning(_("no repository--diagnostic output disabled"));
>> +               diagnose = DIAGNOSE_NONE;
>> +       }
>> +
> 
> When the user explicitly provides that option, it seems unfortunate to
> me to drop it. Yes, we'd warn, but `git bugreport` then pops a text
> editor, so you would only see the warning after finishing up the report.
> (Maybe. By the time you quit your editor, you might not consider
> checking the terminal for warnings and such.)
> 
> So I'm inclined to instead just die if we see the option outside a repo.
> If `diagnose` the command fundamentally requires a repo (as with my
> patch) it seems surprising to me to not have `--diagnose` the option
> behave the same.

I agree - it was an oversight on my part to not firmly require the existence
of a repository with 'git diagnose', and the same applies to 'bugreport
--diagnose'.

For reference, there is one other usage of 'git diagnose' (in 'scalar
diagnose'). However, it's already guarded by 'setup_git_directory()' so it
shouldn't need to be updated.

> 
> Martin

