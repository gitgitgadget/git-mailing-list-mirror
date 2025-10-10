Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8FE2749CA
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134992; cv=none; b=CSZzkw299oIkx74WbC2pZjVPHTnO2b4UdmgHuSmqPmE1St0wemhnnNJm/U7YUEIqn0A/RCdHeZgLrRKqw47Rhe8CrdjaZTugplJVjGa+3Vhfp9tvVgteTsr+QjPEcWJ4Dl7sTrF5T60ZUHUz8ElalG86inl7HovuU45MpUASc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134992; c=relaxed/simple;
	bh=ShZhPjV7e3kPJra2E6yYBii8FqTFBPdw4pTd8bpDL1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+vA0bqAtnA+HjKWp3twuOQtZEFX+6MEy9hlhGqBDUqY+BTMF1B6aoWiPyy6la5YhGuyKwXUfbDBYCPBUWd8gg1opzWHe9fxaln8qNMk8n0QME0ld6t5ENPfGoihkSyAjsZQbrM/pXuhjVjAMKGsoQNc9zfipwv8PYKo/UZPamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CFykM0I5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CFykM0I5"
Received: (qmail 187015 invoked by uid 109); 10 Oct 2025 22:23:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ShZhPjV7e3kPJra2E6yYBii8FqTFBPdw4pTd8bpDL1c=; b=CFykM0I5jyPF5k5HkyeN7eKn1Vlj8HfNjajWuLQFRZRWMP/ghrMq4Xn1ScpHhknCjn19tQtElsMnGYcv1/+iU7cDlfXuwML6G7GdTfhNSKeksJA004eYAhs4zi+kNkOMK9PYNufX8IMYbbhs2Dvk3Kt3BZceDdmvpeAc8CG5M/3Y0X1n1QBXUluXG7H42rmlbYLMF/cES7pLe7+Q3dNXuC9feoVcbBOUqMLro65f0enWM9mYBFj7HRDSwm4FYDnnslff+qK73YGUqlADH2t52db/3frz8F6KA6bmQmVZaqKjrE49vXaDV/epuIS5vy4s73sfeggdFOOVhe9Nsp3EDA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 22:23:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 294605 invoked by uid 111); 10 Oct 2025 22:23:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 18:23:04 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 18:23:04 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] doc: change the markup of paragraphs following a
 nested list item
Message-ID: <20251010222304.GA2007405@coredump.intra.peff.net>
References: <xmqq5xd5aqa5.fsf@gitster.g>
 <20251003031113.GA6381@coredump.intra.peff.net>
 <20251003034134.GA625140@coredump.intra.peff.net>
 <2239952.irdbgypaU6@cayenne>
 <xmqqo6qeag9n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6qeag9n.fsf@gitster.g>

On Fri, Oct 10, 2025 at 09:11:16AM -0700, Junio C Hamano wrote:

> >> diff --git a/Documentation/config/extensions.adoc
> >> b/Documentation/config/extensions.adoc index 49a7598ca5..aaea8c107f 100644
> >> --- a/Documentation/config/extensions.adoc
> >> +++ b/Documentation/config/extensions.adoc
> >> @@ -55,8 +55,9 @@ For historical reasons, this extension is respected 
> > regardless of
> >> the refStorage:::
> >>  	Specify the ref storage format to use. The acceptable values are:
> >>  +
> >> +--
> >>  include::../ref-storage-format.adoc[]
> >> -
> >> +--
> >>  +
> >>  Note that this setting should only be set by linkgit:git-init[1] or
> >>  linkgit:git-clone[1]. Trying to change it after initialization will not
> >> 
> >> on top of your patch seems to do the right thing (no change in asciidoc,
> >> and eliminating the regression from your patch). It's a little gross
> >> because we are reaching across the include to realize that
> >> ref-storage-format.adoc contains a list that needs to go into its own
> >> block. I wonder if asciidoc implicitly opens a new block for an include
> >> but asciidoctor doesn't. But at any rate, this is the only way I could
> >> come up with for both to render correctly.
> >
> > Thank you for cross-checking. This is indeed almost impossible to mechanize 
> > such testing at the moment.
> 
> Thanks, both.  
> 
> So we'd see an update to this (I think this is already in 'next')?

I think we already did, in:

  https://lore.kernel.org/git/20251007082223.GA3336685@coredump.intra.peff.net/

and you queued that on the topic (and merged it to next already). Or am
I misunderstanding the question?

-Peff
