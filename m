Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6B1D5ACF
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339456; cv=none; b=lhJ301jv2UM+4DiBUacYcDaNAutmIXAz0LMDdP8yP3zYanZH3ZLECJ2VuOEqytLKsclbavba/Dz27k2EMoUNrq6y1P/Iml4OiioKxMdw4rZ4lRcnsZMMsUHHIf/x89BcgWabjRWKK66ksxGDMlmkqEgBu+sCrvaVHrPBrtV0wN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339456; c=relaxed/simple;
	bh=J7tuFV4kMnssrcu86zw+yMsQzm7y1tnFstzwrv6olaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JS5VUSz/cdnkhWQuSEcIvceTxnQdkC+CjCXw1SJrxt9MzPzg2czlD5uGP3Ofrt9ZUWPGFJc2+tOQ/u0wuBpy0lgRFxNGctU4jk4A9uCr1FQqcLIBqAVz+jBS3syrl0tAL8k3zzcJTJ/zuEcYPYcpvGC75MAG198Ys5Fgone44ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=qPQcBZ2f; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="qPQcBZ2f"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1727339448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OsU4gAbfrVIQThvhkuCqx50Oe6rzKCwaL0bA39ozft8=;
	b=qPQcBZ2fqlAChLwaXXFJsybOYRi0RdrimxROnyJIlg1NzfxmIio93JgxZiiZyX8wXewtxZ
	LR9gO3EEvj0jlN7pT+3nFInl9WTWaZp1kPkUaaHypp7x/pWFekYRL4VInVO6RLLWuzuUUD
	1BhDLiQrYiSiJP6QOdTF0C/mzbF79I4=
From: Toon Claes <toon@iotcl.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Cc: Matt Burke <spraints@gmail.com>, Victoria Dye <vdye@github.com>,
 Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>, Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>, Todd Zullinger <tmz@pobox.com>, Johannes
 Sixt <j6t@kdbg.org>, Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
 Toon Claes
 <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: git-scm.com is now a static website
In-Reply-To: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
References: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
Date: Thu, 26 Sep 2024 10:30:28 +0200
Message-ID: <87o74a4y1n.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This was truly a team effort, and I would like to celebrate everyone who
> contributed:

Amazing job everyone, it's really impressive!

> - Toon Claes for not only pointing out that the style sheet for the search
>   results needs fixing but also for fixing it right away,

I only wrote five lines of CSS, but thanks for having me take part.

> You will note that the site looks pretty similar to the version before,
> and this is of course intentional.

That's the best thing. Nobody's gonna know...

> There are also new things that have sprung up that are not caused by the
> migration to Hugo/Pagefind, for example some diagrams no longer shown (see
> https://github.com/git/git-scm.com/issues/1862) because the Google Charts
> API entered the Google Graveyard. Any takers?

Yeah, serving static images makes a lot more sense. Unfortanately I'm
not familiar with d3.js.

But I will have a look at the GitHub issue tracker if there's anything
else I can help out with.

-- 
Toon
