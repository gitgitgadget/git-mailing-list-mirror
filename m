Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113F626286
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927086; cv=none; b=qQLJ5vb+WTl2iLI8DdFnBHKmvsNUu19egnn4lsIbGDCwHO/zgbVpKIiE0qQdBMigo7oKj4eAZtI9+HRZPfmyKAsaZ+wJtftPE3Nhi9D74BJKVSN1geBAOEmGfN5k2QDWnXNPD/9U+XMkDIrZDYFNKP7xstFuYOwdqwELOtdgim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927086; c=relaxed/simple;
	bh=MlTM3GOUl9TwzdbEXqpa/qULHio3TqMp2hWQnXjx5Vg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TmgOKaNhv+N1JfNqG8BSxAsikn+Sz+/v6wNhDUO//7JtvVUqZicXFaSwKGVEjbsmd71CvVvRYGHs3P8ze6/P1FvTIiFg9K4yYKgEkedV7LMKxvO2LprCehpa9/oZEufrnxtIXFiZALLKgjdla1S49G7/mzHxHXWNp/O0htLjSms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=f3/D9Ylw; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="f3/D9Ylw"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id X1tRsIdzTX9c9X1tTsAUcY; Thu, 25 Jul 2024 18:04:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721927083; bh=1YYXO61tGUo1p5KA5s0OWrI7imhDBNJwS3HHcQxwT3I=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=f3/D9Ylw4/8XAW7S+FRewYx/hFGyf8fOVo+HiTI6SQ6fMSAN8yM6b7HPXiCGz/n1k
	 uTYMirROz2SIppJAszOMBbF1D591UmznCsz+0U+D5eDhWFyqCcaRxc8F0QEerPxRjm
	 3H8GJN+evZe34U875ixatY5uURPplaLGMl0rlexw76ciJQ5QKK+oqpWpj6oKGBY2mr
	 yy8uxqSRyFnSX8Mfp5xhZJY58vXJVq1FpodMbmyDN9OxgZa1IKuAdwmtN3EVLmNfA6
	 4W6RiPzdYJxko7Zm15CGHlCyUdY/uwkvoKeGdhZi7qmykf4DiiINr8qMXd1WWb0tkL
	 kOu+LsSQdpBCg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=NPx2+F6g c=1 sm=1 tr=0 ts=66a285ab
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EfSOSDqkiofDkBLqXn0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-AUTH: ramsayjones@:2500
Message-ID: <c56ec3fc-405b-45c6-845f-1a25e52a283d@ramsayjones.plus.com>
Date: Thu, 25 Jul 2024 18:04:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Git v2.46.0-rc2
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
 git-packagers@googlegroups.com
References: <xmqq7cdavgqa.fsf@gitster.g>
 <9282286d-1a48-4434-8f5a-1b67035819fd@ramsayjones.plus.com>
Content-Language: en-GB
In-Reply-To: <9282286d-1a48-4434-8f5a-1b67035819fd@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDi9y3G2AjVt+CMG1Cax7YrMDGp+V+mW7M0LSi0qmFBvgMRYr5Yo474cbFq1t8vvd0I3wMBXakL5LTGZHZRLMZgItuIvFL0iEFYzqaYcBVliKKlSkHX0
 ylWzLKmoA8459M/gouxYY+WGtGaQjR80FdhNQhqxVPAieLQYzauexqAp/aEeDQkz8qWkgoZpVXgtuoyGIKjm34zdeiacQvE6Bkg=



On 25/07/2024 17:57, Ramsay Jones wrote:
> 
> 
> On 24/07/2024 18:31, Junio C Hamano wrote:
>> A release candidate Git v2.46.0-rc2 is now available for testing at
>> the usual places.  Relative to -rc1, we fix a few recent small
>> regressions and nothing else.
> 
> Just to confirm, running the full test-suite this time, that the 'rc2'
> build passes the 't1460-refs-migrate.sh' test just fine! :)
> 

Err, I had intended to add ... on cygwin, here! ;)

[hopefully, that was clear, since it didn't fail on Linux, but ...]

ATB,
Ramsay Jones


