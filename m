Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04828C06
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720481717; cv=none; b=kZ2CY3YodCHAZjGIhGOd32Low7oDYJRaNJhCbc3vjuiWyUfOfKqxE8sYNCv2h4lSaID2P88Dx8wgGqfPBOyBTBa3+UFZDfZUbVCc0jIRWOiRGXZ4vBteP92c5rHgggZjOEOEML+DnjdfyF6nxuujaPOmZCYv8WyipiuFC3+ZSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720481717; c=relaxed/simple;
	bh=DAmll50QjOeUoIyESfgCB14N3jgmd/uMfa7RhwHm5kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNDVYryGc7nae5d1RTj8qUrg4Mxe/fyg351UjhOI7TdFt9AWqIiwwXZmQecGTFeHkNi/QudxsMSqEWIolnC6z0Pa1A0vJGkHJc6tCy4Bra4wzNWnpEPODMfUA8lc2EszM0e185uO7aCf2qFpxdRr+19aLJRsYUtFxYALzrzOOLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19977 invoked by uid 109); 8 Jul 2024 23:35:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jul 2024 23:35:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28127 invoked by uid 111); 8 Jul 2024 23:35:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jul 2024 19:35:10 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jul 2024 19:35:11 -0400
From: Jeff King <peff@peff.net>
To: Tomas Nordin <tomasn@posteo.net>
Cc: git@vger.kernel.org
Subject: Re: Unbalanced closing paren in help of git commit
Message-ID: <20240708233511.GB948906@coredump.intra.peff.net>
References: <87o7792xgu.fsf@posteo.net>
 <20240708085440.GA819809@coredump.intra.peff.net>
 <87le2b3cew.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87le2b3cew.fsf@posteo.net>

On Mon, Jul 08, 2024 at 07:35:03PM +0000, Tomas Nordin wrote:

> > Want to try your hand at producing a patch? (It's OK if the answer is
> > no; it just seems like a good opportunity for somebody to get their feet
> > wet on contributing).
> 
> I can try, why not? Should I hang it up on this thread so to say. Is
> this a bug report?

You can do it as a reply to this thread, or you can start a new thread.
If there is a lot of discussion in the bug report thread, it is
sometimes helpful to reference it in your commit message or cover
letter. E.g. as:

  https://lore.kernel.org/git/87o7792xgu.fsf@posteo.net/

but in this case the issue is simple enough that you can just describe
the problem fully in the commit message.

-Peff
