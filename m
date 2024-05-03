Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E29158868
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764707; cv=none; b=RErPHExzu6Jrrxj3islbqAuCVSkI1OMbtD3HOLT+w9RQu+R2M/QGCZ1QvsHvIZE1WJCfs5iAX+Xg3pKZBhpsQQgWiGkzOHZNqrhivsVp3vn8nj0AkkuVarJsTezm1cuqJ0RBIaXa9J2i7/8ptHO5JmyPUT91eWPG3ZbP1gcRpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764707; c=relaxed/simple;
	bh=huncNVgcRt4jcXIvUpAJSgQWaSoVDaQGX+x2qRiH/0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTtRWbeu6X3LUYyvlmalf1xy4coSUBMtzmEGPZu4Znx9xd4IPdHpe3jdOIKh/mY+b/BLPc6beiCBte1HZx76vF0fELwtOuwNatRK7PygWC70Iv9PTHHXTqZNlV1YKSWKtLtgEBOO3b8YV8jke9m59emtxmmECftI5DKKiZEmq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1s2yd4-000000005ry-0ESY
	for git@vger.kernel.org;
	Fri, 03 May 2024 21:31:34 +0200
Received: from [10.20.10.231] (port=50492 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <dev+git@drbeat.li>)
	id 1s2yd2-0014UO-2w;
	Fri, 03 May 2024 21:31:32 +0200
Message-ID: <6f421704-774f-4069-af18-7e4b8d7b42e9@drbeat.li>
Date: Fri, 3 May 2024 21:31:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] color: add support for 12-bit RGB colors
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20240429164849.78509-1-dev+git@drbeat.li>
 <20240502110331.6347-1-dev+git@drbeat.li>
 <20240503174841.GF3631237@coredump.intra.peff.net>
Content-Language: de-CH
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <20240503174841.GF3631237@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

On 03.05.2024 19:48, Jeff King wrote:
> On Thu, May 02, 2024 at 01:03:28PM +0200, Beat Bolli wrote:
> 
>>   * The color parsing code learned to handle 12-bit RGB colors.
>>
>> The first commit fixes a typo, the second one adds some test coverage
>> for invalid RGB colors, and the final one extends the RGB color parser
>> to recognize 12-bit colors, as in #f0f.
>> ---
>>
>> Changes against v1:
>> - add test coverage for invalid RGB color lengths
> 
> Ah, I missed that you had sent a new version when I responded to Junio.
> Yeah, this whole thing looks good to me!

All good ;-)

Thanks for reviewing!

Cheers, Beat

