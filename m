Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323E2237713
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015098; cv=none; b=e/n3aOjFma5InTI4JRzQUJmZhcvPaGgiYQLhSrCBwPtKDrlOSMdjc3jRduje0EorNvB9LXg+ZqffQ/oZl1CSGcipQLaVVrJbivTEfv7+vbU9/AgMwv/r6YVkpveBbMBadbtoc7vRSX+DeV5cYL5lx0H4Of5nr/zsdWO7vCKirlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015098; c=relaxed/simple;
	bh=hZ+YQHYZeAKcdrrDshp/pf73hZn2b57vmqPGmJVhuHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSXeHtmWNzfg4/OfEyIjfVoibh6zDPnK2K870E/ibpJeNrAuV7Ha27CZpIYKtyfyX9QtgLOyxzQ8bE6Ju40Ie+db0i8tCdap8b0bPJ9a2LWSR8rI6GHezg0RWmBYoK5P/oux9lkTt3ZAWM+b3stoecP8lQtm+SwHparhFH5D4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AzWSOsAI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AzWSOsAI"
Received: (qmail 17165 invoked by uid 109); 8 Jul 2025 22:51:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=hZ+YQHYZeAKcdrrDshp/pf73hZn2b57vmqPGmJVhuHk=; b=AzWSOsAIv+iIPyfT1AYJJrAQjfpcyzlWzI8p5OcpvN65B1wWkl6uEcFZ2KL+LYInU/1jppsMXnYxp6+DyECnm77MMWdfKE82NTgjLK+YfyCeP/FGvH6BtBCMeLny3MjILy3snQroxuc47VXfOpbkU4XjXNenKLQGKOGzymGOYrI5TKNzg2C9KxEkvUwCpU0kHBPaMpqOJb9ZK0abd5e48AIUYuohqD/ykwQlumC7OnjI/Lw7ef5wBxQLAa1kLKNg9Gj5+FShbJANUFFw6b+KqDbMyNPuNV1sE+0QAnYjEEVi2JPs3Wy0YfufZdLMK7TowI8sECqpgHh/dzZ+HL210A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jul 2025 22:51:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30490 invoked by uid 111); 8 Jul 2025 22:51:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jul 2025 18:51:37 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Jul 2025 18:51:34 -0400
From: Jeff King <peff@peff.net>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, redoste <redoste@redoste.xyz>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
Message-ID: <20250708225134.GB1180568@coredump.intra.peff.net>
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
 <20250707204224.GB3115893@coredump.intra.peff.net>
 <CAN0heSou=BgC8ec9ZE+V-pYKt+XQiNfOBHj-5CZY8s5XCatZTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSou=BgC8ec9ZE+V-pYKt+XQiNfOBHj-5CZY8s5XCatZTg@mail.gmail.com>

On Tue, Jul 08, 2025 at 09:10:44AM +0200, Martin Ågren wrote:

> > I.e., why are we sure that it is OK for us to loosen this requirement
> > (without jeopardizing the legal status of contributions). And I think
> > the answer is along the lines of "the kernel did it, and they checked
> > with lawyers, so we can piggy-back on that work". But it would be nice
> > if we could cite that source, and maybe even lift some of their
> > language.
> >
> > Looks like the kernel commit here:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
> >
> > cites CNCF here:
> >
> >   https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
> >
> > I don't know if there's any public discussion or statement from the
> > Linux Foundation or other legal folks on the kernel's wording.
> 
> The commit is "Acked-by: Michael Dolan <mdolan@linuxfoundation.org>",
> which seems to be a lawyer at LF, e.g., as per Ted's post elsewhere in
> this thread. So that could be seen as some kind of statement.

Yeah, I agree (and didn't know that before; thanks for mentioning). I
think mostly I was just hoping that some of this reasoning and these
pointers would make it into the commit message.

The content of the patch looked OK to me, though I do still like the
CNCF wording a bit better.

-Peff
