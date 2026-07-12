Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D5B3A4F32
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783861985; cv=none; b=Lya/SVUks/o4eCIMKo17DigwNl0oVgIi705my6rdBztmNJYmr6hrHhVg4vfPkQqTxPiXR6F+apC78Ahd27cqxdV6DdiyD9ySTiVHjAp5N6S9c2v5uLBdI5w5BXyZJZicoAk6Yk0lEwlq/3q3lI/zKNtDb2SnqXGezohNryNDmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783861985; c=relaxed/simple;
	bh=9VKGU+gV9MGMaUrkHAGd2vpRqjjIu2lyDtQMYxRzrLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgM2obdQVNBYuxEKbD5GYQAVoPeslaqZqkRYMq0h3fEnE2Lm2HWIWEQYBoGk5Y4j4KcqNgw8NDoOEVXxcTbb/iGc4UroYqD0obIdk/wrfOCAJNyVX1iQffJ8zWNF2SSVOYCLyLzd5eX0TFpqej2DvHO/fdiMlVnmuyom51Z+pkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Y64uOpsz; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Y64uOpsz"
Date: Sun, 12 Jul 2026 15:12:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1783861981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VKGU+gV9MGMaUrkHAGd2vpRqjjIu2lyDtQMYxRzrLA=;
	b=Y64uOpszRVBeQmaOooUSAQTx6CluadqXXFB2tX6yLVJeuYkrAaIWFRBpeKe+AHu8ccf7ux
	uMYQIV26hENTTZm55wQhwH6pgdVhvtW+2nw6r7LsaCHhFbCTMO1cmcLToFziduLPpdmAoE
	aMKI/y6V9Deq3upk/QXSx4qoXOXvm/TnHOzUtWxtVxPs/qEJ+esMc6OZ60R91hPJjxrEBa
	lUIzCqZx1pEvTgRfvWPd7omQNx+0UX+5bptHE3qnoC/l7bq3AytQbo4vnPrU5trLM/kR9Q
	FyRvHIQpVUZP8JzLGFAS9kDcahiH4FgOw2lSOQ/WVvlcS6Fw3P4iDE6sPXMKlA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org, 
	ayu.chandekar@gmail.com, christian.couder@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, karthik.188@gmail.com, krka@spotify.com, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v9 0/4] graph: indent visual roots in graph
Message-ID: <alOSir26zBU5QO0k@exploit>
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <alJOgYmAfGg37hsB@exploit>
 <DJVUU76PUXR4.2BYRTA8SEEBVC@gmail.com>
 <alJpjTXfZmYQccwk@exploit>
 <CA+J6zkQcHu-LVKE-1ypfT=59gEzo4qBzi-pmhSJNC_udCDCJZg@mail.gmail.com>
 <alOOXKGIB8BqACxR@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alOOXKGIB8BqACxR@exploit>
X-Spamd-Bar: -----

On Sun, Jul 12, 2026 at 03:10:49PM +0200, Mirko Faina wrote:
> The difference between two indentation levels and no indentation is very
> noticeble, I don't think anyone confused this. This would fix the
> staircase pattern on adjacent one-patch series.

Sorry, meant to write, "I don't think anyone would be confused by this".
