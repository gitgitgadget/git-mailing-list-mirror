Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66733D3
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpzrMPd3"
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1494BD
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 11:23:21 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce291b5df9so2252774a34.2
        for <git@vger.kernel.org>; Sun, 29 Oct 2023 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698603801; x=1699208601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQnCc9R2Rf1vEs+9OMiafawIv+MhuzJTQzKKqq3PRgg=;
        b=UpzrMPd34yx5AlxQnST00COIl/SE4JrnTXfOKeCo8POy2gNrXVTnTceldK7YxmowLm
         /IcGJH+pfuapz65TWmHvwmzNdHhbQ+dqBY7PeBKDea7WMad8FKeR3xIK2/LRV7ndT2GD
         TSwAd34/hYe3VNe6hRD3RmsVtPCcdojh49hShJQ9pd4V58Kj60jLBTlwY0vdQwNco7Ei
         uN2+0H5qcwDcB/K0Yea63iMhgNbSQuv+znEIJpAbNd+zPKGoxssiYpGFjNCkRufPAVMC
         fZ9nVy06QPM7+Ts2D1JW6+4w/AuUb2ASTKUKjDW+VO977Sww5s1WAtM32p8RlQvykOwx
         D6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698603801; x=1699208601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQnCc9R2Rf1vEs+9OMiafawIv+MhuzJTQzKKqq3PRgg=;
        b=R55564IzEr/IEh6hh7x+H/a+t7Xs3C/jkOiMO9ERy9gMpEOasS1mOqCAABYtfNtgai
         J5kX2DbGk5V4WkeqHg7i8CYyncXnhlO8XXm/faYXTrkmtBbOWmKVSprTSVFzH2LJSees
         kbyqpaM0TOWs4lGtI4Hh+LMjVqD7NZ7m/z7C8UGtXwsqPnZMhz3wKTzf0H4IPESka2QK
         Hcqqxd/30mcPZ2Hw1I+9yXw+dhHk/BTDzp8BXLoppTSCvZeNEt1U/mJ8tcE7QmMlk50u
         km8pus4nM08JjPUORgRmUFEnSWy5pb5B4m5HoKXSDDgPBSA5GMk/cAS7YmWy8NTk36h7
         zJPA==
X-Gm-Message-State: AOJu0YyaCbfPOvToo75DULHHEpyW8+VMKNwcZe59XrFIVYuDuY1fF5tD
	fDC9WXitziCqOFny7J9MTA8=
X-Google-Smtp-Source: AGHT+IEbYGzoMYixC+YZXtBSf4jdGElz/dKj7ARIJDhezv6mdJBilFo5JgZMK0fAUaSQL1OaNkq5Mg==
X-Received: by 2002:a05:6358:6f1a:b0:169:4412:b6ef with SMTP id r26-20020a0563586f1a00b001694412b6efmr11714922rwn.7.1698603801000;
        Sun, 29 Oct 2023 11:23:21 -0700 (PDT)
Received: from [192.168.208.87] ([106.51.149.129])
        by smtp.gmail.com with ESMTPSA id nn16-20020a17090b38d000b0026b70d2a8a2sm4219012pjb.29.2023.10.29.11.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 11:23:20 -0700 (PDT)
Message-ID: <f0378755-fd97-4624-b0c2-63844de762b9@gmail.com>
Date: Sun, 29 Oct 2023 23:53:14 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in Outreachy? (December, 2023)
To: Christian Couder <christian.couder@gmail.com>,
 Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>,
 Victoria Dye <vdye@github.com>
References: <ZNwhVOggObU7aVTr@nand.local>
 <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
 <2c31a3d4-59f7-d036-0c6b-5fd62cc7a2fa@gmail.com>
 <ZOZSo7vJztHcvb4W@nand.local>
 <435a2aa3-59f8-d2bc-f653-4f93d86b9c31@gmail.com>
 <ZO4wxU1ilpa6/3EW@nand.local>
 <CAP8UFD2CGf8efBHquS=LJP8uQ5ivuDryqGz96PZ81oDtrNgNXw@mail.gmail.com>
 <ZQyrllWhLDebWCG0@nand.local>
 <CAP8UFD3i5ewCoaZOh09TtfuefEtWL4+z8P0_Z9DWdYCrShYheQ@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAP8UFD3i5ewCoaZOh09TtfuefEtWL4+z8P0_Z9DWdYCrShYheQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian and Taylor,

Excuse the huge delay in my response. I got too pre-occuppied with some
other commitments.

On 22/09/23 11:49, Christian Couder wrote:
>>
>> On Tue, Aug 29, 2023 at 10:38:45PM +0200, Christian Couder wrote:
>>> By the way, Kaartic, do you still want to be an org admin? And Taylor
>>> are you Ok with Kaartic being an org admin?
>>
>> Sorry that this dropped off of my queue. FWIW, no issues from me.
> 
> Taylor, thanks for your answer!
> 
> Kaartic, if you want to be org admin, just ask on the Outreachy web
> site and we will accept your request.
> 

Thanks for the offer!

I think we're very close to the end of the contribution period of 
Outreachy. I think the contribution period is the on that would've 
needed significant participation of an Org Admin. I'm not sure if 
there's anything I could contribute to much in coming days. If there's 
anything I could help with, kindly let me know. I'll be glad to help :-)

-- 
Sivaraam
