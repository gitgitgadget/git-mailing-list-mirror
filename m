Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP6e41CC"
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC2083
	for <git@vger.kernel.org>; Mon,  4 Dec 2023 06:18:44 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c0e37cfafso5133595e9.0
        for <git@vger.kernel.org>; Mon, 04 Dec 2023 06:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701699523; x=1702304323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0ml+A6RkU9C5VIWr2p3EGtKfYBX+VVHGe4NNGL7d+s=;
        b=OP6e41CCfFMIC++nijHWGt2EBwCnIlh/hlQW/YGlkgPguecJFO1UWMcLcZAvDrEfY/
         FBnZCmDJ0x7TXwLIWDCAlIWeJdgCFXjIyQjfDgvEzmaEPkJ+EZOp1Z8bo5inR3HCa9mp
         Je2qPBpTt/p2EZlS3NnkCpSKBz2NL7tAXuxbD9Gpn+NjtlUFc9/NcOAp0oHUH27QPrCg
         ywolRLd9uTsTJlsuYp2GqeF5dkl8WgYh/oWSrAU9fpDgwFKlwQLRA10A09KwRG0lK7Ek
         NxKkcizqzy0NC16AJUUkGpHsrD28rjkVFAAdZkngyaxgxdyYqYNEVAe6BNlvRoFPDD/B
         LLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699523; x=1702304323;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0ml+A6RkU9C5VIWr2p3EGtKfYBX+VVHGe4NNGL7d+s=;
        b=Ra5XN5/8LHEh5gl9u6lSUa7hVqlIEOSD0hXtGPT8aSF6EFkwhnqhNAWcsviwtNKSB8
         axd9wXPr1OoLsD0Qkwligu87Z1a4RR8gxztKP+BtozK8PuknUeKwXsi2KPz7E1cDWlLv
         fipJ5n6JFf+HJ0v0aktBQtS0Npqs+mO+POjJ9Y8uB4JhZtP4TTLLl7LwspVR8v9HKH/P
         sXhgv02swlpNoZwIor/m6ZOj38U4KSs41jFOYm/e5xBgfGfZuzjgpOZxDare6EQItV9W
         QsqsVwNMHEPmhzqHbmmk0L5KxOgKH+Z8UVBRA7LbWKNCz3ykKinaffl5ICLTNgZG9GEn
         WFqQ==
X-Gm-Message-State: AOJu0Yw/zQVr+JJS3gWIJlr3DhFrce2n31ZFcJ27387nu1F4wx5upceT
	JaYciXwYKWzHal0hIJytRNM=
X-Google-Smtp-Source: AGHT+IFE9kXKwyWfZfflj1tGgnNLtZeAipjqn8KqUoSIAVer68/yM9iML1EHrtFjgo8IstMUsuL6ew==
X-Received: by 2002:a7b:cb02:0:b0:40b:5e21:d359 with SMTP id u2-20020a7bcb02000000b0040b5e21d359mr2534322wmj.98.1701699522847;
        Mon, 04 Dec 2023 06:18:42 -0800 (PST)
Received: from [192.168.1.212] ([90.247.162.103])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b0040b3d8907fesm15217553wmo.29.2023.12.04.06.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 06:18:42 -0800 (PST)
Message-ID: <808ca23e-76dc-4435-b1f9-4bd2cdca3acc@gmail.com>
Date: Mon, 4 Dec 2023 14:18:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 3/4] refs: complete list of special refs
Reply-To: phillip.wood@dunelm.org.uk
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, hanwenn@gmail.com
References: <cover.1701243201.git.ps@pks.im>
 <0e38103114a206bedbbbd7ea97cb77fa05fd3c29.1701243201.git.ps@pks.im>
 <15f67e21-c05f-4a72-9557-2a09a1311f25@gmail.com> <ZWmAn20UYWBo9i8C@tanuki>
Content-Language: en-US
In-Reply-To: <ZWmAn20UYWBo9i8C@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 01/12/2023 06:43, Patrick Steinhardt wrote:
> On Thu, Nov 30, 2023 at 03:42:06PM +0000, Phillip Wood wrote:
>> Hi Patrick
>>
>> Thanks for working on this. I've left a couple of thought below.
>>
>> On 29/11/2023 08:14, Patrick Steinhardt wrote:
>>> +static int is_special_ref(const char *refname)
>>> +{
>>> +	/*
>>> +	 * Special references get written and read directly via the filesystem
>>> +	 * by the subsystems that create them. Thus, they must not go through
>>> +	 * the reference backend but must instead be read directly. It is
>>> +	 * arguable whether this behaviour is sensible, or whether it's simply
>>> +	 * a leaky abstraction enabled by us only having a single reference
>>> +	 * backend implementation. But at least for a subset of references it
>>> +	 * indeed does make sense to treat them specially:
>>> +	 *
>>> +	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
>>> +	 *   carries additional metadata like where it came from.
>>> +	 *
>>> +	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
>>> +	 *   heads.
>>> +	 *
>>> +	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
>>> +	 *   rebases, where keeping it closely together feels sensible.
>>
>> I'd really like to get away from treating these files as refs. I think their
>> use as refs is purely historic and predates the reflog and possibly
>> ORIG_HEAD. These days I'm not sure there is a good reason to be running
>>
>>      git rev-parse rebase-merge/orig-head
>>
>> One reason for not wanting to treat them as refs is that we do not handle
>> multi-level refs that do not begin with "refs/" consistently.
>>
>>      git update-ref foo/bar HEAD
>>
>> succeeds and creates .git/foo/bar but
>>
>>      git update-ref -d foo/bar
>>
>> fails with
>>
>>      error: refusing to update ref with bad name 'foo/bar'
>>
>> To me it would make sense to refuse to create 'foo/bar' but allow an
>> existing ref named 'foo/bar' to be deleted but the current behavior is the
>> opposite of that.
>>
>> I'd be quite happy to see us refuse to treat anything that fails
>>
>>      if (starts_with(refname, "refs/") || refname_is_safe(refname))
>>
>> as a ref but I don't know how much pain that would cause.
> 
> Well, we already do use these internally as references, but I don't
> disagree with you.

I should have been clearer that I was talking about the refs starting 
"rebase-*" rather than FETCH_HEAD and MERGE_HEAD. As a user find it 
convenient to be able to run "git fetch ... && git log -p FETCH_HEAD" 
even if the implementation is a bit ugly. As far as I can see we do not 
use "rebase-(apply|merge)/(orig-head|amend|autostash)" as a ref in our 
code or tests.

> I think the current state is extremely confusing,
> which is why my first approach was to simply document what falls into
> the category of these "special" references.

That's certainly a good place to start

> In my mind, this patch series here is a first step towards addressing
> the problem more generally. For now it is more or less only documenting
> _what_ is a special ref and why they are special, while also ensuring
> that these refs are compatible with the reftable backend. But once this
> lands, I'd certainly want to see us continue to iterate on this.
> 
> Most importantly, I'd love to see us address two issues:
> 
>    - Start to refuse writing these special refs via the refdb so that
>      the rules I've now layed out are also enforced. This would also
>      address your point about things being inconsistent.
> 
>    - Gradually reduce the list of special refs so that they are reduced
>      to a bare minimum and so that most refs are simply that, a normal
>      ref.

That sounds like a good plan

>>> +	const char * const special_refs[] = {
>>> +		"AUTO_MERGE",
>>
>> Is there any reason to treat this specially in the long term? It points to a
>> tree rather than a commit but unlike MERGE_HEAD and FETCH_HEAD it is
>> effectively a "normal" ref.
> 
> No, I'd love to see this and others converted to become a normal ref
> eventually. The goal of this patch series was mostly to document what we
> already have, and address those cases which are inconsistent with the
> new rules. But I'd be happy to convert more of these special refs to
> become normal refs after it lands.

That's great

>>> +		"BISECT_EXPECTED_REV",
>>> +		"FETCH_HEAD",
>>> +		"MERGE_AUTOSTASH",
>>
>> Should we be treating this as a ref? I thought it was written as an
>> implementation detail of the autostash implementation rather than to provide
>> a ref for users and scripts.
> 
> Yes, we have to in the context of the reftable backend. There's a bunch
> of tests that exercise our ability to parse this as a ref, and they
> would otherwise fail with the reftable backend.

Ah, looking at the the man page for "git merge" it seems we do actually 
document the existence of MERGE_AUTOSTASH so it is not just an 
implementation detail after all.

Best Wishes

Phillip

