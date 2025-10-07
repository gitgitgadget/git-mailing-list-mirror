Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F93221FBB
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875662; cv=none; b=RypMbHuIHxcBqihiSHxxVVG3VpOXsAWIKabsge5PHSgbRRja246uZRdMIGJguF97WQdBkMgZwkTooRWsWNDUPH4irmN8KiA3SgrxclN3aK5cADIXhGObBhikvZVxP6Z9wbqHpX1hTRagtuQfoB1cHXDmZA3x18FQ8B5YbuYIpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875662; c=relaxed/simple;
	bh=rZ3sOxQkm0UGmGr97h5HqlrlwNQX+odqEpQcqJrfq+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnzMpcwoY3y19Ijo9x4awsLerT9wvVVVqNNRpz3QcmQgBR3STFV4gMqoGdaLVdBkuazOUZ50ZAIgQP+MieT1YnTl1QKXaNvYdjVerdyvX/84/9JQrLCz4gDJehv0AzdEhQPZAljLdtCaTXoHvSPaNv+/gOYAMecw4Vw/thns1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=TOFukKF/; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="TOFukKF/"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 6G0BvW9C9Dzgq6G0CvPLfS; Tue, 07 Oct 2025 23:17:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1759875469; bh=xBSdw5dnC10nbXbhGLPNlXo3WZz2an+nG5WRv3TnZUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TOFukKF/YVwwjnMeOqg8NRoZTue+FIYbk1xPeoOMle/x+9tTAhqc6DCN4GZ/KDw0J
	 fBzYDAcRq2dPgpvISqvw8ovXjfOU66PeC6YVXveSpFJrZuIjO9juwM+iHfB0cdktsc
	 S6fg2PHHFRe0pV3lrLVcwhDKGKPnvI4aLc/j0cTXz0Rs3kxAHclDVXWrlWwrIVHsRG
	 ewiCIJf7nf9HS2SK5B/bWY2qxdw/wbK3QLzqmoDoDcya5eAKJW6+xIwzmChzvegS+h
	 gdWIOg1i6JN45WAYBoExl2Cm4ok9X7B2my1TO32xRtAtzmcdDxuw517SBUZsZ3zZ32
	 2/hXQT5yAJtUQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AvdN3/9P c=1 sm=1 tr=0 ts=68e5918d
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EmrZvZhjM68_0-YfJ9sA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <436fb507-6764-46f4-abb1-34c82e27b808@ramsayjones.plus.com>
Date: Tue, 7 Oct 2025 23:17:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] doc: sparse-checkout.adoc: fix asciidoc warnings
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <https://lore.kernel.org/git/bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com/>
 <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
 <20251002221233.541844-4-ramsay@ramsayjones.plus.com>
 <b771b1ca-96a2-4dc1-8c66-0a3006f18565@app.fastmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <b771b1ca-96a2-4dc1-8c66-0a3006f18565@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLqQQNlCVdbC/b4eqmvzPV05PsbVT9NIIrjj8CXgosqpgeQTEFy1YkS19b/Ds5o2au9vtinFZKiD3NJHGC3jqIycJIpQcZFZsaN6a5RMnN8clk8mpAfG
 jiSegFWTkubj9UVvVOMUrhYXZwCyNT48v4UCKbnnWOpWdd/h8B3rZxO9HINNkgTMSej07qXAqAEJae/eU2q8AyDYHG72ojy0IjQ=



On 07/10/2025 1:20 pm, Kristoffer Haugsbakk wrote:
> On Fri, Oct 3, 2025, at 00:12, Ramsay Jones wrote:
>> [snip]
>>
>> In order to address the first set of warnings, simply renumber the list
>> from one to severn, rather than zero to six. Fortunately, this does not
> 
> s/severn/seven/

Thanks. I have updated locally, while (hopefully) waiting for more feedback.

ATB,
Ramsay Jones


