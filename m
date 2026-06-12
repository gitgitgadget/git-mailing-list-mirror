Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017426FA7A
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245042; cv=none; b=oEqSpOzXc+F0wFsukQuWOhKZOtWiEZs//E0ldTv/M+Cvoi4O0Rk95zGeHZcNZbQGY0HyGt0NKJE4deRXQDFmzxOxN/61uUbi46wd0NMWqmRnwRx9ObcJrK9nCi4FVdkB+JURRiqSbLOtmz2Dd7oOOgi3+0dTxjrCrtY+soFL9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245042; c=relaxed/simple;
	bh=KChz7+TtP17nSxSyNWJZChHXzls+Alz/RvyY4jA6H/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeujS7EanDWI71DinmdHyseO101Z9gH8FVlw8qxFrDnyWrRAnQ2B296UDroMtlGbysiScZBSoM3Mh+OqqrSv+66DeJRhFa7jRkGQM9e6zDhXtheRuw+3wpelu+mmcOyCJWnRU3aPTTxXT3wbe0OBP/g50DwvXeajbPZezYgp89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Dgke/zwR; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Dgke/zwR"
Received: (qmail 114125 invoked by uid 106); 12 Jun 2026 06:17:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KChz7+TtP17nSxSyNWJZChHXzls+Alz/RvyY4jA6H/w=; b=Dgke/zwRgeoZ7Q4NpID6FORE55A/QlTjiXFxHUjalcithdrtCoDxfH9ZAKcEzant13mRjENjTVS6dxhva+T+tYOMXc2xb9Buar/k1fbZl1NXFISiFPq+9flN3CobIswDdoSWlVoniIjlonfHWI+lNgrezZdyIJ8fO56S2bveByexVZPTgY312DXN4xL71qh+91W9vIInMOmI5YLedS0jh7RpymCDXoXYq/uQcffC62Z7ik5qo/85wHacJwxJ3AMdPu57luoHpfO909au/KS38q5LbAUwwUMbyIolQU82/jC4nprqH3y/bADTh3JGmHbQWRPTllQWqfJVYJbwYTUxMw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jun 2026 06:17:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 334441 invoked by uid 111); 12 Jun 2026 06:17:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jun 2026 02:17:17 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jun 2026 02:17:12 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] doc: git-config: escape erroneous highlight markup
Message-ID: <20260612061712.GA675816@coredump.intra.peff.net>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260611062423.GA2189088@coredump.intra.peff.net>
 <20260611062525.GB2189088@coredump.intra.peff.net>
 <5106812.31r3eYUQgx@piment-oiseau>
 <20260612051605.GB593075@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612051605.GB593075@coredump.intra.peff.net>

On Fri, Jun 12, 2026 at 01:16:06AM -0400, Jeff King wrote:

> So...weird. groff wants to add extra space for some reason. It happens
> even if I drop the bolding, and just have "#" on a line by itself. I
> guess maybe it is the trailing "." of the previous line putting groff
> into "oh, I'm starting a new sentence" mode and it uses two spaces.
> 
> But I think that is all outside the scope of your fix, and this is an
> existing issue that we are now just unlucky enough to hit. I'd be
> tempted to ignore it and possibly fix it later.

Poking at the groff manpage for possible fixes, I think it is either:

  1. Just turn off extra spaces between sentences, like this:

       .ss 12 0

     The first argument "12" is "the minimum word space is 12/12ths of
     the current font's word space. The second is "also add 0/12ths
     between sentences" (so, no extra space).

     That prevents the problem from happening anywhere, but maybe people
     really like the extra spaces in other contexts.

  2. There are some magic characters marked as "this doesn't start a new
     sentence". We can set that flag for "#" like this:

       .cflags 32 \#

I don't think docbook has parameter support for either of those, so we'd
have to do some kind of "shove this into the header" magic, which is a
bit gross.

-Peff
