Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F5E23717C
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183861; cv=none; b=BLk3UvoanMVsQd/+2FuLzm29L4AnzyJctjZqB1OfdES/S8QWy+eXQa6rlAYUB2twxmp7XawadUBWy0PrFDZ18sjGj4EwVkWd5cj3awFyndTszBmD7OnScp8MUcErvgwm6EN7NpwUaHFDyDk7ZOQGuDNmN3FhpE/3aZU4RgdDjmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183861; c=relaxed/simple;
	bh=mc18lkYccH9+/CezEn25Z7dPshEY1zGROr/5DvwR7X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSM8mp9bWzjbjxQOJS4ZzNcyl9Tw1BMkXuHzoovEr+27KiWoQWPf4EAkW0R/u/K2g96huHFZQo8HVxZjoTVvFqkTXFfFmFR8Cphqraat3pArMb7DpQ+mNSK+eP7lc2Ba/gTmzNr8srSdrdiferjwX/g8lMmkwymyLt2YKn7jLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=UvI9NJZm; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="UvI9NJZm"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id Zz3nu7nmp7HMwZz3ouTAtC; Thu, 10 Jul 2025 22:44:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1752183849; bh=TSk8itYWutrhZrIO08d3Gm6MrrCfi4fvIROQMwQmu+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UvI9NJZmKunO1nC/qSiMAURC37Tn7IE4aoJl1bbYlrDLcpx4wyeGUjcfOvxGGxxHI
	 PUjruWO/+YDHK9SDvIOOAPeVZgVP+3SD0Iz94YICEXvunbPNGjCdvjqr/tIPLz5ixH
	 KBOJKq50ovVSDo9BwzypVMUH9o3yLuTlCW6+mV0tbQn4itTb3HjaU7S8MbZIBumMId
	 xDQTJncfg75T3sCjTEz21mB1Uv04ba9m8OjomiMPiLnGYGsqSjmMiCZSP6Ex0CAJra
	 6+ZtQ51qbBaTP4OOV7xemHZJTlW1sYO3DxZYzA4vIYVCbcx80izTRYTT9y6LB+P09+
	 8Ox/1wVOpWZlg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ZNB0mm7b c=1 sm=1 tr=0 ts=68703429
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=1eCY9CL9KBXtGoZ4x6kA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <61a9185d-8ed8-4794-8f7e-1ed64503cc62@ramsayjones.plus.com>
Date: Thu, 10 Jul 2025 22:44:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] What's cooking in git.git (Jul 2025, #03; Wed, 9)
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <xmqqv7o08ocn.fsf@gitster.g>
 <f614e1c8-91a9-4430-9d60-5aca05170b4a@ramsayjones.plus.com>
 <xmqqo6tr698f.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqo6tr698f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfO2mtdbGXIHBLXLcqeW2tuJy2g6ZgwSG8MkAbTSPx18voqLkZiUJt7TZXHmCNJ+1mm8xTjpJJZ/MZYblQRhrnwAZBE+AljrMbVExfDBzA5P01AbsQxn0
 myjD9VmfbEFX68wj8Fk9j8+Cjaa8VKVjQF2kPU+fMnJNCJPUriMAchgB9HZfcVB2YYBVtLKgCByGPRPaxLWkn0nRw2U9qohHCLM=



On 10/07/2025 22:12, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>>
>> How would you like to proceed? (yes, I haven't written the commit message
>> yet).
> 
> ... appears near the end of the message, and the way _I_ would like
> to proceed is to make sure two parties involved in overlapping
> solutions to the same problem talk to each other and come up with a
> solution together.  The first step to get you going would be to CC
> the other parties involved.

Oops, I had intended to cc Patrick! :(

> If the controversial step in Patrick's 8-patch series is relatively
> independent from others (which was the impression I got from "more
> or less random cleanups and improvements"), one approach with less
> friction is to simply omit it and make it 7-patch series.  While you
> and Patric work out what the best approach to solve the libexecdir
> problem, the rest of the series can proceed without waiting,
> hopefully?

Yep, that would be my preferred route.

Having said that, Patrick's patch does remove the regression, so we
could keep them separate if that is preferred. I don't mind either
way. :)

Thanks!

ATB,
Ramsay Jones


