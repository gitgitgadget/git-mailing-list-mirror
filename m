Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208122EA484
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248582; cv=none; b=EQSGuIvmoB4BgcwnXxhJpJaRx7Rvt/jWpy+dnsGOvvg4TCK7zUCykOriMyjixzhsXgcV/iF7xGKSC//yJGy4s4TY0dOZynOEiAF0FnvR+1D5gzoP7PazWx8baNJhDiMXteXAhSq0FI7Dzfq4cqMuMzhfRV4uqpmzAtJdFMaG/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248582; c=relaxed/simple;
	bh=QlBgAUkSduIn+kI0ijGVV2Yi2xFksnWaow1tdsri3QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkTOs0FfRJn2yDZo75r5ySQytEhMnoBvSI0X8q5GA9ifqCLBLkNa3tUuRGcwLNL41IfuoWdlei5TrejQximkzGb/C/j528YytV485VhabgE4LGIqIhti1n8CzVygd52urPKuohMjoHx3CbcK00qHJn7oS0W7thu2vx7UR8lXqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=jI0tjKPz; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="jI0tjKPz"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id aFqiur7LeZgItaFqjut5Ts; Fri, 11 Jul 2025 16:39:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1752248389; bh=yNgsRfaUS3X6i+Oy2IB97pmOoxSlEqPRgUJsZ2mDVhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jI0tjKPzcSjEx2rEtg+ASF9dRPBUxidAewZaVofPdJHHWm9T1k7PyhCT5m1Zc53tW
	 Tye3wA7jxirtGECRou3Nk/CLFwWCwRFbo9LcZkINnv0Vrtspcc6dzeFuo4nL5fdaz6
	 uAzEjUapKbf61zN17EbJxJ8EE+z1X1AXuDOkL70016OtRjw2JWd4pRQIdWHweFmIYk
	 0J91d7+r17yvY6araGNIp/b9CHayQQ7EWJ9SsSv3gNpJCf2L53IWIg9ByZF/NLhRn/
	 yhQJwJjFKJHvl7gCMWVjh14UIs2gXh3ilwnzpbXU4YG7ePk2b+iJHP0JyFrpuYuhh5
	 JFf3sybxTzv5Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=NdZF1HD4 c=1 sm=1 tr=0 ts=68713045
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=qX9UiNFK7LTz5SAkSS4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <10112666-0eec-42d4-b2ad-bbe877bc78be@ramsayjones.plus.com>
Date: Fri, 11 Jul 2025 16:39:44 +0100
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
 <61a9185d-8ed8-4794-8f7e-1ed64503cc62@ramsayjones.plus.com>
 <aHDP_GK0ytKkp_3n@pks.im> <xmqq34b24vrq.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq34b24vrq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCddnVWYQmddZS9c2eaxCwcBgUdC1m5ZPPT/t+jv58gAhfTNP8wtGEjt9hIOrxqXYwxGjgWJW3GPlonl+DrXFy4bjjl+lzmRTQSmul+cyKt4FWNYL+g5
 bpLAvL5kHFDNzOLjnZ78t4ZepW0AuHJOOA2Zen1/6k24KesmpnkfSL2Wr2QSHBgIe1zj06WvUc8Mdk4XNqdUZ70JjItDXon0WPE=



On 11/07/2025 16:00, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> I'm happy to just drop the patch and let you handle the regression.
>>
>> There aren't any dependencies between the patches in this series, so
>> it's as easy as removing the patch. Junio, do you want me to resend the
>> series with the patch dropped or will you drop the patch on your side? 
> 
> Will do.  As always, thanks for working well together.

Thanks, will do. I need to do some more testing ... but I will send
a patch soon.

ATB,
Ramsay Jones



