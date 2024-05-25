Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0293A1A2C04
	for <git@vger.kernel.org>; Sat, 25 May 2024 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716607593; cv=none; b=rXW8ikt8l8CG7WATq45y3tamnNzYHVVipLTCvFyJ4dd7WMXlsBamR7Tu40jeiPY/99iv/LFEsYcEeOgRj+syMCuKXa9mjQlmCIlBXrlWN5YY6dwPXPVxLf26AwVg4Gkw87BpWM1d/pBtQ/+tAcFstKNKtHNI58YlhMrS2OmYEpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716607593; c=relaxed/simple;
	bh=tR0Ow+MCOj+cDaOzn/TvjeB6Xr728amQQ0hFerFJFNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6WptfKHO1BUhwSNqKbWj5hJ+uYz2cIahEJk7Iqkxmb8z0QJh91VbqF401rIV1FieAtkKyyZAwkWKKZIYHLq5QJuXH5G8KzbrWIgnHqXOTScvIlu5Msn9rPnYSE3mVSaNqTJEFKyzKMuk5scuYrickYaipZLSnbiCGalHFE1JRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3914 invoked by uid 109); 25 May 2024 03:26:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 May 2024 03:26:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15412 invoked by uid 111); 25 May 2024 03:26:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 May 2024 23:26:34 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 May 2024 23:26:30 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/24] pack-bitmap: pseudo-merge reachability bitmaps
Message-ID: <20240525032630.GC1890223@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

On Thu, May 23, 2024 at 05:26:06PM -0400, Taylor Blau wrote:

> Here is another reroll my topic to introduce pseudo-merge bitmaps.
> 
> The implementation is still relatively unchanged compared to last time,
> save for the review that Peff provided on the remaining parts of this
> series.

Thanks, this version looks good to me!

-Peff
