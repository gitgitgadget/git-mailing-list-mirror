Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CCD28B
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jllKC6u0"
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B1BF
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 01:12:26 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1e58a522e41so1090682fac.2
        for <git@vger.kernel.org>; Sat, 21 Oct 2023 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697875945; x=1698480745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYZj8t5hRuyBu3l7OTTy+OS5V7gIPnJQw9CljBsfOYk=;
        b=jllKC6u0PY0UOW9kMclwPk/nnF4mhPHtSz96jccftNiLCDIEOOs79+BDvsDhQKxCco
         +E/qDzQmxJK/cf/cf/dsilwG0hhVn7L+CSwXfwlgUd7y4JTKwJT5eVOvXH6Q2F0J81TE
         UfawFhWLM5ykvEHrsGotTecS750tAC/KnhhOmWZhLY8V0arp5Epv+jx7ZBFZHrRlVz6k
         e9NP8B0w1BKfIdwh4cggYnRJ++4mjz1lQPb7YuBjIPvr5Mp3mrEJ1UoCSahAaoRcL4O+
         HYsZymMMKWyAfhCF0iE6/kR9AMAkaHjT2tNkZjd6UbF396eO3ZBrEQ7w3XRbrZmMCWIn
         h1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697875945; x=1698480745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYZj8t5hRuyBu3l7OTTy+OS5V7gIPnJQw9CljBsfOYk=;
        b=Bh4MzdEeOrq0OiHZhUizKyinE9hZ5GbYADBz5DEPDnXefSjoZaA8dvCX9R78symeIR
         1rHUx/SnqtbXEIGMuu6YJ+zWYyJppA4OEJnk/0sghRd/wIvM9D0HtNmwAbB3dzvnkVHo
         aPdh5Menyaoy/Nr8eOv35YCKfWOIq6aABnje6U421BV7X2QBci+DC2pNB2P3xMoNzHhX
         8VQhPVKJtvZIdCpz8YDrtQbXI44UNsoj2Rsh0aGwkih+hSB4ZlljvKbHE0LuEvKiuDaB
         kpXvtmAe0iTQBTMYNsJPnrY4YU4fYL0StPSTLXw3pvEGXoJ3mhxlshJrsedZMK2p5gpS
         +uEA==
X-Gm-Message-State: AOJu0YxY6mvJ05z+9M6uup2oypF7sQDqj+3jgXYHfNpBzH4ZRaWPBrSy
	Mn+DuenoNgkoiGYkTKWiDFsI/UXaiY8=
X-Google-Smtp-Source: AGHT+IF7swnfYnBtYAYP309Mo0TNfWZ1cq66PvMm8eYS413z2HX0uUhF5CskNffVcYkSj7+AVWXBZg==
X-Received: by 2002:a05:6871:4c15:b0:1d6:cd8a:d99e with SMTP id ue21-20020a0568714c1500b001d6cd8ad99emr3230658oab.0.1697875945107;
        Sat, 21 Oct 2023 01:12:25 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id b12-20020a17090acc0c00b0027d12b1e29dsm4359154pju.25.2023.10.21.01.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 01:12:24 -0700 (PDT)
Message-ID: <1df77452-2355-400c-adbb-a04b2bc32602@gmail.com>
Date: Sat, 21 Oct 2023 15:12:19 +0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] typo: fix the typo 'neeed' into 'needed' in the comment
 under merge-ort.c
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?B?546L5bi45paw?= <wchangxin824@gmail.com>, git@vger.kernel.org
References: <2DB9ED79-FE58-4072-91E0-B4C51A3F6C5B@gmail.com>
 <xmqq5y32zgnk.fsf@gitster.g> <42D0A6FD-1314-4977-92E6-BF6535D82E8A@gmail.com>
 <facb06e0-9ad7-40eb-83e3-0a951931496d@gmail.com> <xmqqfs25rzo1.fsf@gitster.g>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqqfs25rzo1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/10/2023 00:06, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> On 20/10/2023 09:14, 王常新 wrote:
>>> It is my official name. But the email address is not a valid one. Should I rewrite the commit message?
>>>
>>
>> Please don't top-post, reply inline with appropriate context instead.
>>
>> Did you mean that you can't receive ML traffic on your @qq.com address?
>> If so, resend with your @gmail.com address as patch author (you need
>> to set user.name and user.email accordingly). 
> 
> Isn't that opposite from what we would normally recommend, though?
> 
> If the true authorship e-mail is in an environment where sending
> patches are inconvenient, you would still want to do your commits
> under the identity you want to appear in the final history of the
> project, so you do not futz with user.name and user.email; you'd
> send a message with in-body header that shows an extra From: line
> (followed by a blank line) that records the true authorship from an
> environment whose sender e-mail address may differ.
> 
> E.g.  You would see these fields in the e-mail heeader:
> 
> 	From: 王常新 <wchangxin824@gmail.com>
> 	Subject: [PATCH] merge-ort.c: comment typofix
> 
> and your message would begin like so (indented only for illustration
> purposes---the real one should be flushed to the left edge of the
> page):
> 
> 	From: 王常新 <real-email-address-of-mr-wang@do.ma.in>
> 
> 	There is 'needed' misspelt as 'neeed' in the source file;
> 	fix it.
> 
> 	Signed-off-by: 王常新 <real-email-address-of-mr-wang@do.ma.in>
> 
> This feature is designed so that other people, different from the
> author of the patch, can relay it to the recipient(s) while
> preserving the authorship information.
> 
> Although it is not needed in this case, you can override "Subject:"
> the same way with an in-body header, like so:
> 
> 	From: 王常新 <real-email-address-of-mr-wang@do.ma.in>
> 	Subject: real title of the patch to be used
> 
> 	There is 'needed' misspelt as 'neeed' in the source file;
> 	fix it.
> 
> 	Signed-off-by: 王常新 <real-email-address-of-mr-wang@do.ma.in>
> 
> and it would replace what we read from the Subject: e-mail header.

Thanks for the explanation! I was confused then...

-- 
An old man doll... just what I always wanted! - Clara

