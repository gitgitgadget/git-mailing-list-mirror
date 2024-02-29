Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2113F444
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237376; cv=none; b=MqK3g5I7FiSN5rPGGfqePAQyQsCcho41GNzHt0hf7Ny1byG0+aFAMb1ZuUqsBBFiOohYwp/VKfQ7GYWM0v3pHiAKaLY2Emz86qfbtfhVagnReSzVqCYE7T51Wdc2gpUbx6dPhFxJTbMcUXML2WS2/osiN4ROIpP6tyjRAY3GHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237376; c=relaxed/simple;
	bh=RyJUUDIz2pTu9Yy4KUNxalZPcbsKElE4B8E64EVgSao=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B/vjw+6+UV9ONc8zLQB4ikJXMXVsyg21rfQadzyEw/3DbTSNgU1NKkfSrR2duLFQGM7lLJlNYi6fxYZqbEmySxEbNV3477PYDxKv7XrSckTPG1pRRfozU9yydtzSy74FPbskQjnak+NFFcQn7sk5MMZULY+ieyoht9PWlzwo5KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=imdYgxsN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="imdYgxsN"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709237365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TwZuooYJXqz4+6h9DJkbxlCgko0E6BO87ikh8kskYI4=;
	b=imdYgxsNPeDVLBTIbDVlKUnnyyXA6ZAd5Q4h0RliBjBtch9pQ4c7gJc8XZpUzs8ZFEK63i
	E6x5iGzI2iYEISzooql6Z3HQyvEVL0bgAUdwxQHz/OP+fKFoi+ZAHNZonafWHMsEZf3tbM
	qFbCL+/aj4sTHrSNmJWG/lVvu2NoJWtSnHmzTWo2mGDqWgcCKcpGNsV05rGti9aXEN1/X5
	Negc4/PofXMjMtpmiLTyXvzdAkMf4z9G+bdKH3uur8YlOLbBQQSepDxmAHutk2qgoYIV4j
	uCG5ViQGJArNPKxgjhNB4zE8MgUeLLEHhjfbOEJgDpuP6brhWdIUrrZjJ23MbA==
Date: Thu, 29 Feb 2024 21:09:25 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: adjust documentation
In-Reply-To: <d456a80d-5c2b-421b-a849-3c7cce288c6c@gmail.com>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
 <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org> <xmqq8r3g8caz.fsf@gitster.g>
 <35738a93f5cbace5b3235ce614b7afbf@manjaro.org> <xmqqttm3ouxy.fsf@gitster.g>
 <16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
 <96f1afa6-f4ac-4593-9bf4-72dafe3cab85@gmail.com>
 <b6d22f5a66de49efc623eceddbdc6faf@manjaro.org>
 <d1f928b98238a60a96bee0d3f410deef@manjaro.org> <xmqqttlsld4t.fsf@gitster.g>
 <cbaf17e7-37a6-4c2e-82ba-65fe41dd86b1@gmail.com>
 <xmqqcysff4l7.fsf@gitster.g>
 <d456a80d-5c2b-421b-a849-3c7cce288c6c@gmail.com>
Message-ID: <253d3c827f6e389d533c60113b08f94f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-29 21:02, Rubén Justo wrote:
> On Thu, Feb 29, 2024 at 11:33:24AM -0800, Junio C Hamano wrote:
> 
>> Do not forget that the objective of the larger-picture-revamping of
>> this page is to make the description of each option self-contained.
>> Similarity between -m's description and -c's description does not
>> count as being uselessly repetitive.
> 
> OK.  I was not considering this.

I'd also like to avoid repetition, but if we want to have self-contained
command descriptions (which is good), some repetition is unavoidable.
In fact, we can see what avoiding the repetition has lead us to in the
current state of the git-branch(1) man page.
