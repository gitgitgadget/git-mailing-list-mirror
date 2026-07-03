Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841EC1A6816
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058602; cv=none; b=CACX5twiiwCS5zJntleeG+wcAkV0tPkDxligGHMSIppUKnwBSklFDrh6o/FNs1gV2bLIoCWk+wb8lJ9P/ntjGXqfjVcamfZ3mRVsfMIJBlrinba3s8lcGGzn6mVyF5KuZm223QHEHWTs0icTcxxpZ5QbpZZijSriWLy3lAKk09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058602; c=relaxed/simple;
	bh=EIqxHeLbVtYJPoIvI/e51ytQxPJDtVoqnI8d2UzSsos=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=KC3dc5Tq3Rimkck4T4QI2UsYQPSHt1ZTAdgBBrZVm094fHX9gIvon4v2sNeYMudz/j5rD81YYsWLcBc+g8QTOy3niouSTLSvDBYAWn4BXKNoCu4ChsrQjrrQ4VO0rRrrDOliHqCaMaoDjD6u4UDEzQzLe2dG3LKdJjRhUeFbUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=Li64Wi8J; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="Li64Wi8J"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id F3E0260006;
	Fri,  3 Jul 2026 06:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1783058593; bh=EIqxHeLbVtYJPoIvI/e51ytQxPJDtVoqnI8d2UzSsos=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Li64Wi8JJ/3I9ZeggOOcnSosngS2ygNv+w+L7VWB+JVdTgZf0qU0xCdO0HleBMBLg
	 HCRLqhO4uXnlzZo8TICCUdVv30G7WVnMbOewsrC3LWJ2KnH3Rwp1q38gEdGk3uFpIX
	 CHjP7i/gozyAFd4fhomEL8bHofxU4yIT7KgQiis4=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 02:03:12 -0400
Message-Id: <DJOPIP6EQWWJ.H6X9L009RO1W@lfurio.us>
Cc: <git@vger.kernel.org>, <adrian.ratiu@collabora.com>
To: "Mike Gilbert" <floppym@gentoo.org>, "Patrick Steinhardt" <ps@pks.im>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH] meson: restore hook-list.h to builtin_sources
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701193928.358825-1-floppym@gentoo.org>
 <akZGJP1kVtjBFN_e@pks.im>
 <CAJ0EP43gyQf_XhCLCNEzCq9wMYXZBQX=PWjR-wYqoESSvByJiA@mail.gmail.com>
In-Reply-To: <CAJ0EP43gyQf_XhCLCNEzCq9wMYXZBQX=PWjR-wYqoESSvByJiA@mail.gmail.com>

On Thu Jul 2, 2026 at 1:03 PM EDT, Mike Gilbert wrote:
>
> Thank you for the review. This is my first contribution to the Git
> project and I'm trying to follow the lengthy SubmittingPatches guide.
>
> I believe we have "reached a consensus" and my next steps are as follows:
>
> - Add Reviewed-by (or Acked-by?) for Patrick and Adrian.

I believe the typical etiquette is to only apply someone else's
Reviewed-by trailer if it is offered to you.

> - Send the patch to Junio with the list CCed.

Generally speaking, I'd wait at least a couple days to see if _this_
copy of the patch gets picked up into the 'seen' branch, before
resending for this purpose.

>

I _would_ give my thoughts on the change while I'm here, but I'm not
nearly hip enough to the meson build system to leave anything useful

Welcome to the Git community
