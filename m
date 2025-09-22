Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C8241667
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573500; cv=none; b=WmTysLEQGQ/dZL2Mz1ejbXlPYh7Yfgq5J2GlYOQb5Os4KNHjWSt16VHxan7AABdzDA8fekylkl88PVz1lvavDzYU9vJGG7cjw/hwC/aKZSlJpgiy1RwPLh48aFPTewaVDwU2tnfu6uqoRGajPAcRe9s6fpMEfFjaUq+evq6y+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573500; c=relaxed/simple;
	bh=90JwkWIrk7dsPs0E0O6EEQifWESdXbFPa4pYG21IjqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dg1GEmMVNtqUHCwOJw5SiiDGKUYGo30ItX+qwtukcS/7+Ax/voRmJbPcdrNvvflGGNJJMQ+1X3NgvwO/UoBg5XC1zegmRAjXK9MjORJZMdM/h7A33nAoJWgNPiWMWJp0YCY19uAehFARyfljnPgpjj4eB3tiwWYNuC8eItdPqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hTp07Y4G; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hTp07Y4G"
Received: (qmail 162611 invoked by uid 109); 22 Sep 2025 20:38:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=90JwkWIrk7dsPs0E0O6EEQifWESdXbFPa4pYG21IjqE=; b=hTp07Y4Gcm4KF5K1iK1+IJeQravSRFULHz9UJGOrFAsPH9kikXRInVnTKH/JLVIepVts4PsTkTyQBWASH8UFoDl3AoAlkhkhVoAOpupwVqBXi4CETbR5RvH48s2LRJE9zPfS/pfq3iD6uCiB9y3s2IHPofgRb9C7xMX1qe+FsSeH0umMWBjM3V/HFma6UUMZZ4tj3RbOgIAg5grGF2mPs9RnHLHgJQut2fKlfLQhHosdGKnAfr+ycn3NihAkVY6JhbFCaOdtRESlPd2IZYOW3G/cF+0b/GSe6BkgkOKq4CGb/vEZyP6bll4Vn4LIZb8dY0iJBfm5DIuojjj3tWZtzw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Sep 2025 20:38:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 260269 invoked by uid 111); 22 Sep 2025 20:38:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 16:38:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 16:38:15 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>
Cc: git@vger.kernel.org
Subject: Re: How do i get news of git releases
Message-ID: <20250922203815.GA2264272@coredump.intra.peff.net>
References: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
 <20250922201403.GD2205919@coredump.intra.peff.net>
 <1ff96277-c9e7-483e-ac98-b109b9603475@velocifyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ff96277-c9e7-483e-ac98-b109b9603475@velocifyer.com>

[please keep responses on-list]

On Mon, Sep 22, 2025 at 04:27:44PM -0400, 𝕍𝕖𝕝𝕠𝕔𝕚𝕗𝕪𝕖𝕣 wrote:

> > The Git project doesn't maintain any RSS feeds that I'm aware of.
> > However, releases are pushed to GitHub (among many other mirrors), and
> > they do provide feeds. So I think pointing your feed-reader at:
> > 
> >    https://github.com/git/git/releases.atom
> > 
> > would work.
> > 
> > The project doesn't use GitHub's Releases feature specifically, but I
> > think annotated tags that are pushed to the repo end up there, too. The
> > resulting feed entries are a little bare. Possibly they could be
> > populated with the release notes, but from the Git project's
> > perspective, the GitHub repo is really just a Git mirror. Presumably it
> > would require some scripting around GitHub's API for the tag pushes to
> > also create Release entries (and then probably somebody would want the
> > same for the GitLab mirror, and so on).
> 
> Why do the Git tags not have the changelog? You can use git-tag -a to create
> a tag with a changelog.

Yes, they're already annotated tags. But they contain only the version
number and signature. I suppose they could include the whole set of
release notes (and it looks like we used to do that in some very old
tags), but there may be some possible downsides:

  1. I'm not sure if anybody depends on the current format for
     scripting.

  2. They can't be revised if we later fix up the Release Notes (e.g.,
     typo fixes, but also they were recently all retroactively brushed
     up to be renderable as asciidoc).

  3. The resulting objects would be much larger (the v2.51.0 tag is 974
     bytes, but Documentation/RelNotes/2.51.0 is 14K, and some are even
     larger). Git may open them frequently to peel the tags, which may
     make some operations slower. Though it might be OK; we try to cache
     peeled values in packed-refs, and possibly the peeling code could
     learn to parse more progressively (e.g., grab the first 1K to see
     if we hit the end-of-header there).

Those aren't necessarily show-stoppers, but just some top-of-the-head
thoughts. Junio (the maintainer, who actually makes the tags) might have
more thoughts on why we used to do that sometimes and don't now.

-Peff
