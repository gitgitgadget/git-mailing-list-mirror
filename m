Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01C3939D7
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380796; cv=none; b=hXGKmN8CXWyrr6ueNwDhAyKZSIAU6s7EOAS9GGGqOZvm/XpLHwg46hKj2fZPUthkaVgJCi3n+RBRIClY+pxBaS100ZBwnHr49R3DaoNkYySXzknBpOmeR4d49nAvNBeBoIb0hpeJBy5QzfQc2Nd+2SjqTi7djoGosMixjmugJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380796; c=relaxed/simple;
	bh=/xphThxiVUtGkIP/GPzZK5wJaA5jgk5AAR+v4ptAKtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skhWIdBb+QW3EsjtiQIcWuNkJdZJ+2z/PekqQtZPbnykhp3/HYMKfjNHkSI6jHZZ0fJwpVkMWHWrjA/rC8wdRRSBVgfUxwwPafoKBX1Fzaw99vhRj0Goc6tz0e9Qr9yohFCGLYwCauy9gJ2mDHOYBCR8PL5LjVtP0NwkQ4NpEwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=GhR3GBKD; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="GhR3GBKD"
Date: Tue, 2 Jun 2026 14:12:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780380790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=frQa2Rm/tYzYTTGO8Z/ZRHbEWd6YMcg++INOvhJ7ZyE=;
	b=GhR3GBKDyI9AOlE739o/+N2+qoMXDO34TNhXAmVqd1+8xMtYnltHA1IadVk5g/J8DEYv4p
	CM+NdSVirnhi7stJdU4whcQK7xndxR7bmiAZxd80VNRyF5TrTXv22uCnAOCo/1Ha3oZLUi
	I4vm6+q9gsHpqocKxvohVW1E2hlpJA3z3cfXKclsp7LWl+MNH+me8DNP0d62hrvfl5zDrh
	2AU8XNWAwq+QIQQIPO7hUvTY9+pg9EzDBw6v64Wc32B2LWqSEpvdZePFvsN1/sCQmtlq3+
	LtfEwpE0MTArbMl5i3a+ijQsc60xolVGHzcU/T5xblZ1m9trT61pfJARyEM41g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrew Kreimer <algonell@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs: fix typos and grammar
Message-ID: <ah50ZDJ0zwpz8IBv@wyuan.org>
References: <7b502e20e9495cd4720496bd6738a1fbeb453410.1780041658.git.wy@wyuan.org>
 <xmqq8q8x3nox.fsf@gitster.g>
 <ah5xFk36HZGWdCND@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah5xFk36HZGWdCND@wyuan.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 02, 2026 at 01:59:01PM +0800, Weijie Yuan wrote:
> > How does this patch relate to the large patch from Andrew that you
> > reviewed earlier?  Is this meant to replace it, or is it an
> > independent effort that may or may not overlap what is fixed by the
> > other patch?  Something else?
>
> My patch is an addition to Andrew's patch.

Sorry for not making my point clear all at once.

My patch is an independent effort and does not overlap with Andrew's,
i.e. doesn't touch the same areas as his.

And I just checked the recent archives, my patch doesn't overlap with
others as well :-)
