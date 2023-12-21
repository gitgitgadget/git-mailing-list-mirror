Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52114AF79
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTV3crsM"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336755f1688so803821f8f.0
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 07:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703171163; x=1703775963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBcaRmSqy08pp9rXUPwWaBpCV8gQSfVxpzsfBrBmHRg=;
        b=jTV3crsM3J2NekwmPPuSOyqy9xf27HOPou25/xieEgok+0J4lD+Cdt9N+KZ0E3kq9A
         KODC25lJQl41IPjgY7SVIy/6Ogf8lBBrq55l4lbq2EWusRgyyem6ZI0QSxa81+wxl8N5
         snNef6qOWapby2MhKPjbwi7K1rtNgKbJw5iZGRvQ710B4NmeUZf9dgSAuT7TgN9M6gBz
         O04YHw7+m5UYXrJAILRik6U4AQ8lD68bVgmLMmi1Dcxcor3+TyOnbXhCDKBby2XDqbyz
         DWAI7oJA5FCtDbilYwU41B+qOFOKmgH1dXrQHmPXZ7UW5PEdWwQ241YVWK37TxLPcbC/
         2KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703171163; x=1703775963;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBcaRmSqy08pp9rXUPwWaBpCV8gQSfVxpzsfBrBmHRg=;
        b=RWuSeTDE73joGEhSssT8zegEeOhIQhMv47lLxLToX4C4iBWzX2v0Iu3aJyvQ00UPUT
         L+3SdJvOAdBF3ccO6b3KxlLnyQS0/JIYqkXIa+LWtwtPSNgYwOBFWcmvfA/jn6YR28/P
         rsTAFCHIQExYHRHjoYt+1ETCK4tLkAza4Z5R6xy5imc5n1oKb/Jizag6zctZ690NBvcX
         jFXfK79QnPOdfxgVM3ncgXkAQ6IQm6Yr7oIjCEQNE75q41ZWkifOFC8y60pnOy2Xj4Pb
         9vjjJMaP0C8q8mYxuaGo+TijCe0j8hpsC9lb+HbS/d1hc9ofIi2YWW1gqV77ZvxL1o+o
         o+kQ==
X-Gm-Message-State: AOJu0YyL/7eQ3aRq4YD87ctrCVLDzlQFxzsHaONI1DYOZ2YZd1JAQ2Xd
	KouvMmeaSvYvS+in4FlSAPA=
X-Google-Smtp-Source: AGHT+IHO1a6QXZ4SXMfedXBSZJm7J1Sl4BSvrlZJGXa16X1lYZtm12oI6l4B87y3FNkkLf90BzPhSg==
X-Received: by 2002:a5d:4111:0:b0:336:9ec:683 with SMTP id l17-20020a5d4111000000b0033609ec0683mr879059wrp.24.1703171162608;
        Thu, 21 Dec 2023 07:06:02 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id z5-20020adff1c5000000b003366e974cacsm2202644wro.73.2023.12.21.07.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 07:06:02 -0800 (PST)
Message-ID: <23d47364-9ec2-4273-8ea5-f106550e125a@gmail.com>
Date: Thu, 21 Dec 2023 15:06:01 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
Content-Language: en-US
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 AtariDreams via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Seija Kijin <doremylover123@gmail.com>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
 <20231213080143.GA1684525@coredump.intra.peff.net>
 <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
 <20231214220503.GA3320432@coredump.intra.peff.net>
 <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com>
 <20231221095606.GB570888@coredump.intra.peff.net>
In-Reply-To: <20231221095606.GB570888@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Peff

On 21/12/2023 09:56, Jeff King wrote:
> On Fri, Dec 15, 2023 at 02:46:36PM +0000, Phillip Wood wrote:
> 
>>> Yeah. b2() is wrong for passing "2" to a bool.
>>
>> I think it depends what you mean by "wrong" §6.3.1.2 of standard is quite
>> clear that when any non-zero scalar value is converted to _Bool the result
>> is "1"
> 
> Yeah, sorry, I was being quite sloppy with my wording. I meant "wrong"
> as in "I would ideally flag this in review for being weird and
> confusing".

That makes sense, it certainly is confusing

> Of course there are many reasonable cases where you might pass an
> integer "foo" rather than explicitly booleanizing it with "!!foo". So I
> do agree it's a real potential problem (and I'm sufficiently convinced
> that we should avoid an "int" fallback if we can).

I had a look at gnulib the other day and the list of limitations in the 
documentation of their <stdbool.h> fallback makes it look quite 
unattractive. They helpfully list some compilers where _Bool is not 
implemented (IRIX, Tru64) or does not work correctly (HP-UX, AIX). As 
far as I can see all the bug reports cited are from 2003-2006 on 
obsolete compiler versions, hopefully _Bool is better supported these days.

Best Wishes

Phillip

> -Peff
