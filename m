Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA836074F
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837383; cv=none; b=mMdHwrMIIBUufwOpf7MtKHABdZtn61EiFgyfzRjA8cCk/SLSMHDd/Q4sTtMVBCSini4danZ1kgfUUxI2IWlrPuSE+ZoGORZNU6OhkfbFcTaZODAKEdEx6fv8EhMq3DFuCxz0NtTskMTv5qyJdZrg/lL2OUAwwyormsm7nhe2EUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837383; c=relaxed/simple;
	bh=FkFVnuN+ciGDc3rvS4aC+UqmXHJ07A2PHDbtrnkvgnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/upgEGYhHtLnCixsBb5QsESQVQ2FKa4uhzHdQ8RXKcvBq0agCM8X2ZgIs/WJm/xs2LpzRlFX/+jn1p1QA8d1vXcS3aCdIQHpscddrU6xmdOC7azQxMwi9QFfExfo1+Jz0/VORp4/RxDlgmxN61VvN4l2I1T8EQ1Exk2Js/vgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=jOjITWzJ; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="jOjITWzJ"
Date: Fri, 6 Mar 2026 23:49:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772837378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=elsW6BmP+DjAecaLIa56jOvvSR6q5E+Y5wlPl3luMXw=;
	b=jOjITWzJIPV/n7vN+uwlPDYAIYBJlm7PC1nLlqLj11Qk0binHCaW0wEPHzTeKPKMxxGFfI
	bpM8B+ByQhXatwbfv0ITxzgRYztnFrVFoWUyYGmD9AiQ7byyrMnMSap7u+11McbJHkbTUE
	CbzDJdVZwlrUEqze7fOGFWMspB3repi1FP972NXLTvRkXIXhwLwb33UJLHFSdxPGClRRpz
	uajy2hm/hSAsToHHjjO3mtr2DYftYJcqPIUrk4B1zBV62mZBSSVcr5+eDMOQ2c1Mb4N+Da
	lJNKdj+KnAPf5rnx5R2pRFYMRbZfwhUHBTrPgzAHgl6GoXearDXAT1VongVcjg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v5 0/5] format-patch: add cover-letter-format option
Message-ID: <aatZcl0KisQW0PiT@exploit>
References: <cover.1772196510.git.mroik@delayed.space>
 <cover.1772232373.git.mroik@delayed.space>
 <xmqq7broy4et.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7broy4et.fsf@gitster.g>
X-Spamd-Bar: --

On Fri, Mar 06, 2026 at 02:33:14PM -0800, Junio C Hamano wrote:
> How do people find this latest round, which unfortunately haven't
> seen any reactions to?  The earlier rounds have good discussions and
> I do not think this round misses anything discovered and discussed
> so far.  Shall we declare victory and mark the topic for 'next'?

On my tree I have a few retouches I made on some commit messages and
more importantly on the docs. Other than that I think it is good to go.
