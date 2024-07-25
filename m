Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D226286
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926830; cv=none; b=cxm0jqKKU6R5OB6ekdWGjBnA+Tvt9XLTBdRlo3l9Nv0BNi2JgXyVlewRi5d9Lq8kF9OE+++062FX4nWK/hPJnA3G7ixQ1AeGJ8ZuRNfdJe3RDtWE/D98NnD6+HASnUJpjsRiyfucgAQj1TTKl+zpTOoS7mcNzDhi+x4HqcH+FcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926830; c=relaxed/simple;
	bh=LE100ebAfvvNm788iaZA9PGSbrpBge4zbK/BaP0mAQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcr+W1cVyF83ybLJtn5GaXHwIol6fhRBa9NoWmobxRAZzhi+sHwSaVQicrDsJ4IQaRFL6JELgD7kKCr4mkCSwRH3cI2WeHZDtaFqkFGN3KD9aFsICzjFEhuYH8rGTG6B8QOuv4F2+m/TLB3txigoe4czM89+BrRuEVl/on9a2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=nl1byv7C; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="nl1byv7C"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id X1mHsIdKvX9c9X1mIsAUXq; Thu, 25 Jul 2024 17:57:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721926639; bh=kKtnj6EZPjpP2vjhghYwmp72aP4p18xHgna6SKzTO9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nl1byv7CW+w99bS6aw1K/GqfdOeAZUyAW6zZNQWVqmgcVhDN9CubkjpRoYQg3BBuI
	 4cC2bJmtyJDAqcl/q+ZpAeYxbB8I2iy0i73EgjE2jTcc0OKQ3bUeAF+WzJ3XFTkT5W
	 rdl8TP14HR3kGqL/+wx5mZQXrDl9qDV4IytBa8JhxX44Whg4P9L7uQCVSqnum5M5Es
	 t93VA0Nrm4dyQOQQ2CUjywt/mTnrMRHBmpLikHcmCvpoo+FS1/Rkki66lmSbZsT2OG
	 q7U724iJj0qG/nG47WnJU5u+s0BB3JPT8Pi0Yrut6JOZ9sAtHS8mwHPxrrKlNedF2d
	 3A3TffwQ4eYHQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=NPx2+F6g c=1 sm=1 tr=0 ts=66a283ef
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=PoKn_H0tiGFBPcLqZB8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-AUTH: ramsayjones@:2500
Message-ID: <9282286d-1a48-4434-8f5a-1b67035819fd@ramsayjones.plus.com>
Date: Thu, 25 Jul 2024 17:57:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Git v2.46.0-rc2
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
 git-packagers@googlegroups.com
References: <xmqq7cdavgqa.fsf@gitster.g>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq7cdavgqa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIe1TZ6YVDKdtHlAbXkC0FUM/ufxF+6bkbjmmU8REdT119woux1Z3pJfp83FaKuvGi7CwKylZ4FI5cX11Dn69nRcOH0BgQJIcPqGWy2KrK0trDdy7TGh
 XqtBa3PxqELPmL/F/Y8UGyh2RNLY6jWjaZXpA61dnoOjWYFxfT7nzxQkKNOyqUivnHAzU7lt8tjgazylH1erntzQ4P34NTfcfHU=



On 24/07/2024 18:31, Junio C Hamano wrote:
> A release candidate Git v2.46.0-rc2 is now available for testing at
> the usual places.  Relative to -rc1, we fix a few recent small
> regressions and nothing else.

Just to confirm, running the full test-suite this time, that the 'rc2'
build passes the 't1460-refs-migrate.sh' test just fine! :)

Thanks!

ATB,
Ramsay Jones


