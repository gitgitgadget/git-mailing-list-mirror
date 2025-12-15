Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1B2C0F97
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800902; cv=none; b=MawSLauBoShJFESbA6iQ2TGo+Y5vxXQ8v5eF3l1ZO0eh/KoEYm/kjXDI9pC/A0LPhByaIBNxoQrjnMK9UyeMNMTxLGYOkM7Lnkj7+uuCE8f5gDwSMbmbD8TRwtecpUbxNuhgptUOCSuTSpUXxJ3cVNOrCKGfLFB8KWTPZ2WQntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800902; c=relaxed/simple;
	bh=y8qVNcN2//2pOsm54CY4BDmecy4GPW6ntXymn61v9NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3SsJeDkrlLmjGdhaJjvaKeeOglxNua5FlLPfzH/63U+968DfCxZy7x2sqS5YQiyxm2bDluh9r2ghSahRJP8pdS/UaXu/E64bxwbKDcSLAjUdsdwAgywj37/nZvGmM9Kx/vBMhsIVqUAm39T8Bp23OLItLgjrlnO17/4HedFnn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Y81qMmZH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Y81qMmZH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xkeUO4z6GWh1xhxTM1y9/ICm2rzOyUh+ESXHpDNJEUg=; b=Y81qMmZHBH61SMGCI17JHBaank
	4X1j8r7HmUa8TiWfXJqujXob9Okc/nCmmvX0MhPdPHyzI+ueH+lySwTGTLH97JnodIBSEQCdJrNA0
	DPns+TRmdJhTMLyErJybB/64gyzktLYF66ey1pUsK7/bzyoCMoXwcXI8YmyA6xA/5ZDbv4403c3n+
	L+WMbyF9EYXqi+TbyNjed+tl8lesxGzlCACP0XvzwyRzXpW5IuMRQdGVO6IVk6TqikRicLRfMxxaC
	d4RtES4wqIj8ylXMAcLWUZZMYDOt5Z8aUuLzuNAzpMg4M95RmljLiI8Qi/w3HJYeHSjnV9h9cE8Pd
	i5NWx18w==;
Received: from [91.117.33.88] (helo=[192.168.1.137])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vV7Td-00CvkY-F1; Mon, 15 Dec 2025 13:14:57 +0100
Message-ID: <df0641d3-33d6-4d11-a931-0a8b12ab1c5a@igalia.com>
Date: Mon, 15 Dec 2025 13:14:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] scalar: document config settings
To: Derrick Stolee <stolee@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, atthewhughes934@gmail.com,
 johannes.schindelin@gmx.de
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <ac1627dbd94e3330117fbaeac2e2373104aef531.1764607847.git.gitgitgadget@gmail.com>
 <e19246a7-40db-41d0-9cdf-817833123f45@igalia.com>
 <e1d51a8f-582f-425e-9682-c93411b4d090@gmail.com>
Content-Language: en-US
From: Henrique Ferreiro <hferreiro@igalia.com>
In-Reply-To: <e1d51a8f-582f-425e-9682-c93411b4d090@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/12/25 3:06 PM, Derrick Stolee wrote:
> On 12/11/2025 9:20 AM, Henrique Ferreiro wrote:
>> On 12/1/25 5:50 PM, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <stolee@gmail.com>
>>>
>>> Add user-facing documentation that justifies the values being set by
>>> 'scalar clone', 'scalar register', and 'scalar reconfigure'.
>>
>> Hi Derrick. I was planning to contribute a patch removing some config
>> options so I'll take this opportunity to just discuss those here.
>>
>> My motivation is that some of the options seem to be related to things
>> other than performance and the list is huge, so I believe that some
>> options don't belong to scalar.
>>
>>> +REQUIRED AND RECOMMENDED CONFIG
>>> +-------------------------------
>>
>> There's no mention on which configs are required and which are
>> recommended, and it looks like none are actually required so maybe just
>> remove REQUIRED.
> 
> You're absolutely right. Good eye! I started this documentation before
> going back and removing the "required" configs.
>   
>>> +am.keepCR=true::
>>> +core.logAllRefUpdates=true::
>>> +credential.https://dev.azure.com.useHttpPath=true::
>>> +http.sslBackend=schannel::
>>
>> These options are not related to performance. Why not keeping them out
>> of scalar?

It appears you missed my question above.

>>> +core.autoCRLF=false::
>>> +core.safeCRLF=false::
>>> +index.threads=true::
>>
>> These options just duplicate the default settings.
> 
> We did find that index.threads=true gives something more when explicitly
> set, so there is currently value in keeping it explicit.
> 
> The CRLF configs are sometimes set globally on Windows systems, but we
> want the local repository to override those global settings for
> performance reasons.

Given that this is just a possibility, and also that it only affects a
subset of users, wouldn't it make more sense to instead check for those
settings in the global config, and only if they are enabled override
their value or just show a warning?

>>> +feature.manyFiles=false::
>>> +    This disables the "many files" optimizations grouped under this feature
>>> +    config. The expectation is that all valuable optimizations are also set
>>> +    explicitly by Scalar config, and any differences are intentional.
>>
>> I disagree with this reasoning. This thread was actually brought to my
>> attention when working on setting manyFiles to true in scalar:
>> https://github.com/git/git/pull/2125.
>>
>> Do you foresee any features that would apply to scalar but not to
>> manyFiles? I'd even say that some scalar options could be moved to
>> manyFiles instead, so that people that don't use scalar can benefit too.
> 
> I suppose that the default reason is that registering a repo with Scalar
> already enables some config in an "indirect" way and having it rely on
> features.manyFiles would be another layer of indirection.
> 
> The historical reason is that we initially didn't want changes to the
> features.* config settings to automatically be assigned to Scalar. I
> think this is more important on the features.experimental side, as
> the intention of features.manyFiles is very similar to the intention of
> cloning/registering with Scalar.
> 
> For now, I'm going to leave this as-is, because we have enough changes
> to the config settings and documentation. You can submit a change on top
> of this one to demonstrate the value of setting features.manyFiles=true
> and how that impacts the code in its new shape.

OK. I'll do that, thanks!

> Thanks,
> -Stolee
> 

