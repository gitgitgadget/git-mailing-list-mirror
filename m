Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A363914EE
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333076; cv=none; b=sy2xtPMX2HaWitgFS7KU6vkm/QlTynMZc+lehgUx36JccAw0zdP/yygdNDnZAfYzruypgDp91hYdeEDvn5XY57MwsIRHwR7ZgmDhhrHIQVMQKGK1dtmFq0MO3hLlDx+dwDScj6aZuxZvYOe7sl7u7L5z7iv1UGEw0tGWFiGluN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333076; c=relaxed/simple;
	bh=M46KZ5ZPzdgs0V0sfUOu/GjTGT2NCliQTnm0uTiwgJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUpNjHpkGAVoyUDM2UxOo24z8GkdiYlh61QnIrg5MyXlkO/1YAU5znrRx/JRPAdpRXiqAyesbeq69wAgzb6TB4RZ2Q+YAoVOGjYsRt5xl0wKHWZNUiTzhdU9ZC6Pj4fYCntZAgGca9H7XvggZ+NDw84MDb9NqWAwDJDNBetqdIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=W9P5mXSX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="W9P5mXSX"
Received: (qmail 10133 invoked by uid 106); 2 Sep 2026 07:11:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=M46KZ5ZPzdgs0V0sfUOu/GjTGT2NCliQTnm0uTiwgJw=; b=W9P5mXSXjE/uTz9mQYTUZcpWLAGNoc07Efg+s/jmsHHzutmE4kSbMJM3e3X03OFnHtKklbEM4ca602QRoHvmvLSuYCmBQDZ5g3f7QbBdv6LRUYlx59av60C1S7UhGyS2CC4+qSt1I0UUqBU1Uq6mLkmtqgfvVPUdBOl03TpCDCp8K6qAyl5PqL64X9lo71XjFDPdrBkvvskONIsofHVc/jwfoS5eWPevq47+2qDKGdFkvldpRPZx58U/FlJ+G5DLLX5V7t9BpcqR9KwinftLJKs9I6/nnouE7kxiEXEH8XBHB8kchNVF2FPyRY+cAomke0cp6N5GgQYmKlsmrVz3iA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2026 07:11:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 47466 invoked by uid 111); 2 Sep 2026 07:11:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2026 03:11:13 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Sep 2026 03:11:13 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: [PATCH 0/2] bump ci asciidoctor version
Message-ID: <20260902071113.GA70165@coredump.intra.peff.net>
References: <20260901-b4-pks-ci-fix-documentation-job-v1-1-a8257ee2a9a4@pks.im>
 <20260901084737.GA2973751@coredump.intra.peff.net>
 <aparyEbGiiFZpiCZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aparyEbGiiFZpiCZ@pks.im>

On Tue, Sep 01, 2026 at 12:41:12PM +0200, Patrick Steinhardt wrote:

> > But these days I'd guess everybody is using v2.0.x (which seems to work
> > fine) for local builds. We probably ought to do the same in CI. If we
> > have to catch issues in one, I'd rather it be the one people are likely
> > to actually use.
> 
> > It's possible that we could benefit from building with both in order to
> > support the older version. But given its age I doubt it's worth it. We
> > can still take bug fixes if somebody finds a problem, but we don't
> > necessarily need to spend cycles building every commit with 1.5.8.
> 
> I was wondering about whether I should bump its version while at it. In
> fact, we could just install it from the Ubuntu sources nowadays, too. I
> ultimately decided to not do that though and just fix the failing CI
> pipeline for now, but I agree that it's something we might want to
> follow up on.

I think your fix kept to the minimum, which is good. I agree we should
just install it from the system package manager. I _thought_ that might
make your fix here obsolete, but we also install the concurrent-ruby
gem. That comes from 974cdca345 (doc: introduce a synopsis typesetting,
2024-09-24) which also introduced some custom ruby code in asciidoctor
extensions. But it's not clear to me why it's necessary (and I build the
docs happily on my local system without it installed). +cc Jean-Noël for
any wisdom.

I guess installing asciidoctor from Ubuntu would also bring in ruby as a
dependency. So I suppose it does make your patch obsolete, but it also
doesn't hurt to be explicit that we expect "gem install" to work.

Anyway, here is a fix for the version which can be applied on top of
ps/ci-depends-on-ruby.

-Peff
