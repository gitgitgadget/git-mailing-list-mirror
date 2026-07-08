Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE72D3B9949
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 05:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488452; cv=none; b=rju425BrTlQrlqcLy11O2L8qz50+90rx5+SzInHJTRcZkAv3fZvreNfjIMk3FsryxDbYTvthlS9CAm+rOA8EU/CVD+Gt8IP0JIrMini/osedMDfAxLx7HXefmMhVdIUTMx5GOCPgFUIXyZBxXFnQuBQ/a8AjrwwITOFkU0gntUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488452; c=relaxed/simple;
	bh=haXXV0RVN5Uf2VGpJpdjBkZS1WnDO4nabtXs2n3sBUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChuG/ZB/XNSLzonJsIwQ37HdG/vfddo3xOoh4na2cBYSXw2RZ6UaMUuKhhH+daO7FrID/j/L7Il4Ge3flktV2y/r0ZAszJ6GDTLy2GgHmp6AiAHUQ/pQvc0w4mhTpDNlMjEIDsQLXO6WhhxJXS7VUspBXqT/aOBqG0yF/RfuceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=VIqKvbpW; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="VIqKvbpW"
Date: Wed, 8 Jul 2026 13:27:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1783488447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haXXV0RVN5Uf2VGpJpdjBkZS1WnDO4nabtXs2n3sBUw=;
	b=VIqKvbpWMMk14BAw/7YKBf7xEbPkkUPoY6Ykt4WOhSIQFQMNqm9glBmrMgKaztBgitPnmk
	FpAnpVPJzDxrBpprnGmQcLK33Tux7E8eEX0nHbKAFSgpx9iEySuuK5geL1OAlJL9aRLhQB
	8NS2FbRWP2k7o4z3MM+jbWQNGvJhYTVh14ltaZHTvz2huusc13rw+PKHwu7GO+v0COJi3l
	2sMzFI/TUN4VZFfmwC5By+Cn7d8173k50tvV/z+dtg3Hlwu1hf4bhGMqNXJcTQwcLlbT03
	sN31PBxj63O6j8IsSaI2MOk/cK5uJZt5ci//DEI6fiSXwKez9OSZKSJ6NbA/ZQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: abandoning a series
Message-ID: <ak3fr3avEmt-UJf7@wyuan.org>
References: <CAC2QwmJ8Z7hZHk9SofRsprvAR3B=UXUkeyy7i4uofRi-xEymow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC2QwmJ8Z7hZHk9SofRsprvAR3B=UXUkeyy7i4uofRi-xEymow@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Michael,

By the way, off-topic:

I noticed that several times your replies didn't carry with a
"In-Reply-To" header, which made me confused about the threads when
surfing on the web interface of lore.kernel.org. So also, I cannot pull
down the complete thread with b4. If possible, you may check your email
clients, though all email clients suck ;-)

Thanks,
Weijie
