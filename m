Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD341253F39
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576961; cv=none; b=GkZpPlKeA/PgUuEfQLGD/IA89iGr3eVIbwZQsWEII2F0HcHuY14otbjaMQ3n+rOMpGnqpq0ZeUUXP2LrT5fkzTF36e/Tg6xR52p6NTqs2+uu9V1R87n74Wkq4eHM17ksht7BZgdO5vZACmH+MqjEjxz9ysqNYpycBXZAodQ0dEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576961; c=relaxed/simple;
	bh=S+SUJPEM5ytJhHXXBuRLCG4SEs/Ws6ad0hSvuzNBVWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+/KR/BwATN7tGORJQTW6/4fOEwHlvWW73AW60kNuaRPhrKodYtcP1VapzU+rZ7OM7RdUsLx5gIauAj9kXzPE3EqTpFMpxM5aoGv9+r2TdG9zw+iyZZlRLVyoJGKd18WzawTbFu8PQs4+rmrNNEc66PqmsGMIo1dS9S19g0DKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Iv7V1x9i; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Iv7V1x9i"
Received: (qmail 163188 invoked by uid 109); 22 Sep 2025 21:35:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=S+SUJPEM5ytJhHXXBuRLCG4SEs/Ws6ad0hSvuzNBVWA=; b=Iv7V1x9iJeNiNS/wJm/HnurSPavD8Fp6hZ85NeR2Hju9oFUhmXMr0nrLcrW1SnEJMjezm0hg1TVSPtCqCbAaKiHx9rSNz6oSCiQbV/MU5lUlejgsC4fH/ACb0bIS2TsME7qr4F64Tsb2tz/n6TsuThYBQLTFxlCXhBODIGuZe7uRRp39uHIIbgdiEOgfoi26Mx0osOxSRtAk1chGr1bkPPmVpb5SXasxT+2k2r9n9NLOtfuTMyxF4Aivy/tXetOWflf8PQV+pGc/zCJzYiGcW0OehOHQ8MU562x6zHwRRb+aapCW7nSS0WEuuKX+MNiuuAo3IJjZa5aN7UbJ5Gb9xQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Sep 2025 21:35:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 261024 invoked by uid 111); 22 Sep 2025 21:35:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 17:35:58 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 17:35:58 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>,
	git@vger.kernel.org
Subject: Re: How do i get news of git releases
Message-ID: <20250922213558.GA2269472@coredump.intra.peff.net>
References: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
 <20250922201403.GD2205919@coredump.intra.peff.net>
 <1ff96277-c9e7-483e-ac98-b109b9603475@velocifyer.com>
 <20250922203815.GA2264272@coredump.intra.peff.net>
 <xmqqtt0urxva.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtt0urxva.fsf@gitster.g>

On Mon, Sep 22, 2025 at 02:16:57PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, they're already annotated tags. But they contain only the version
> > number and signature. I suppose they could include the whole set of
> > release notes (and it looks like we used to do that in some very old
> > tags),
> 
> Eh, which one?  I do not recall ever doing so, but I may be
> mistaken.
> 
> "git show v0.99.1" gives both tag object contents *and* the output
> from "git show v0.99.1^0" for the commit, so it is possible that I
> never did so, but those who ask "git show" may get such an
> impression?

I looked at:

  git for-each-ref --format='%(objectsize) %(refname)' refs/tags |
  sort -n

which shows a few bigger ones. v0.99.5 is the biggest, with what looks
like shortlog output plus some hand-written notes. Ditto v1.4.3.2.
But yeah, it is not very many.

> >   3. The resulting objects would be much larger (the v2.51.0 tag is 974
> >      bytes, but Documentation/RelNotes/2.51.0 is 14K, and some are even
> >      larger). Git may open them frequently to peel the tags, which may
> >      make some operations slower. Though it might be OK; we try to cache
> >      peeled values in packed-refs, and possibly the peeling code could
> >      learn to parse more progressively (e.g., grab the first 1K to see
> >      if we hit the end-of-header there).
> >
> > Those aren't necessarily show-stoppers, but just some top-of-the-head
> > thoughts. Junio (the maintainer, who actually makes the tags) might have
> > more thoughts on why we used to do that sometimes and don't now.
> 
> I think #3 is a show-stopper.
> 
> We will keep the RelNotes file updated with every batch that updates
> the 'master' front, so the contents of that imaginary tag that has
> the copy of the release notes would become identical to the in-tree
> blob at the point of a release.  There has to be a very good reason
> why it is beneficial to _duplicate_ the information, not the other
> way around to ask why we do not duplicate the information in
> different places, I think.

Yeah, I agree the duplication is kind of unseemly. The main reason, I
think, would be: some third-party tools may mine information out of the
tag automatically, but do not know how to find Documentation/RelNotes.
I'm assuming GitHub would do that for the releases page (but actually, I
do not know).

If we did care about populating their releases page with more info, I
suspect using their API to pass along the content would be a better
solution.

-Peff
