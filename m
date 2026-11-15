Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794737431;
	b=RtiYwh4v/BE5zofdfUGjxRvS23o49SfibDl8unDOcxr+7H7Ej5t1Kb6hUSQk7uw8+2xQ
	 Rmhhi9cCuuWr59qcwHM+UV6ZMZXW2bArUf1PnCqvFZa7jJMM6QM5jShx8cvrZqcbczKcb
	 0cvO4bn/knXtzd6atGJcGYXZ377QHP67AgwhX0i0zWazHUKxOPp5cpwlnVUZCN24VLaAI
	 85gFeYtGfbWHtnrNDoxFoLO1hn+o2Ijvu2mAX/ude1C5duQGZvT3CIFSUaUH6HMgyrdMm
	 mxL+WNswb/nJEkCQxmeTKeil35A+7Ti+4PS/L7g0Qiv8fEcG9dcKoqpj041wxXIXqgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794737431;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=KqvsWjdQB6Sb9dPwBMLE66VeDyJQ8YrLoLKkC5C9pXc=;
	b=cBeelhTEz5LlY1vpphriPFj60P7VDiXzYlE2Jr96eL9MHwUUK1F9Zc/Hv6SqG7Z6CFrO
	 vYzuvA15nJVJrfNqH+mZeeovmwW3DBg0Xvawg2Vk7yPgh8C3aXLWBl/CDh0V7L1RxrBpj
	 GCAAgj2jEFNbOEyyPONXRyLLaZfXKKHRdP5SCPchrHWJzwhz1ZC3gKAGel1q6Z4Np9Ikp
	 MeuWEr65vPE5XYMVhxZXdN759Bzv8ev1DYeF3gYF6vDJwxaLq8fIG4iQZ/WQ2c3su536L
	 XOOvva6lvWNZ6x8Cu5z9P2x9cgBClB1dSz8QbgzkgE/9OmmMhQB5tlOvOJdXURmx13w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b="JfdZfmy/";
	arc=none smtp.remote-ip=220.197.31.7
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09C606A31D
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 10:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF09C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=JfdZfmy/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=KqvsWjdQB6Sb9dPwBMLE66VeDyJQ8YrLoLKkC5C9pXc=;
	b=JfdZfmy/bvRkhwKC2JEEkABllxdBkYBRK+OVmrEL3mOBbKFrsXqXn6q3YksjkB
	3Q7ujrJoADG/+NBdgEjYcXD2mAC17ZZ4z0vLkHtYkwrCdYu9kTbHJQBceFE6an0o
	CVJZ5RSicVEC+WQSODShE7zerJRSt9XvnTuAiiEJW3lvY=
Received: from [IPV6:2408:8214:e13:ec00:9d5f:3d6d:85ac:2ca4] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgC3D+3thPlq+KEODg--.35362S2;
	Sun, 15 Nov 2026 18:09:50 +0800 (CST)
Message-ID: <d1e75551-2557-4938-9055-9918bdea6190@126.com>
Date: Sun, 15 Nov 2026 18:09:49 +0800
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: include fmt-merge-msg config in the main config doc
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>,
 Eric Sunshine <sunshine@sunshineco.com>, Bruno Haible <bruno@clisp.org>
References: <20261113144543.46713-1-YikunWei@126.com>
 <xmqq33t3p53y.fsf@gitster.g>
Content-Language: en-US
From: Yikun Wei <YikunWei@126.com>
In-Reply-To: <xmqq33t3p53y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PikvCgC3D+3thPlq+KEODg--.35362S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU67KsDUUUU
X-CM-SenderInfo: p1ln30xzhlqiyswou0bp/xtbBqQ51d2r5hO6qJwAA3R

You are right. I missed that config/merge.adoc already includes
config/fmt-merge-msg.adoc, and config.adoc already includes
config/merge.adoc, so merge.branchdesc, merge.log and merge.suppressDest
are already in git-config(1). My patch would duplicate those entries.

Sorry for the noise -- please drop this patch. I won't reroll it.

Thanks,
Yikun

