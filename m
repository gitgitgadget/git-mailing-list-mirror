Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC662185F2B
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359964; cv=none; b=bKsxOYi5yP5iILAoi4549remRPAtnLCwOyBGEWSOPFfNKYdn3IgzbIAvbXFXDkQgHs5oC8trpo3nrYa2SuUDnhbeOFbDsNc2/5XAxzzxIUgjzyihciTjPMB/Xv5mLJJBtbvLyhpcTPeHfL5qg0ps1bVZibcGPmo8rkaf49JOMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359964; c=relaxed/simple;
	bh=CstNwKevu6ObmmXaGPf62o6+wT9c/RZaDrcHjjWI+GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIJZP61MtTOTLWz08HYXTdzm3zwpCybw4S3ou+M1kA1xcl6JJa64yUP1dT1ZJYHbk1FIQCN07X8sxi7J5QnpZi7B62kQmScxZ89DPaWkEAdUyHZMzy19E7wEsztP+nQH1vItffeEtgeLPoDVgFRzEfvroWEeUlFzfnNYiii0SbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13811 invoked by uid 109); 25 Mar 2024 09:46:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Mar 2024 09:46:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2267 invoked by uid 111); 25 Mar 2024 09:46:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Mar 2024 05:46:06 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Mar 2024 05:46:01 -0400
From: Jeff King <peff@peff.net>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pretty: find pretty formats case-insensitively
Message-ID: <20240325094601.GB254602@coredump.intra.peff.net>
References: <20240324214316.917513-1-brianmlyles@gmail.com>
 <20240325072651.947505-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240325072651.947505-2-brianmlyles@gmail.com>

On Mon, Mar 25, 2024 at 02:25:13AM -0500, Brian Lyles wrote:

> Use case-insensitive comparisons when identifying format aliases.
> 
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>

Unsurprisingly, this one looks good to me. I don't know if I deserve a
co-author, but I am happy either way. :)

-Peff
