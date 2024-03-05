Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA4168DD
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673596; cv=none; b=kDRi6LViNYn95H2Y6Ze726jl9mrbTX9oV90CPmLMW4eKEiyr1ptRmGbBgZrJ44bPMrB0Bge+rwCKyy+n9+6w4i+Wc5bcFz4mBAm4JG1CBzSNmQm60rLSTyv1bm/AnoU7YQECP8wO/PUt/IPbLjskvedwDs50XizdEg/60vqNoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673596; c=relaxed/simple;
	bh=64OLFLxGl5re1hWjRjXvQkB8fnNZsG58ssSljO0Glrw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IoH59aocdKpV2zEMs5U2lp0GY/5jJz22b3e/fYwVtl1lCMtON+MhJj4zyCPv2q/x8mjYX9WOodTSjxkM20jZ5XJW8u39esU+g0SurROjZGfanVU8WW3PvTUAeALqojoqz/9xf5BWvRgN4nrkXiKbrR7yDbXLpUGcEerLeGf/T/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KqxqEqEJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KqxqEqEJ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709673591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXVe2il9Q99EFpEsozeb/xU4UEgINugMaHlRe1FeNP8=;
	b=KqxqEqEJICAt7ozkep+Ps1Tl7QpSo7GA1JoPX4yTZUCCywxaRMAwG3I++FmxA8bJLhQcv3
	1fu8Fy7T/PJ+IJ/h3gAu36m+Wwr+TFjinACliDwXGansi16z+mFMHYVpNGsbbodB1V3GLk
	uEHcor4+w2ewHwswGDz4Nh15bavmdukIweKE1HeXHaAooDq3VjO3jWgJMRUhZ3Ien6cRdU
	giorsYBgTe5Z/ZlHh8pe1KUbAg1ICE+0AhQeJYHi81x7xEwKs2TlgnpDT/dk9bDy+Rpkgr
	Z+utjF/3nRhF5NwB3VfMfDAQqnZ3lvkQpJRrqyxCfzW32lBFtdE+kcYCdo4QTQ==
Date: Tue, 05 Mar 2024 22:19:51 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Manlio Perillo <manlio.perillo@gmail.com>, git@vger.kernel.org, Junio C
 Hamano <gitster@pobox.com>
Subject: Re: Clarify the meaning of "character" in the documentation
In-Reply-To: <6de8764e-9764-4c2b-ac2e-ca5e8480908a@app.fastmail.com>
References: <CAAToxAEE-2B_8Wqrquk1peOnqTbOpV_8KZmsJ2dgk-mfCZXHiA@mail.gmail.com>
 <5e10f1e5-b87f-43cd-ac1e-d7c01b7dad21@app.fastmail.com>
 <xmqqsf1466eh.fsf@gitster.g> <52d6850914982ffaf15dda937d611ffb@manjaro.org>
 <3bef4fef-0a00-4ed8-878e-372c4d8f552d@app.fastmail.com>
 <1e71ce757c3d773fd7354cd12473b851@manjaro.org>
 <6de8764e-9764-4c2b-ac2e-ca5e8480908a@app.fastmail.com>
Message-ID: <1c2ee0c45053e1b60e8ea64c19b6c292@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-05 18:37, Kristoffer Haugsbakk wrote:
> On Tue, Mar 5, 2024, at 18:20, Dragan Simic wrote:
>> On 2024-03-05 17:58, Kristoffer Haugsbakk wrote:
>>> Personally I think it’s okay. `%` for example is a good candidate 
>>> since
>>> you seldom use that as a leading character in prose (after a
>>> whitespace), and it seems that `%` is often recommended as an
>>> alternative.
>> 
>> Isn't '%' actually an ASCII character?
> 
> I wasn’t clear: personally I think the status quo of only allowing 
> ASCII
> characters seems fine given that you can use something like `%` as an
> alternative comment char.

Ah, I see.  Thanks for the clarification.
