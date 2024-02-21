Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862A3BB30
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501872; cv=none; b=EpcOZtxa7Qc20czQpZYM4NSyp/B3zYEEGPxk1BaHfnJnP4hMAQC3tFNZb7FQ2WU3MM194ojLJy6ElXHdJbIIJT8tSxW8LD/9Rs7QGeZBbKfdybGJNI81/79R/5j+WkBMnhhmikhK++WXXuVk/DFYnfkSfD3pBh0KAImsQX4WXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501872; c=relaxed/simple;
	bh=7tMuJP60BzAdJh+ILCnOJKPG8+ul3sYOsDUeQO9iruQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IwpoE+EXinfmiv9V6H3dqyBtWeKgK0BdpAee8Iy9GKhhTR0Q+kC2TDEVijkIzkQGfVmL8LWYYWLyUlQJdwAcpyDSd7U/qWvUsbaVjbJGINJim0JBSJ3aO26WMfe3w2sn/bVrrq1kbIjfJnyVZq4YlfB8joQtd9ATvSwXpCQGYGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=PosB6wvG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PosB6wvG"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708501860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuSIZjtCbHX4NFAK07FmVtqbhqUkItZYRqjH8tS+dWI=;
	b=PosB6wvGNaFm9AYFlkO2cij9Wf/ccXo9u/Xz4XTlTaDIkjppIFFXRjyBdf1I1RvNnI9Kig
	mNRKFE59M/Qjg7NsLVwsRll05IDQXQZG6xbbxigMg3kbdELkb8+CGiyVu5dBb/ZpC7JYo1
	msRen0BOkyDBk6xF8xiGPY/Q7PC2dZPZcPE5WPSMwzq0rJknXeX/KK3wQ2ss9IWxWlOnJl
	/QCg1t2OAu0O9GnYYfj/IQlgERIk51hQcDhlSZ7AJlp6xk7vwAggcuMeUGL/HlEWxlV1cn
	oZscWwbjAwOYZLmZ1cYLa/k/x1HSxFlI0abZV00M5Xomnq6NYisEN8ukFNQ9LQ==
Date: Wed, 21 Feb 2024 08:50:59 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Chris Torek <chris.torek@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] documentation: send-email: use camel case consistently
In-Reply-To: <CAPx1GvcGhZLqHVz9=ZW-w+ebP64-8FpPSb_ef7ygXzDDTze2bA@mail.gmail.com>
References: <b0577267402f6177d8ba5646e12d7691437e6e8f.1708060779.git.dsimic@manjaro.org>
 <xmqqv86kx8h0.fsf@gitster.g> <33abb630c1d089e39ff48f04e586b1c0@manjaro.org>
 <xmqqo7cbt8a0.fsf@gitster.g> <9d0022ba5666223af94bbf450909b1ba@manjaro.org>
 <CAPx1GvcGhZLqHVz9=ZW-w+ebP64-8FpPSb_ef7ygXzDDTze2bA@mail.gmail.com>
Message-ID: <d2239d5a88ccf9806cf2873f00adc336@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-21 01:43, Chris Torek wrote:
> On Tue, Feb 20, 2024 at 8:42 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> I've never ever seen anyone referring to email headers as "TO", "CC" 
>> or
>> "BCC".  It's always referred to as "To", "Cc" and "Bcc".
> 
> I used some email system (back in the early 1980s) that did that.  It
> felt weird even then. I can't remember if it was some CSMail (CSNet)
> or MH(Rand Mail Handler) version that did it.

That's interesting, it shows that different variants were used in the
very early days of email.  Maybe even the all-lowercase "cc" and "bcc"
variants were used somewhere, at least because RFC2076 (better said,
the RFCs that predate it) specifies them.

>> Thus, "cc" stems from the old age of literal carbon copies ...
> 
> That's correct.  However:
> 
>> and "bcc" was seemingly coined when email took over.
> 
> "Blind Carbon Copies" predated email, but required adding the
> notation separately, if it was to be added at all. (I'm just old enough
> to remember using carbon copies myself, but not old enough to
> know what Standard Office Practice was at that time.)

Thanks for the correction.  You're right, I was lazy enough not to
check that blind carbon copies predate the age of email. [1]

I'm also old enough to remember the literal carbon copies, I even made
a few dozens of them myself on a mechanical typewriter.  They usually
left me with dirty fingertips. :)  Though, I'm also not old enough to
know what the common office practice was like back then.

> Whether adding a "bcc" notation was common I don't know;
> it seems it would be easier to leave it off if you made, say, one
> original and a total of 2 copies, one "blinded".
> 
> (As your Wikipedia link notes, there was a practical limit to how
> many carbon copies one could make in the first place.)

Exactly, it was the limitation of mechanical typewriters.  Perhaps the
limit was around four or five carbon copies.

[1] https://en.wikipedia.org/wiki/Blind_carbon_copy
