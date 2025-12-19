Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610BA14A4F9
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766129559; cv=none; b=fyf8GcHM2V6Tv5WM0Mg2hKYP3t1BY1o0bvCh5EmOQGL1E0z0cVmT6u6yz1dF0QZgnIgI87iDXMCWr0Cic4FBEpoJHc5dFjH4MDYRanUavIyq/EGMk2jhVsvEqQF8UvCoR0KBk7WO5QSmBhRdfDM+EQS5gs8zzw+TQtoHllAKzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766129559; c=relaxed/simple;
	bh=izzHvklOBTqhJCnTFpY/CKKAqwco1YAt1C/JVT/mCi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIixEsG3U6sN4BllT3EFPxA4Jt9K9CUe3AsqGcLu3kZsm4VBYPDljefIhKFjxAW0619N82q4mZw0K0+luuZR4Y+vYjeJDbUc5zwLILjbEEWkLdZt5ZVOFobbnvacUCbgRqnLNFsG3sSkEkBbYNpxea48NtkEvMzt3biyB5qaOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UX6WqVuz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UX6WqVuz"
Received: (qmail 396415 invoked by uid 109); 19 Dec 2025 07:32:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=izzHvklOBTqhJCnTFpY/CKKAqwco1YAt1C/JVT/mCi8=; b=UX6WqVuz+H5xzbdxPV1Hslgg+qIqRaTfoRdMt2Dn7UyUpmJwG8qrY4ev2OMcJ0ynI71zsgefmRcwOqS9DaAdKt2KCwxjsQFDlL0UfMQtZcvaWrjJ12JNPbwf6C/WF4VOyaADWznPZK9/6UwA6hCye57RjWgY1rg/lrGwzv/vED8u+mz3fk5cGml4Xr5lCrb8QOFx7T/zZ6iYCyauJm7wGX73vQQESCaSzz0r+jGYCUav425m4RgkDKmMwVIfGWmDMswgTf9cHvvCdzVhEqhHjiCwUHEqEqzA7ZGLza868SuemQcHGBsPOjaBySIp7MP9aZV989wdCDzQ4jv57elcTg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Dec 2025 07:32:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 530139 invoked by uid 111); 19 Dec 2025 07:32:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Dec 2025 02:32:36 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Dec 2025 02:32:32 -0500
From: Jeff King <peff@peff.net>
To: Matthew John Cheetham <mjcheetham@outlook.com>
Cc: git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 2/3] t5563: add missing end-of-line in HTTP header
Message-ID: <20251219073232.GA3784564@coredump.intra.peff.net>
References: <20251218121120.GA3252258@coredump.intra.peff.net>
 <20251218121819.GB3758205@coredump.intra.peff.net>
 <FRWPR03MB110658677899817CC49A50DE7C0A8A@FRWPR03MB11065.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FRWPR03MB110658677899817CC49A50DE7C0A8A@FRWPR03MB11065.eurprd03.prod.outlook.com>

On Thu, Dec 18, 2025 at 01:41:54PM +0000, Matthew John Cheetham wrote:

> On 2025-12-18 12:18, Jeff King wrote:
> 
> > In t5563, we test how various oddly-formatted WWW-Authenticate headers
> > are passed through curl to git's credential subsystem (and ultimately
> > out to credential helpers). One test, "access using basic auth with
> > wwwauth header mixed line-endings" does something odd. It does not mix
> > line endings at all (which must be CRLF according to the RFC anyway),
> > but omits the line ending entirely for the final header!
> 
> Aha! Yes, the test should be using *all CRLF line endings*, and is
> poorly named. I believe the intent here is to test mixed *continuation
> line* characters.
> 
> E.g, when a continuation line starts with a space, or a tab character,
> for the same logical header:
> 
> WWW-Authenticate: FooBar param1="value1"\r\n
>  \r\n
> \tparam2="value2"\r\n

Ah, great. I'm happy that my guess was right and there was not something
trickier going on (which would have made coming up with a workaround
more difficult!). Thanks for confirming.

-Peff
