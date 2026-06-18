Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2AA31ED7D
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798866; cv=none; b=Ym3Ma228iKXIy62d4o0DKpxbFzzNQv9X67mO8O3bVYcoaNWGQppNOHpg4F23wPYI9ZgGXYbH5qkIm5P+oSWdVzM4+zw0XRb4/zNDCuko5+6EPtXb/n+4f39ywEHgHwP/x4t0ZnAdi5xFUywKsw7vvo52N8SQj7zmNiTF5hrhzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798866; c=relaxed/simple;
	bh=2ev9uIkI6ALHYPp6oq2iYaXQhUpaKsoJaFkJwoj3fkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1vRY3vrzKNmSFSCrZi5oMiR3xuY2J+9uciAXO7B8KtsKFPCulyvrpp/alS+qL6C6awC9gm0vbc7ebnCxXIB2wfxrMvNhlFhALhnUW67fya3MGvSMipJ1rLBE2xBYb9PaAD1TLKs6ODAAFUQrMF70iDyiosCtzrk4/fi9DN7oTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ap7y0Yrd; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ap7y0Yrd"
Received: (qmail 167847 invoked by uid 106); 18 Jun 2026 16:07:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2ev9uIkI6ALHYPp6oq2iYaXQhUpaKsoJaFkJwoj3fkk=; b=ap7y0YrdUGsmqFwjbvaSxEPKLwA2NtY/FudAJm7FoOzkbw8qX6aEiDj+X7n8Ak96sVAh/iNyIJ/jhrLjgBIopl/5Qx0iXSqX5HSinMMAW1iQMndIQRH+V5WOi1VGM0bBGd09KwPDbXN8XfG2z1Fyek8mEkYYIyjqnzSjgAkvN5xdq7eAlsxmd3ejjlZfZXwe/Oma5KEfgZ2uYyZM2shO2TfFFEMC/tgBLrpIIoTKttjBTLqQPWfYrECxTC3jRzJFEH+FOplFhtrcQ9snM7XgPWDMPIeZy/HRY6Hne7LRF/Y93LhP47KNCZ9Pd5JsQ9GDBMFTUH6sXIdMKoFOfuBZTg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Jun 2026 16:07:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 474120 invoked by uid 111); 18 Jun 2026 16:07:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Jun 2026 12:07:44 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Jun 2026 12:07:43 -0400
From: Jeff King <peff@peff.net>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Kristofer Karlsson <krka@spotify.com>, git@vger.kernel.org,
	ayu.chandekar@gmail.com, chandrapratap3519@gmail.com,
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com,
	karthik.188@gmail.com, phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
Message-ID: <20260618160743.GA821987@coredump.intra.peff.net>
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
 <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
 <20260617202744.GA3465855@coredump.intra.peff.net>
 <CAN5EUNSQY2oK7BE4J9Y8APfkP6eJxta050OUu=RoJYhXOjX_OA@mail.gmail.com>
 <20260618160504.GA818042@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618160504.GA818042@coredump.intra.peff.net>

On Thu, Jun 18, 2026 at 12:05:05PM -0400, Jeff King wrote:

> > From what I understood, we can only get the direct next commit, but no
> > more reliably ordered.
> 
> Right. There are other queue implementations that could allow full
> in-order traversal (e.g., a binary tree), but our prio_queue does not. I
> suspect performance for other cases would suffer if we switched the
> underlying data structure.

BTW, there's one extra trick here in the iteration: you might see
commits in _both_ revs->commits and revs->commit_queue. So you'll have
to iterate over both of them (and I guess push the loop body into a
function to avoid duplication).

We may eventually settle on having just one queue sturcture, but I think
dd4bc01c0a used that to avoid disrupting existing callers.

-Peff
