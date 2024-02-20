Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FC36135
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457911; cv=none; b=ogcuwlKSFA1wruSzTBXfcB8ojCbQMfjwuDzKekm9pm295qLs4W0ObLl81lR3LQta6ZjvsnoXPt0rQElKvlA/fMcUeO+BI58Ns+tyaRFnFDyI+kmB/P3FmuRNd4fWnSiVfBBW/0prvntX8yuciteyOwEDVONpOsnlD0HghGmWXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457911; c=relaxed/simple;
	bh=DRz/CNBi31Og0Zp0L2vXT2FqRD95KJbM/HDcA+njTOE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RfHQGQTL0hA9LzUpGiWarrIPiD7Hc7RJxkPF+gdFa9AnqJSuCQk8F6FM5/H2rhFPZVkiNjsU94YPYoq9a84hhrHTjs7Pe3QDh5+2xVhNF9J1uGuWdmgGbRirHhMQgH004seJ35oqYxBobAUMPg/Uv5UBazH7AfO6hjRJfinW8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=hPt7CXa2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hPt7CXa2"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708457907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmCK2/l8wKPgRF3e+YWH+rvBI1LRlPEzXeAW2EqPnl4=;
	b=hPt7CXa2pHcEqRrphtmeeywOjNkf8ht32q8rudHN3fcO8TIlC+dUd4Omq6m9g+077hLbhD
	L8nZx2FViWApOamIGkp5S9dblHBzq7ixxwL6w/a74wPCtkMLnqc3n6Or1V881m2y5Lb1h8
	RaftRZxSaDegO4DEPTCPFnqIIxxpmWjbKFbhf7N2fKZxqzvR85AGR8z/mbJWdVKWsAzWCW
	VnHw7g7SaE3sdIAXyaxS+kDCqyusqJk5P1bKfgEDY7pI2+Lnbt1JuBYlXz9JCZ7ITrT5En
	a4BBAnoG1xXjZq0pWCmeZtaT4rnGOXeQgaaW9DAgitNUDxS4KhAxOQEBZQJHbA==
Date: Tue, 20 Feb 2024 20:38:26 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] documentation: send-email: use camel case consistently
In-Reply-To: <xmqq8r3foup4.fsf@gitster.g>
References: <b0577267402f6177d8ba5646e12d7691437e6e8f.1708060779.git.dsimic@manjaro.org>
 <xmqqv86kx8h0.fsf@gitster.g> <33abb630c1d089e39ff48f04e586b1c0@manjaro.org>
 <xmqqo7cbt8a0.fsf@gitster.g> <9d0022ba5666223af94bbf450909b1ba@manjaro.org>
 <a766ba7eb27f663eee34214714f6076d@manjaro.org> <xmqq8r3foup4.fsf@gitster.g>
Message-ID: <db01d88aa08d33f366b836170e4eb605@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-20 19:29, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> If you insist on using "CC", I'd be fine with that, but frankly, I 
>> think
>> that would actually be confusing to the users.
> 
> I do not insist; my job is to just reject what is not correct.
> 
> In this particular case, I do not think Cc is outright wrong; it
> is near the borderline, but I do not know which side of that line it
> sits.
> 
> I gave you one possible rule to decide what to capitalize (namely,
> acronyms are spelled in all caps and that is how we capitalize
> http.proxySSLCert and imap.preformattedHTML) and if we adopt that
> rule, then sendemail.supressCc would be incorrect, simply because
> carbon-copy should be spelled CC.

Please, let me remind you that I already fully agreed with using
"SSL".  The same applies to "HTML", for example, but "Cc" should be
an exception to that rule, IMHO.

> You need to give an alternative criteria that is easy to understand
> for future developers and follow, and explain your choice in the
> proposed commit log message: "We spell acronyms in all caps like
> HTML and SSL, but in the case of carbon-copy, we spell it as Cc
> because ...".
> 
> You need to fill that "..." is in your proposed log message to
> explain the choice you made in your patch text.  More importantly,
> it is to help future developers so that they can easily follow the
> same rule to spell the variable names they invented in a way
> consistent with the rule you followed in this patch.

Agreed, I'll provide a detailed rationale for using "Cc" vs. "SSL"
in the commit description for v3, with a few references.
