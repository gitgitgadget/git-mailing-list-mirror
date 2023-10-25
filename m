Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E441A58E
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2AmQnAl"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B174DC
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:44:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083f613275so46432695e9.2
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698245075; x=1698849875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MVg1AJzQGvKUkCUjSo/QSgHwyl/zhMWjs+ES9VrIvFs=;
        b=m2AmQnAln97inYRshbV+TCLomJOJZf5BOCYRJnJu5rzs3b7zaI/QXH5mdUtFwlJjPU
         cBezcQH9NPFINflBPxlG6eOnLPor3ZFjMAm36YdaxdnW4KJHJCaTSNBKn0jOnVe0ikgj
         PAyt6pOxGvXjcXBc+1UdbSZlx1YnjyXJg3QYAg7mvTvZmjhNbwJWmfe/S+71QkZdu2Fn
         iDw/gMx9Z6UI0HdmVYRpC3r0HboPo307Acm5d7MfLTBsUEZdm09ORNpO/y9RHviBuibk
         GadMfQ6X3n7Nl1bq/9vSHEjVgXZpDFLMU/MWGJf2kPneP5940KTgEri9ykGSWH9PdgRJ
         tneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698245075; x=1698849875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVg1AJzQGvKUkCUjSo/QSgHwyl/zhMWjs+ES9VrIvFs=;
        b=bNeoS7k5/bo6aGKFub6apLPlj22LIKTufLegvCmZmoA+es9wTdNqfg3PRVzDroU2c/
         WH+H9DWIOfBd8vsfQhJoJ9EXsl+HY0HxEJ6FchXv/2y1DkREKmx4CX7Pd2bYXd+uC44n
         FBYGCxd0x5Sj8d0eHrkVgK5jVm+tRmFy6HKfFpJ+OEf92y7XrPJpPzRuY07lBefFp73S
         g5bU0/iXi7OK3+0drdqC8DcAbSC4NRsS/U8VMoMJhN9FqZCuKQw+X1o7TViANzeS0lyE
         KRJTZnBrvcYlVEzYw1yyhnODXVsFG4EcV1JwtLpEq1HtAwTtQMR/qh3UUmv4ytxyl6NG
         LxwA==
X-Gm-Message-State: AOJu0Yxs98cpYt+feayGPc2c74fDsNEBpmvUPyzErhZqV9/tVz2nYELq
	JwAHwzHX+cTMQ+DdqebYb/qj7YcUtb0=
X-Google-Smtp-Source: AGHT+IHoVw+jxN1fujVmaiTR1fmVtz/RWDIxkiQsFv4ncL5Bp3Yl+uIo2vU/SAk3bi3IqS9QdVYJJw==
X-Received: by 2002:adf:e590:0:b0:32d:8357:42dd with SMTP id l16-20020adfe590000000b0032d835742ddmr10556954wrm.68.1698245074456;
        Wed, 25 Oct 2023 07:44:34 -0700 (PDT)
Received: from [192.168.1.12] (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d470a000000b0032d9efeccd8sm12239931wrq.51.2023.10.25.07.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 07:44:34 -0700 (PDT)
Message-ID: <f87c95d6-b1e5-45c7-b380-bdc8b8143ab9@gmail.com>
Date: Wed, 25 Oct 2023 15:44:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/12] show-ref: introduce mode to check for ref existence
Content-Language: en-US
To: Han-Wen Nienhuys <hanwen@google.com>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1698152926.git.ps@pks.im> <xmqqttqf3k5a.fsf@gitster.g>
 <CAFQ2z_PqNsz+zycSxz=q2cUVOpJS-AEjwHxEM-fiafxd3dxc9g@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAFQ2z_PqNsz+zycSxz=q2cUVOpJS-AEjwHxEM-fiafxd3dxc9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/10/2023 15:26, Han-Wen Nienhuys wrote:
> On Tue, Oct 24, 2023 at 9:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> this patch series introduces a new `--exists` mode to git-show-ref(1) to
>>> explicitly check for the existence of a reference, only.
>>
>> I agree that show-ref would be the best place for this feature (not
>> rev-parse, which is already a kitchen sink).  After all, the command
>> was designed for validating refs in 358ddb62 (Add "git show-ref"
>> builtin command, 2006-09-15).
>>
>> Thanks.  Hopefully I can take a look before I go offline.
> 
> The series description doesn't say why users would care about this.
> 
> If this is just to ease testing, I suggest adding functionality to a
> suitable test helper. Anything you add to git-show-ref is a publicly
> visible API that needs documentation and comes with a stability
> guarantee that is more expensive to maintain than test helper
> functionality.

Does the new functionality provide a way for scripts to see if a branch 
is unborn (i.e. has not commits yet)? I don't think we have a way to 
distinguish between a ref that points to a missing object and an unborn 
branch at the moment.

Best Wishes

Phillip

