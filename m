Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89E718ECE
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="UkYbL7v9"
Received: from [10.0.2.15] ([146.198.40.91])
	by smtp with ESMTPA
	id EGoPrrm2UJsy1EGoQrKTXs; Fri, 15 Dec 2023 22:37:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1702679862; bh=rOEO2T1o5MTcxUB6eKYY3wz8nXEqsrUMaIH3zPC/yFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UkYbL7v907CHUDI1luRmf8taP9HSDrZ9WZHoPh2gdDhPCllct24dvSIz2ZfGG5BFW
	 VCmGwQOZOiORZxXNunM9QJjIjjsT0864LcuTLfoFDiPnLIVy95lIzwqgB2UU13RJ0R
	 liwzeVchfrNuWAMN11DuNIAp+n4iCYQChV0Rhfk8HQZIR1K5oaGH8CtuWELftkAbBZ
	 vlmjTBiv2FOZ/W2DAmKsG68yi5MvI6Zpc8XSNC9V5LQelxsChulyUwwz9L3rcG5A2K
	 pNzrw98bvQH/P+fcA8GkDxIE99HMwcrhIDL/+15tHBDS7PXTGNGfgwRnvOuR0FK4hy
	 PEo7VNjIpR7Vw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AOje/3mm c=1 sm=1 tr=0 ts=657cd536
 a=KA9ncW3+NP+rNtcBcdh9kA==:117 a=KA9ncW3+NP+rNtcBcdh9kA==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=EBOSESyhAAAA:8 a=LvWFIZe7u2toKIRtGY0A:9
 a=QEXdDO2ut3YA:10 a=t8EmEut40mcA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <09a519af-43a1-4725-a320-d70f66d66dcf@ramsayjones.plus.com>
Date: Fri, 15 Dec 2023 22:37:41 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] git.txt: HEAD is not that special
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <20231215203245.3622299-1-gitster@pobox.com>
 <20231215203245.3622299-2-gitster@pobox.com>
 <0c93d426-17c3-434c-bbd0-866c31c23f9d@ramsayjones.plus.com>
 <xmqq1qbnktnl.fsf@gitster.g> <xmqqttojjegr.fsf@gitster.g>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqttojjegr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHgA78sZ4ZKKGsRl+NSlHh0ImktQ9Q2sWeJGP5btHbdwYnJwpt6UdpzgkudINibF7HvHSzJ353/uRcdxZEcojw5I06rW6IrAdrjOVE7a0e6sACemKnXw
 wS/ul2a3aaF8c+fXaZ4rIKa2YYoLI2P9GAroopO75gNypJwAHsnKYmjpFp5phuvze/kkdIZM78PuOCu1FvdRxCIW+M3D0ZpxHuA=



On 15/12/2023 22:19, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>
>>>> -may contain the SHA-1 name of an object or the name of another ref.  Refs
>>>> -with names beginning `ref/head/` contain the SHA-1 name of the most
>>>> +may contain the SHA-1 name of an object or the name of another ref (the
>>>> +latter is called a "symbolic ref").
>>>> +Refs with names beginning `ref/head/` contain the SHA-1 name of the most
>>>
>>> Hmm, s:ref/head:refs/heads: right?
>>
>> Yeah, right, not a new problem with this change, but is indeed a
>> good thing to catch and correct.  Thanks for a careful review.
> 
> And we have ref/tags/ just below, which I also have fixed locally.

Heh, yeah I missed that, along with 'ref/notes'. ;)

ATB,
Ramsay Jones

