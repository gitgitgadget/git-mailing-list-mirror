Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99E63D
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRsfvz4Z"
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D4DA9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:33:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-577fff1cae6so3114051a12.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698680030; x=1699284830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nP/MUsrL/owlBnhj/FX0DmkYuSx/F9NklQ+CGE4tW0=;
        b=dRsfvz4ZI+eXBFha1/j8lqBd1GhQnsAGlIi46IZkfgPlTx93j5e6AJNXuaPgLM7rs5
         kZBYwdSs0lhxy41JWlnPHJp+1dADERheorLtVv2TE+JzYVoqh9KE2i88pTYF0MvI+jnc
         Apf2kIhvbZKa4kLHKx107HqxzAYCXt+qACTN4p2tV+Achc/z9Z1EiVT0hRhrpZMfdBwx
         GKMb7kz9N/mhRRbwYm2v0aLHMInrHHalXFqC3mjahVQoUoO1HQ/P0D/Tzg0Vz2Ca5JoD
         dakuAgVfA2SLKDUfjnivSvWMI3BEkytHNzGfQ8nDWFfI8WPGcZIDkZSNhLeBHWqulkpa
         v5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698680030; x=1699284830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nP/MUsrL/owlBnhj/FX0DmkYuSx/F9NklQ+CGE4tW0=;
        b=MzXRi+jjyFvqZJ2bh/H8jHYQZYvcX6go5b60IiPekOAzBMAIec/TsQvCF8VFZ5YJME
         vtp5gswOD1cvkAH84sORjIeAkNSDtMsUg2o3HOHiQV1PjxwnKp6VyvaSFRG0hAoO/fWY
         Xls6I0/jy85szrCdnsw4UPWY18iLlksios+Zb23F2fxTGhvcWMN2i7IvNROa4gAF/88V
         STsSHlxJKYNzgAm2FffaRJvj6CltOEtMmOTsC/GIbhXAqugeGQaniQAkBpO4q14QuPEN
         Sg6FLRsJsur18SYtXkvGUlRQP47wdpuMdef2ruc1XBOBHQ487fz9PJL0/3CfHcduF/pb
         hXrQ==
X-Gm-Message-State: AOJu0YxDITqaaZbzpnsm1MfdaZUm14mYp0DwFnvM6jxw1xkJktrWBJbt
	P7tWSZwluyIbmcTjIl3nhCtO/AKsXlWpRQ==
X-Google-Smtp-Source: AGHT+IHgehW3Widv4MuJcrNdFeX8+ID6FfC503w5oSELPBB07qzTq4KRRZtjJN0cc1TKF0dIMD1nAQ==
X-Received: by 2002:a05:6a20:2447:b0:151:35ad:f331 with SMTP id t7-20020a056a20244700b0015135adf331mr11833917pzc.14.1698680030173;
        Mon, 30 Oct 2023 08:33:50 -0700 (PDT)
Received: from ?IPV6:2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9? ([2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9])
        by smtp.gmail.com with ESMTPSA id fh14-20020a056a00390e00b00689f5940061sm6267340pfb.17.2023.10.30.08.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 08:33:49 -0700 (PDT)
Message-ID: <325c742b-c909-4f43-a120-6db8b402e5f5@gmail.com>
Date: Tue, 31 Oct 2023 02:33:45 +1100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Repository cloned using SSH does not respect bare repository
 initial branch
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <63eb269e-72b9-4830-98fc-aeef8b8180d7@gmail.com>
 <20231030093605.GE84866@coredump.intra.peff.net>
From: Sheik <sahibzone@gmail.com>
In-Reply-To: <20231030093605.GE84866@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/23 20:36, Jeff King wrote:

> On Thu, Oct 26, 2023 at 07:36:36AM +1100, Sheik wrote:
>
>> Repository cloned using SSH does not use the branch configured in the bare
>> repository however repository cloned using filesystem does as expected.
>> Shouldn't they both behave the same?
> What version of Git is running on the ssh server?
>
> Your example seems to show that the parent repository has an unborn
> branch (i.e., HEAD points to "refs/heads/test", but there are no commits
> yet). I think the server-side bits you need for that to work showed up
> in 59e1205d16 (ls-refs: report unborn targets of symrefs, 2021-02-05),
> which is in v2.31.
>
> So even though your client seems to be v2.42 (from the output you gave),
> if the server is older it may not be sending sufficient information.
> There were also some other fixes on top of that, but I _think_ they were
> all client-side (so your v2.42 clone command should be doing the right
> thing).
>
> -Peff


Confirming your observation above, yes this is a purely new bare 
repository which has no commits yet before cloning.


Thanks

Sheik

