Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BF219A94
	for <git@vger.kernel.org>; Mon, 19 May 2025 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747694559; cv=none; b=B3qoxNVZoelfAmVAI0atUAv+L9KSqxczfh45Fx1SfdusIwBwxhWRFxgys2JK4kJTF9HMlvLl/V0nv9zqUzXf4ImmhwlkEsOkdh5NiglgNEiZAk+vPLMf4D6yKuqTYc/BsK/tvYN1eVlp+A0Vjp5k3500r+UBh0b2N8HRKK+auVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747694559; c=relaxed/simple;
	bh=oW2+NBNDSNFa9pm0NsU9UkAnZEt+Bjz1Ut81tVYioRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IY7SJ8wav+cYDoR/yQqsAJyD58qvnHadqKQnUHeeV4Ca/lrZlodkqBMevMEjrrFXI2JTRDzVeWNtCX7K0AwUmAgQBFNYytWUJm2sEjexDhleId5zafKCUCC084UmM/Hvuc+7iFuQDtA4v6WqPS5fbLe1nt2a5udBoWKCpiD7jbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=EYkL6+Ao; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="EYkL6+Ao"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id H9BguMMPmJGekH9BhuPwCm; Mon, 19 May 2025 23:42:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747694548; bh=2kiOhaR40MkoP5dHkK7OWb8ef+2qN1gDwuetnNqwzkQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EYkL6+Ao5hJh5NWIzQkFzENFsJP0JUD67VC1TWjEkaqYcrot5JdJbPuwhA+A3M9qM
	 u5wpRYMIiLciKzss74OSJUTB9TevxRvPpeBrCq7hdXm953u1NeSi5q57POdPSQAUBq
	 /xYbA40uNWkv59LIBBpllkIn5sHgXZi7cPYCGh7vxfEfwU462fD4yrK+jQw9EaMW3g
	 O+yGjsxuyUMlxB7iopt0yQzLnZCpUB0ecM/jAg+6t9FwXzFEbfK2MIcNFwF8Ms4RgU
	 u7F4DxwYaWG7HKI/zFLDmvjsLsjLzOcNjg/iSspfbQRiHRqP7w9y0L6gD86CQoQBhZ
	 wCG7QAQSKNlew==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FoOm/Hrq c=1 sm=1 tr=0 ts=682bb3d4
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8 a=OEzAtxz5_KK2rLuguKcA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <b5d5953a-1b1d-4e0d-a908-07c569fa59d2@ramsayjones.plus.com>
Date: Mon, 19 May 2025 23:42:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] miscellaneous build mods (part 2)
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
 Eli Schwartz <eschwartz@gentoo.org>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
 <20250519162523.1001478-1-ramsay@ramsayjones.plus.com>
 <xmqqo6vomo7y.fsf@gitster.g> <aCuBtP8-NmB0lKo-@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <aCuBtP8-NmB0lKo-@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDNLI/VojL11Djn948zGMjrZW0pyvZsEj4TJ6EynKnpHBY8VFHOWfoJF4GwoZ0RKIbuAQBiLylTjwkBcnFxRkdzdqb7BvXKHm66iYbbUjM4vGv2+b72l
 T8eDq6FKz4UFrJj0cElCN60maTgVl34M+L1WGNaWl1dQ7q9pkUGgaKXni8Usg/xQnGUDgbyP1J6/V8Qakmm0PgZaUXvhrvVXTlU=



On 19/05/2025 20:08, Patrick Steinhardt wrote:
> On Mon, May 19, 2025 at 11:48:01AM -0700, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>
>>> Again, I did a test merge to master@cb96e1697a, next@a128411c76
>>> and seen@df1b4f9cf9. The conflict which showed up in v1 against
>>> the 'seen' branch now appears in the 'master' branch and has the
>>> same resolution as v1.
>>
>> Thanks.
>>
>>> A range-diff against v3 is given below.
>>>
>>> [+] https://lore.kernel.org/git/aCrekcz6onTFgEWw@pks.im/
>>>
>>> Changes in v3:
>>>
>>> Patch #3 changed as a result of Patrick's review [*]:
>>>
>>>  - use the '/' magic string operator when setting the
>>>    ETC_GIT{CONFIG,ATTRIBUTES} build options.
>>>  - add the default values to the 'description' fields
>>>    for the 'gitconfig' and 'gitattributes' option
>>>    definitions
>>>
>>> Also, Junio, the range-diff below shows the typo fixup, but
>>> you should find that it doesn't show for you this time. ;)
>>
>> OK.  And changes in v4 are just that two redundant comments in the
>> option definitions are removed, which makes sense looking at the
>> discussion from the sidelines.
>>
>> Will queue.  Are we done with this series by now?
> 
> Yup, the range diff looks as expected, so this is ready to go from my
> point of view. Thanks!

Yes, I think we're good to go.

Also, the 'make test' on cygwin just finished and passed without issue! :)

Thanks.

ATB,
Ramsay Jones


