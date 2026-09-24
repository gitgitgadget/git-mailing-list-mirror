Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038B4A2A47
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265321; cv=none; b=Yl4lsmnhl+jat5GKhebvViqoe8vJ7B1z+XCSK3yUbWgDHlmOj2IojVolkZrpiKIeYN4MSQ+kgvsRMyobIuFOcB9ZrqRRM+PUVMKlTFc5kQQY8L7Ba/Krr/VuzQNNPtM+2q5C1GBX4bdmXVlCJ7RQW6z3JUzdDetpo6988U/uZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265321; c=relaxed/simple;
	bh=3k2DKCl/pyVndwvzgNeF+fPibG+FUyHrDKI/Gh5xZiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9ugZw4luhu3kBFjjfzerz8eiT4WSoUbF7LtxRHDuZIlqQMeBcRwqmyS3GudFFwMUe4l4hepVSQEzpoG4bPEzKgIAdzqM7OjvK0jJEv6V4ldIjHCoy3n4O8zHIh4GJ9WdAVQRz0MIoq3weeHZGWNXBdj6YAgLpYG6vVMISRcIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YcUCfWYa; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YcUCfWYa"
Received: (qmail 48272 invoked by uid 106); 24 Sep 2026 15:55:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3k2DKCl/pyVndwvzgNeF+fPibG+FUyHrDKI/Gh5xZiA=; b=YcUCfWYaRlsdsNZjZi27+xORi63J3kTsgazgggy/RN2P8DG7rFdlw48+H3J0TaT04Q2pqFnsgcjL05EOch8lGEH9dm23UhJpwgbg+zwZ3qlugas1pRS6FH2+TjcF0FdA/AhFiWvNUPkUm23Mmg8gh6Vly74Z4nHDqum45+2vnVle1LhlmczHVdhKJFCTf+slMS7DO+ulOA/Bn1lu+PnwVQBBNX0X0QU6s5EuUfIi5FCV/eUwZ7ZugXFpuiZDcc4HDefapUofIQcqZRLE6NEGs/YZRZaK8KoILl5P15qP1d0qI6kHzwZCvuCBSC7xewo736bgMLihXxFx9SuF29WTNA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2026 15:55:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 193279 invoked by uid 111); 24 Sep 2026 15:55:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2026 11:55:17 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 24 Sep 2026 11:55:17 -0400
From: Jeff King <peff@peff.net>
To: Julia Evans <julia@jvns.ca>
Cc: Junio C Hamano <gitster@pobox.com>,
	Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: add more AsciiDoc cross-references
Message-ID: <20260924155517.GB736248@coredump.intra.peff.net>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
 <xmqq4ifhdon2.fsf@gitster.g>
 <665e8f8d-7bde-449b-a390-10875135cba2@app.fastmail.com>
 <20260923214038.GA49087@coredump.intra.peff.net>
 <63520573-c8a7-41bd-aaeb-bfc2b5e43856@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63520573-c8a7-41bd-aaeb-bfc2b5e43856@app.fastmail.com>

On Thu, Sep 24, 2026 at 08:30:31AM -0400, Julia Evans wrote:

> Thanks for investigating, I was really dreading looking into the guts of
> asciidoc to figure out exactly what was happening. It would be nice to be able
> to write just <<PRUNING>>, especially because I believe asciidoctor will check
> that internal links are valid, so there's no concern about breaking links if we
> change the title of a section.

I think asciidoc(tor) doesn't do it itself, so HTML will be generated
with a broken link. But in the manpage flow, we pass through xml
docbook, which does complain loudly. So that will be enough to let us
know about the breakage.

> 1. Leave it is as is and break some links
> 2. manually enter the ID like `_editing_patches`, trying to make sure to always
> match the auto-generated ID (I'm not sure how to do that). I think this might
> also cause some confusion for editors in the future as to why the section IDs
> are formatted like that
> 3. Somehow fix it so that we can just do <<PRUNING>>
> 
> I'm not sure if #1 or #2 is better, obviously I'm biased towards #1 because
> it's less work for me. #3 seems like the ideal but I don't know how to do that.

Yeah, sorry I was a bit rambly in my other message, but I think #1 is
OK. I'm not sure if asciidoctor allows us to configure the algorithm for
converting a title into a section id. If it does, it might be nice to
have a flag day where we make all of the auto-ids look like what we'd
expect. But that is a totally separate topic, and can happen later.

I think #3 is sort-of orthogonal, as I couldn't get the "natural" xrefs
to work. So we have to either declare the ids ourselves or use the
auto-generated ones, at which point the use of single- or double-
<<FOO>> xrefs is purely a matter for the linking site, not the linked-to
section.

> Here's a revised commit message, can submit that as a v2 if it seems correct.
> 
>     doc: add more AsciiDoc cross-references
> 
>     Instead of saying "see EXAMPLES below", say "see <<EXAMPLES,EXAMPLES>>
>     below" to make the man pages easier to navigate on the web.
> 
>     The reason for using the more verbose <<EXAMPLES,EXAMPLES>>
>     (instead of <<EXAMPLES>>) is in some cases, the HTML output is rendered
>     as `"EXAMPLES"` or `[EXAMPLES]` instead of just `EXAMPLES`.
>     So this gives us more control over how the output looks.
> 
>     This also changes some of the HTML IDs of the headings from `_examples`
>     to `EXAMPLES`, which has the potential to break some links.

Yeah, I think this is OK. If we want to be really pedantic, the
"EXAMPLES" with quotes is only in the manpages, not the HTML (and also
includes extra text: "the section called"). But the point is the same.
We must use the doubled form to get consistent text output.

-Peff
