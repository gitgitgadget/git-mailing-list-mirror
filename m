Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4011CA9
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167490; cv=none; b=IJyyw/UFxZs69EtF6iHYP+wXUL8gz4Bcke6NX7VyRQ+SG9fQ+OTNZ9/iY5ax9hzG3YQSZuVSAdCYGDgpc/OasrjQhMtzo2zqE2gJ0WSzdnCtIZ4oCyIvNoQJ6Ny2n4H7Pl+wsedyjFLR4wokZg/znIicPuL9F4kep6ZJPH1qpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167490; c=relaxed/simple;
	bh=ghfNaGgimpbSfgWlkRbNySopqTSaGue2ikWhPqgbSN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szLVVMPXylHFAa+Xk6B9FTUan+qqos4knja7rpDVrC/jcpoI2NDfSiHpScTTasLA61Zu+7e4REiHlQMv0Mp0ffXUQrVBg6pKU8fjTGa6EY0zd/0BEkYw0dwbB8dXfwvkqOD81O/PDL6/ZV7+YUfqIxUIHVOVPOcZckQqY5W8ujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24438 invoked by uid 109); 29 Feb 2024 00:44:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Feb 2024 00:44:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28108 invoked by uid 111); 29 Feb 2024 00:44:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 19:44:49 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 19:44:46 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] some v2 capability advertisement cleanups
Message-ID: <20240229004446.GA1654078@coredump.intra.peff.net>
References: <20240228224625.GA1158651@coredump.intra.peff.net>
 <xmqq1q8wjgft.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q8wjgft.fsf@gitster.g>

On Wed, Feb 28, 2024 at 03:51:34PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There are some small textual conflicts with the series I just posted in:
> >
> >   https://lore.kernel.org/git/20240228223700.GA1157826@coredump.intra.peff.net/
> >
> > I'm happy to prepare this on top of that if it's easier.
> 
> Thanks for a heads-up.
> 
> The other one merged first and then this one does give the
> following, which does not look like a huge deal.

Yep, that matches the resolution I did locally.

-Peff
