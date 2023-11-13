Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531DB21110
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBe1205Y"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B068C19BC
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 07:07:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40806e4106dso26445835e9.1
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 07:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699888039; x=1700492839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=paQwE5ny6q8EGeu8/PNPaOZZvxKN7mH/U4F65wW/gAY=;
        b=CBe1205YEDX/zU/Kahg3tFve/17oeF2eQH2Qn5IdVmhgRCu3WCtr+CTmjCAMORy0uh
         5bjIgOmIbfIHSuDbh4poVR8vnHJoXthywZfmsOlg5lqOZqgGANOXNCt5BetvTGgnU1+D
         iq9+Gntn8Ikwg+rm6PEXpCEI5xEJCr26TWEHISyxTZffcR8+bg7l6YEbPGb9oz7vDMjU
         EHrFjLPUmZiXuA7HdQUc/DVSt9mKzUXuQUGlFTQ5M2/WhmHXFgAsYAaf3jekXivpjkNq
         HTTplxAStd466bnIag5FqWFUcX3pQQlYEszg31AlUVvt4n/tY05Xl5gdFVmMu0J4wLpo
         zKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699888039; x=1700492839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paQwE5ny6q8EGeu8/PNPaOZZvxKN7mH/U4F65wW/gAY=;
        b=wQcAipPGDTvuBBZ4r9h/FR4snDr8IQG/7tGNH9mG5rGXmUFzNYJ7aLxSsG6S70Brag
         bKaq91zE+iQlcnxbd5brc66W+hPPiGLcD1fa4lPiag0QcTpUI8ivoACXKfPh0KCf41I0
         /NMMuOFwvlcY4a43OMjS/vau+a0nvRBk8yiiEPIA7FLI7ImRg69xP2K/e7wCro4uyPQP
         cSajEJgZh2HiN7/kK0NdeZZuUpfwYsvgsnP4sGbooTBT88TPVfL/lXg8s2f2QBHUdk/u
         MV9FPpPuzEgl+yg6FxOuk+M5VGomd3glGI2bSoP3ufVEcFYVVW2kUwGTZXi6XiMvAsv9
         FETw==
X-Gm-Message-State: AOJu0YwynA90TDFCTPIbUxR2i3+wq4wKDy5VzWE5r86IanG5hoCDZnlg
	HDF07ou+GVYnCDjwq/cnKKZ52S2SeG0=
X-Google-Smtp-Source: AGHT+IGsvLIQsMh1sCcAxSF0nA1Lt+4ffS0pbPI5ZsBKvWtZ1xPGfQC6PQS3+sPjF6xiNaEILs64Og==
X-Received: by 2002:a05:600c:1d09:b0:400:5962:6aa9 with SMTP id l9-20020a05600c1d0900b0040059626aa9mr9629823wms.11.1699888038419;
        Mon, 13 Nov 2023 07:07:18 -0800 (PST)
Received: from [192.168.1.212] ([84.64.93.134])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c154a00b004063c9f68f2sm8342443wmg.26.2023.11.13.07.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 07:07:18 -0800 (PST)
Message-ID: <0e37ee23-922c-4bbf-82c3-8f44e9216ab0@gmail.com>
Date: Mon, 13 Nov 2023 15:07:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add config variable checkout.autoDetach
To: Junio C Hamano <gitster@pobox.com>, Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, pclouds@gmail.com
References: <20231111224253.1923-1-andy.koppe@gmail.com>
 <xmqqbkbzo6ba.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqbkbzo6ba.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/11/2023 06:04, Junio C Hamano wrote:
> Andy Koppe <andy.koppe@gmail.com> writes:
> 
>> The git-checkout command without pathspecs automatically detaches HEAD
>> when switching to something other than a branch, whereas git-switch
>> requires the --detach option to do so.
>>
>> Add configuration variable checkout.autoDetach to choose the behavior
>> for both: true for automatic detaching, false for requiring --detach.
>>
>> Amend their documentation and tests accordingly.
>>
>> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
>> ---
> 
> "switch" was meant to be an experimental command to sort out this
> kind of UI ideas, and I think the fact that it requires a more
> explicit "--detach", where experienced users might just say "git
> checkout that-branch^0", has established itself as a more friendly
> and good thing to help new users.  I do not know how others react to
> this kind of proliferation of configuration variables, but I do not
> mind this particular variable existing.

I'm a bit wary of having a config variable that could break scripts 
relying on the current behavior of "git checkout". As far as "git 
switch" goes I don't particularly mind this config variable though I'm 
not sure it is that hard to type "--detach" (especially with tab 
completion) and I do worry that we're making the UI more complex each 
time we add something like this.

Best Wishes

Phillip
