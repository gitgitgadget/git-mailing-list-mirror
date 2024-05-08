Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889168663E
	for <git@vger.kernel.org>; Wed,  8 May 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183948; cv=none; b=SlAXryE4yftlhg8lSKhhx4RLDZbmOY9F6R75X9lPd9nhiJI4K/GQxm+iFyY6oQkqySPBmIB2+fB7EFXOJi9es3NELBzPOchnYlgkVJaZzGQHCvez92nytdkxbabP7Ya+52vPN/0q+6+zJTll33j4Gwf+ev0xi6kZuJd0+7expzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183948; c=relaxed/simple;
	bh=elM5MG7tbf0lIKSsLdiYUiGRVQ3IEurlYVKRqEiC5kQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=t4nAGMePasDWkojTS+OjUkBV6Z4XUuvp4twUf+jwf+FXBxrXHhlEq2/PZnnvJTJ1gcy5eYrveUu6zj56wriNqFK8W0/PAdWUZRam641fDJ5S/Rz3DD/g/ITEes8a1njLvC1E4kyRz5EM/nh7PHJR4wMv3X24bU4wLTg2LKhtRRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vm2paXk2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vm2paXk2"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715183942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6VEB8++szJSLrcJStrTeEDzYg1iHmc8ovLzPLYi7YM=;
	b=vm2paXk2q5v7FCs6ZZQ7RFi8rPMDMQESIYD0xRsBSsI0PsaD5Nn3hmkwvoWVTT/tQ7j2yv
	Thv68rxs26FrmVa0vwkIrQ58wZtEtuWPTrS5jSxKfxehI8AtlL30zKbLQpBd0dtLPzpLFA
	cSQw4kjWV92PVMzLg/N6q0YDvxns1JV4f0qZ2rw4ECuuBjr72l+xJmzi5xrnt+bjYgYmk1
	79WCQWcTXCIQqNIqXuE+N7ygVvwPuYQ317omjGuaKHLAU7nSMXyObCTT/JrfWPePsgJ6nM
	bRr3zxCFix0JTaLGqwG2I41oCu8KL4chE/XW/ibL6RUsyVVyEriXu56NOQrUrg==
Date: Wed, 08 May 2024 17:59:01 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
In-Reply-To: <ZjuEMNsw-KARJjwx@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <xmqqle4lnuvy.fsf@gitster.g> <ZjuEMNsw-KARJjwx@tanuki>
Message-ID: <112b6568912a6de6672bf5592c3a718e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Patrick,

On 2024-05-08 15:54, Patrick Steinhardt wrote:
> Okay, I see how that may make sense for some parts. I guess one of the
> motivations here is things like git-checkout(1) and git-switch(1) /
> git-restore(1)?

As I wrote already, [1] I really see no reasons why git-switch(1) or
git-restore(1) should be deprecated.  That would make zero sense to me.

[1] 
https://lore.kernel.org/git/3d84f2eac9b03eda814332d73b5d5ba6@manjaro.org/
