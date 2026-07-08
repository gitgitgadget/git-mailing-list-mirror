Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35553BBA0D
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491739; cv=none; b=eyOs7Hm1nK5r2lwrAgdI3ruH6eqjR+WA7KWdUR73pykYzCeUiTmDquayJhcgufT5vR8OreXDBBLfmrV4ebujtSs6BvzrYluYvTxFg53yGpVHzfbGZ7JnbTywTwOdLkRVjUcaY6fmqpmVyS30uLFqMU2fMjim5LZWCWPI0ppIrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491739; c=relaxed/simple;
	bh=Y/XCzDl5L8nGqorgGf90fE8kAUCfsKlLSJgV/80uoyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcBI1JnbqM3npRnme1cgzp/CIKWK/dGol/7qmrgq7GXyP5EmJOuz320lxjUANDBCxxsFJ3rCMW21N3OmakjOIdhbeNVb59HxHK04xHGUnnYRMz7TSBNmQJLgUehC3kbn58npDXXzxcIBz/WkEuMvA6qM06zeRwpnJStWlJU4qAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=OzuH4jTW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="OzuH4jTW"
Date: Wed, 8 Jul 2026 14:21:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1783491735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/XCzDl5L8nGqorgGf90fE8kAUCfsKlLSJgV/80uoyo=;
	b=OzuH4jTWupaBMyrhHkaRGckai+uHHCj2wOuNwIozU48/6q3VaqCntlzFQW97vSkQ1YNQR7
	GnyBH8RRyifoaEaN2/MrCjOFOiPCrwxwAgtLJq+PRWpzCiEJpvmqB+Px9jf8N9nEj5Nztw
	FHPs/5GDMqQHYjn4QSiEqJKb7WaEUumkuQWDB7mCPPv2lEzqP+f2ImPWqEiFhrr4ExS1UW
	lxcE36gbhsq0q1DfyFgmLElDyxCEAqR0L1fpTmBrJQol9g/cjuYG3pMxyAWu4OgEKFB/KN
	Z4hqEP/G/Gt8b5/VFY//+9ULyeZh/3frc/kVIYPBZcHD6jUBaz4bd1joEHW31A==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: abandoning a series
Message-ID: <ak3sgn8Eik-B6DWH@wyuan.org>
References: <CAC2QwmJ8Z7hZHk9SofRsprvAR3B=UXUkeyy7i4uofRi-xEymow@mail.gmail.com>
 <ak3fr3avEmt-UJf7@wyuan.org>
 <CAC2QwmK2kFBNRT47i4k-zBK+b0PFezLFbx0eO8t7DqT7tTnKhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC2QwmK2kFBNRT47i4k-zBK+b0PFezLFbx0eO8t7DqT7tTnKhw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 07, 2026 at 10:41:53PM -0700, Michael Montalbo wrote:
> I think my workflow for replying to threads I am not already a part of is
> flawed. I usually control-click the reply mailto: link on the message in
> lore.kernel.org/git. That launches Gmail then I manually craft a message
> and send from there. I will spend some time investigating my workflow
> more deeply.

I guess you are right. I suspect the Gmail web interface is the reason
why the In-Reply-To header was lost here.

> Thank you for the helpful note!

You´re welcome!
