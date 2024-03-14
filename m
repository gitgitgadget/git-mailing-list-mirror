Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C561A38D0
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441614; cv=none; b=GAyBeqUL4srkYWT3/6MBawqNRwduPzZb5ubZ1LvWbfBfTOaeTPakAJ/h6W7hDEw6WdC0Tsh4M8MpmKghBDCduh58jSie6C2nNysDYe5sFGrUE0bU8BGeyovMyYkfuPEdKwqzggCHXGvR6PClNEj8pNp0aCtqPsmrbYKC5TRLCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441614; c=relaxed/simple;
	bh=7j+N82BmMaqxiTtDNOfd8io0XeW9Mq3eu+E/zByg1lo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HYru60StRof65Eq5P0cGo/Zy2BDe+/MK+c1hm9RL3AwhkGdf4IJlHskEpR0AeuCk3TzVss83tTxBsCOyQ5gX/LgTdef6ODFtA0B3iO3AbGEK480DzKGGLX4Xf5NcGsD9TMvxiKfueq//d6jnHWxX60Fn+c8MBAaOWc9lHbjoM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ampO3Rth; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ampO3Rth"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710441601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AV8K3JlVFPggvgyMm7+rFeWCwEBOZQutpVfkW0pFdc=;
	b=ampO3RthIAJclfeQ0e7HxZiQ7jf4AiGqkmEiR7cy/yuJDrjoIvKBskll7yhDybQkL82FwP
	vcfspFWbwgAZlA1cLe0EbZgvSakcXqRho+axaJ6saHMoW4b2/Hpcu1d4wkl3lZcDZmMn9V
	hIDvPWaNFKJVg/f8MPCwyuGEzYj91vRBzlvpJIEwpnS6GYdJ4QTmOdh9myvhUArxzGGuNw
	Sd0I79j3Dd6dsVctQx0tvl5gmoVBSrU6QBN01nHHCPEmLR9ukzAeemFUc4YCTrUKFfvHPR
	CbVHFnjdXTeTEKp7XAz+5JEGoyvX057ipDks133UBIrWP2OdiTejM2nKcWwASg==
Date: Thu, 14 Mar 2024 19:40:01 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de
Subject: Re: [PATCH 2/3] config.txt: perform some minor reformatting
In-Reply-To: <xmqqfrwsyeac.fsf@gitster.g>
References: <cover.1710258538.git.dsimic@manjaro.org>
 <d50c0f22c41ec36b574e1ff67e68485d9a6f2a84.1710258538.git.dsimic@manjaro.org>
 <xmqqedcd1sm5.fsf@gitster.g> <07d0ac0d11b47983d3aa1760fc01ad92@manjaro.org>
 <xmqqfrwsyeac.fsf@gitster.g>
Message-ID: <f7fa6d9bc9835ad1139bced5ea2b20b3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-14 17:22, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>> I was a bit surprised to see such a "preliminary clean-up" step to
>>> come before the main change, not after, but separating this from the
>>> change to the next paragraph, which is the main change in this 
>>> series,
>>> is nevertheless a very good idea.
>> 
>> The reason why this patch went as the second in the series was simply
>> because it's a somewhat unrelated cleanup that performs no actual
>> changes
>> to the contents of the documentation.
> 
> It would have been understandable if it were left at the end, as
> "after the dust settles".  It would made even more sense if it were
> at the front, "before doing anything else, let's clean up the
> mess--we do not intend to change the behaviour with this change at
> all".  Having it in the middle was what made me surprised.
> 
> Generally, the order of preference is to do "preliminary clean-up"
> first, followed by the real change.  That way, trivial clean-up that
> is designed not to change any behaviour can go ahead and merged down
> even before the real change solidifies.

After thinking a bit more about it, I'd agree, especially because
such an approach makes accepting patches easier.  Thank you for
pointing that out!

> Unrelated changes has no place in a series with a real purpose.
> Unless the series is about "assorted clean-ups that are not related
> with each other", that is.

Having all in mind, especially the addition of a bugfix for the
value parsing into the series, I think it's the best if I take the
cleanup patch out of the series and send it separately.
