Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8161547C5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216968; cv=none; b=EWtyANAuxtzhu2gnW7LPw9OCbqH57MasTpO3aPRDPUYogVliJMkF3ufVdMBKGHc95XmORzA0p7XhvTDfl39520bkhxHcm8QzgvFttDThsTpXzeWIVB30Smy5X8Cc1iSwqYplI1y0IXieXmSxqz4ybFmFdCbSJvr1To6Ja+LJT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216968; c=relaxed/simple;
	bh=bMhAARgQZSQIoobosHQBmJdicbgKJ8ZglJlJy2kZJSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmeNa5RozCWAT8y0X0F30wWPAd5Bo83XsXP3oXfYsfg+Rz84FF5cQ9lF17UXiEUfVvzs0rguAP+W5+JqdZsRgytEA62VI/uSLeOa3L/imbv8eK0BYPx67/QUSTy2Of9ZUS+Jn1pPSajewbyKNrXuZUZjyXlDCA7O4GNC8bbNbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15885 invoked by uid 109); 24 Sep 2024 22:29:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:29:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19166 invoked by uid 111); 24 Sep 2024 22:29:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:29:25 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:29:24 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Matt Burke <spraints@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: git-scm.com is now a static website
Message-ID: <20240924222924.GC1148242@coredump.intra.peff.net>
References: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>

On Wed, Sep 25, 2024 at 12:07:05AM +0200, Johannes Schindelin wrote:

> almost 400 weeks after Matt Burke started the process with
> https://github.com/spraints/git-scm.com/commit/60af4ed3bc60 of migrating
> Git's home page away from being a Rails app to being a static website that
> is hosted on GitHub pages instead, today marks the day when Git's home
> page at https://git-scm.com/ has finally moved. Or actually: yesterday
> (because I took so long writing this email that I ended up sending it
> after midnight).
> 
> This was truly a team effort, and I would like to celebrate everyone who
> contributed:

Yay! A big thank _you_ for carrying it all through to completion.

I cowered in fear from the project on multiple occasions. And even when
you started working on it, I intentionally avoided getting involved
because I knew what a rabbit hole it could become. So I am doubly happy
that it was completed, and without me. :)

> As with all big efforts, I am under no illusion about everything working
> as intended, I do expect some fall-out to crop up (e.g. external links
> that might now be broken, even if I tried very hard to avoid that). I hope
> that the team spirit I described above invites more helping hands in
> getting those issues found and sorted out.

Yeah. One of the reasons I was so enthusiastic about switching is that
we'd routinely see small breakages with the old site (failing
translation imports, search index going belly-up, oops we need to move
to a new version of ruby which subtly breaks all sorts of things, etc).
People will generally open issues in the GitHub repo as they see things,
and I figured that even with a few rough edges the new site was probably
going to be more reliable than the old one.

-Peff
