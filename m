Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3183CDB
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533296; cv=none; b=u8LVFoxFsZc3sp03r6LUTQjGBroD/Mg01nlxjj+qG8mL3QIGmSGfywhvGFtpCN/Td4f5h7Az0OASSCFLEHvU+EWT2/p7MWUpu1irxWNjg1Ck76vDYorwUz/E5wyY01wFCZ8zKDvPvu1Fq/1KC3/KVLENW6PwzGszL90FjrTxee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533296; c=relaxed/simple;
	bh=o0FqbWK5sYZCvHig2aJuFM/Pwm/L/CVXxgfD8aeVyYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3XmVuY/CIAeF/LCWHsuj/UnYGWzupKKHA2x9FdaqlvUSMDhW5weQxbIUekR2JTDS+iHS/k7RReC0XIQxTAmlUDNOUMTxHir8Fum/mDrYadByEnXNe5M692kl42LE1XDkeh3QOTXHFzttHr3j3O9uIbYxbR6uuWv012UPpBfIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7435 invoked by uid 109); 5 Sep 2024 10:48:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Sep 2024 10:48:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8161 invoked by uid 111); 5 Sep 2024 10:48:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 06:48:12 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 06:48:12 -0400
From: Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH v2] compat/terminal: mark parameter of
 git_terminal_prompt() UNUSED
Message-ID: <20240905104812.GA2598693@coredump.intra.peff.net>
References: <ce1c1d66-e0eb-4143-b334-1a83c0492415@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce1c1d66-e0eb-4143-b334-1a83c0492415@ramsayjones.plus.com>

On Sat, Aug 31, 2024 at 03:58:56PM +0100, Ramsay Jones wrote:

> Sorry for being a bit tardy with this, but I'm up-to-my-ears! :)

Well, then I don't feel so bad about being late to respond. :)

> I feel a bit sheepish about taking authorship of this patch, since Jeff
> contributed way more than I did to the text! (I was going to count the
> words to get a better metric, but I have to go out now; if I don't send
> this now it will be tomorrow ...).

This looks great to me, and I think the authorship is fine as it is. The
hard part IMHO was finding the problem in the first place!

-Peff
