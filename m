Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FktUH/Gr"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB574D50
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 10:53:44 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so1114298b3a.3
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 10:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700765624; x=1701370424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8DWtaXDqIjRjUIWP/Nmhf470CaoLMCCm9D5eaP1ILSU=;
        b=FktUH/Gr8sZECbqfXm9N39WmAm98Pi1I4upw3+N9wMHD0FuhtRYNzvE/HZIawiN+2H
         b0CiJB6Q8NWHtPAZ9ijQ1bzANW4DUpflOMUm+2ve5ZKhwDz6W81KfA6Ev6cnwlX24uOx
         edIqE+MnXt9g0E1aLMVBnvTgEQvKbfsjxjdYmHzFGrAvxNWamtbRmrF0p7Sz7Vf5259v
         JhZNNHRJ6k9sz7HHGrBp8MrgrisITPBxtY6TdRsUJzJ2eRP2SLIRXapWgZ1+lViH8SW8
         /3/wSDXczVcyaSd8+AFbLCCUhMNS9wd0uh8B/UUPk5fyGpaHiQpopI3hTuIJh9n/5pbp
         Qiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765624; x=1701370424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DWtaXDqIjRjUIWP/Nmhf470CaoLMCCm9D5eaP1ILSU=;
        b=X9qnUI3pnWCHyPT8fCwWYTMZHkS79Zvng7QOGAXshaDe5a7dNXNe4gksbolaNzTPfi
         URxeIX28CdLkpRb+bk/qbcnRqzVpiaYaBS16OZ5t3QJHaY3JG9BxCqon1J2do7YghsQa
         ah/mkKifT0BJDRV8OUHShTUylU7o+WgeHOycG0v0BT/msoUs9b/ejtlAAxZDw2LmQgwO
         f8hXCG/hfyEI1Dor5ku0JtS2+xc8NivmY5QG6FIBwjF2W9IoHNdBrez9m1fcbQe6ossz
         E6LvnE3U0a7cEzf8v4Yv1/oHceOYpLsOeBIms8VKNQ7mwoRfJOzRfKOvHHRfE1zSnV5h
         CibA==
X-Gm-Message-State: AOJu0YwYu/+eB8idetbH100b8t5usFNbmQBJFyPWmbasYBsE09/bnxqO
	WkahpaZm/F+8ZK3Pyeqk6dk=
X-Google-Smtp-Source: AGHT+IHo1qsvZXBA+osPEQBpkAuZg7VBwg4ZOWFlmsXFdMhcmlvFHtKW1uvRet4o3/tp4PQ6uRi6Kg==
X-Received: by 2002:a05:6a20:3d8a:b0:18a:d4d5:8559 with SMTP id s10-20020a056a203d8a00b0018ad4d58559mr605510pzi.51.1700765624340;
        Thu, 23 Nov 2023 10:53:44 -0800 (PST)
Received: from [192.168.208.87] ([106.51.149.242])
        by smtp.gmail.com with ESMTPSA id r23-20020aa78457000000b006c3069547bfsm1547968pfn.79.2023.11.23.10.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 10:53:44 -0800 (PST)
Message-ID: <807be06c-e70c-4ee4-8851-bb8d82b68ac2@gmail.com>
Date: Fri, 24 Nov 2023 00:23:40 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Migration of git-scm.com to a static web site: ready for
 review/testing
Content-Language: en-US
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Matt Burke <spraints@gmail.com>, Victoria Dye <vdye@github.com>,
 =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, git@vger.kernel.org
References: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

On 17/11/23 18:55, Johannes Schindelin wrote:
> 
> To that end, I deployed this branch to GitHub Pages so that anyone
> interested (hopefully many!) can have a look at
> https://git.github.io/git-scm.com/ and compare to the existing
> https://git-scm.com/.
> 

Thanks for hosting it to easily check things!

I gave a quick try at the search and it seems to be behaving a bit 
strangely.

For instance, I searched for 'commit' and 'log'. I was hoping to see the 
corresponding reference page show up in the results but they don't seem 
to show up. At least they don't show up in the first few results. They 
show up in the first few results in the existing site.

Here are some screenshots:

Existing site: https://ibb.co/pZHx9TM

New site:
https://ibb.co/dMpNth3
https://ibb.co/h26J5Rx

This not always the case, though. Some terms like 'checkout' seem to 
bring the relevant results properly in the top results.

-- 
Sivaraam
