Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CD3DAC0D
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711502639; cv=none; b=C4Rlu5NYXKmpaHFti8RFtVTtoQYpJZoIp0VBiqt7lOu9Txyya9pN5y/AzcPfDLr4HUppZZ6k6EBhTKDSeJlpxqbQoHMwm31sP/dUAj5gGeJ4WwVOXk1KMooQNbgGowK80Tub/zCJHUz4uBNehDI7koUp+7K/2WYvkGeg5JPAldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711502639; c=relaxed/simple;
	bh=oOhLGt2qGHVq0YJe4Qj2N/aDgTrWFqxBgKTufIUJ9ps=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mq/WA9ywUVN3T8MNp/iygiDIGKSDniFTzN6IPDdXP/HLLaJB5/d4zJLDXU4zYPRDBNQIlX4QbMo32iBfKb/4Q5sKsGox74bqUwtvNxvmw8uPsla2KpLhHXnmeHtsnZNIgNf9PhoJI2YqvvF/rHOfINbalCFs5tR+mAL6QXzzt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SJ57HPy+; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SJ57HPy+"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711502634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2DiTquzUjMLxiSaiB6Gk7jJsUlteTQ8shY6bIWuhQc=;
	b=SJ57HPy+Gqn3g7fq3ZDg/EomXcJ10Wdo5bSTnPUMH30PzQElWTqluzK1Ip7cZiM6Y7/I0l
	748C4NbCjjaBCpIEqFfk6vaz40gUscYtSEUy/gXlGjeO8Z2ldZ2kN5mTu389lqkzhzOsy1
	JPGntlE7ea3TesZey9FRE2HOoq0aU80nXm8/gHm/7fpxT2SUyttOOWOjGwWqfVAZzIqRLO
	dCVFhWgGnchC9C4pE6CRy3K6N+TVKO84zbIhSx0l5NvkHrJNaHgyzUf8I0demEkKusnwxp
	gAiTZp1eC3AY4Y9wHZGLFCo2wMZw066X4vhn+J6a9m2QhszgNzYbTBeo/MvSQA==
Date: Wed, 27 Mar 2024 02:23:52 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Ralph Seichter <github@seichter.de>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com, Chris Torek
 <chris.torek@gmail.com>, git@vger.kernel.org, Ralph Seichter via
 GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 3/1] config: allow tweaking whitespace between value and
 comment
In-Reply-To: <871q7wv7s1.fsf@ra.horus-it.com>
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com>
 <xmqq8r2jp2eq.fsf@gitster.g> <xmqq4jd7p1wf.fsf_-_@gitster.g>
 <xmqqcyrg7imy.fsf@gitster.g> <874jcsvccq.fsf@ra.horus-it.com>
 <xmqq4jcs7evl.fsf@gitster.g> <871q7wv7s1.fsf@ra.horus-it.com>
Message-ID: <8d05e767aa5ba30e91522835fb2941b8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Ralph,

On 2024-03-27 01:27, Ralph Seichter wrote:
> * Junio C. Hamano:
> 
>> The easiest would have been for you to say "Yup, the two additional
>> patches queued on top of mine seem to make it better. [...]
> 
> Would it? Well, you wrote the following two weeks ago, among other
> things:
> 
>>> I thought we already discussed this and unconditional "#comment" has
>>> already been declared a non starter.
> 
> This unilateral decision of yours, and the following prolonged debate
> about spaces/tabs (which I clearly stated I consider a waste of time)
> left me with the impression that what I think doesn't matter much
> anyway. Also, it seems to me that this whole subject has already been
> blown far out of proportion. If this exercise leads to the feature I 
> was
> proposing, you guys can do whatever, and I won't slow things down by
> expressing my opinions, or by continuing to formulate my own commit
> messages. So much time has already been spent.

Well, is getting patches accepted to git hard and often challenging?
Absolutely.  Do additional patches and discussions sprout all over the
place?  They obviously do.  But, does a high-profile open-source project
deserve such an approach?  Without doubt.

In fact, pretty much every good software project should employ such an
approach, but that unfortunately isn't always the case.

That's how I see it.
