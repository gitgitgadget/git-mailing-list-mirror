Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E32C11D5
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250183; cv=none; b=Mb2UsDrQ1FIiVf6s6Dezh/6u2m90YM3EIWIuiFC3Y8viCqZ4YcXXvX0nZezgwwN5V9KgceniJyryxmIIe/tffYbEzFtuHacJmHadG5k9vtWbg39eLSaWvnKU/qIAb7zso/anmQspH11/fesrS7g60/UCDT4T+c6N7b8eALnYmzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250183; c=relaxed/simple;
	bh=Zm1f3qWUU5ket6YPzUMNKO2fAPtpzLuM2hT0bNMXZgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3CNy9BMdXBeWUwrveiG4HUGy0hkUB0mlE4btTxZP8S4YAHYpwTv5qJu0ikpsb/nsjTTmtrdH8H5ts+oG+Nl6+TZeDESJwcAdAKJU8T92So/uDbqMuL8Vvhp+F5cRCQWKOJ6LVzpG/m1b7hHf5yXyD+ttSGxtZgBzyRFs9Cusm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=VvxNRrjm; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="VvxNRrjm"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id C1ZtvICNYYuioC1ZuvRq5O; Thu, 23 Oct 2025 21:06:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1761249990; bh=itI0Ji9NfYjPalV2EgqZD/KeQwZQZ5iFkqhzOuSQ5NA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VvxNRrjmHnJaIdLzBKbKwXGB7cF9BTjy8O+Y+cvUhjIuTZMlZVt9fheZmwprzMupE
	 mAMg9hcWBDwmgcoy4icTTbzY3J9LXtpTxq9Sm5DWYTU4TZ0U2eWQLbDsH+5PPvkbDw
	 bAwSAn3RLTd1+LRYsPqnpMGkiHC4IwL/GZ0WKWt9MR/q2bku7c8WmIqSSTnnHI3KC5
	 pPw+NC7PW2jECcabjWoSEXUNc8eMM3xaDEI+/go17xD2rKuI1ECRpyBnTuguhp+utz
	 VFnsIHwTdbJXOiwUrB9rMiFnumYPGTNUCEgG7VxHSXgKSAUJyeHvaHO4CY2R5SFxkc
	 eZ31g/YcmZ/fA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HMRgFZtv c=1 sm=1 tr=0 ts=68fa8ac6
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=JcCJOb8IT_l9vMv_okYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <fb18d753-75f8-49a6-a92b-4f4e810bc408@ramsayjones.plus.com>
Date: Thu, 23 Oct 2025 21:06:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] technical docs in make build
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
References: <1a72434f-7935-4d0c-868f-03bd24601d4d@ramsayjones.plus.com>
 <20251016200301.1595204-1-ramsay@ramsayjones.plus.com>
 <xmqq3479v2e9.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq3479v2e9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMM02+V8d5EFuGirDCvTKRRTbauzViQc40wAgUxcNNGrE8LIrlJTBBDpuDC3NAw/cPicKJUwF2b5VgH+kOoEAslCdmGv8LPBSJ80IV/8ffN5kx1RCT48
 CLCJDj8GMGO1NXDY7f8r4agRU+Vxgb75j0NgIfd6sRrBVpvD5OoqJRUqTupjHHyzicjLHt0P5Fjrhx+SXVbmiPfbE2JWJZ4xBgg=



On 23/10/2025 8:33 pm, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Changes in v3:
>>
>> - old patch #1 discarded since it was separated into its own branch
>>   ('rj/doc-missing-technical-docs' in next)
>> - tyop in patch #2 (old patch #3)
>> - new patch #4
>>
>> A range diff against v2 is given below.
>>
>> Note that the two remaining problems (see v2 below) have not been
>> addressed but, even without a solution, these patches represent a
>> good improvement. ;) (I am still hopeful that an asciidoc guru will
>> turn up!)
>>
>> NOTE: this series is based on the v2-version of the patch #1, which
>> in turn is based on commit 6ad8021821 ("The fifth batch", 2025-08-29).
> 
> Let's merge this iteration down and if there are things that still
> need working, do them on top.
> 
> Thanks.

That sounds good to me.

Thanks!

ATB,
Ramsay Jones



