Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA40281525
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056673; cv=none; b=IlkVo7spAQ/o+uzi/EfEBIw9ztKostYAvs19T2A8E85IUd1heJwrEq0+vfxko3yQICrqmZT7DlIc6sa5LkYT2JKKjysDwO9cWSk8DkJwpkyIVk6uymJpjDmVRz7uUdrJZ230x8kDoDlHn8xxY4MGd8oy1xegv21PPXSILA1knoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056673; c=relaxed/simple;
	bh=fhiIcbma4FvqPLGeG1QleOdyVL2/SdYHgo8LAxz7QJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjmRNC1nBK7rKly6Io9n3HzslP0GzI5e4ieXmQqWxIWBM7r2ZinU+pKfnLQZINwh2bvMbkx1fVkFZjj7vcxaky7KVbHLlOuin+EeehINq9D3eLSNP4VnP61srsFrMkilxNRY8adiIgJoTpZd+8gOiCOrMiDppyIow+KWqWvWUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aUVLzBUF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aUVLzBUF"
Received: (qmail 257613 invoked by uid 109); 2 Feb 2026 18:24:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fhiIcbma4FvqPLGeG1QleOdyVL2/SdYHgo8LAxz7QJg=; b=aUVLzBUFBbMoLqJbzdZJRlQgl5eLSC99xNIxauJIAaq+0mIqYgy/3BDy5YdXwUMiwAShQCIizOoVGyhf3OIMVowihRplX/LMFBm/n5ovf3bGncI/kV0bFj80Lg5BlRYoB4urkFKnbQAvlwO1NQIPYKCH2uGDgYFSnFjAekxBXsYy/0YJMeUvv2GTkIqNImDpBS0LO0LeznmMBX0qBGq06jsmJG879U3u/s45Dzwq8SYqPjNuaeYlSVEItbAve+HpeNwnlRVe1oaV9/PoUkWC9WUMiGc6mKPL1CJh+LzrFCC+CqbJpFh+iNPkLoso29RY6NZyFMy8JyWmmMQhmFKHVg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Feb 2026 18:24:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 506198 invoked by uid 111); 2 Feb 2026 18:24:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Feb 2026 13:24:23 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Feb 2026 13:24:21 -0500
From: Jeff King <peff@peff.net>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] doc: shortlog: put back trailer paragraphs
Message-ID: <20260202182421.GA3421838@coredump.intra.peff.net>
References: <shortlog_trailers.253@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <shortlog_trailers.253@msgid.xyz>

On Mon, Feb 02, 2026 at 06:59:42PM +0100, kristofferhaugsbakk@fastmail.com wrote:

> 47beb37b (shortlog: match commit trailers with --group, 2020-09-27)
> added the `trailer` bullet point with three paragraphs.[1] Later,
> 3dc95e09 (shortlog: support arbitrary commit format `--group`s,
> 2022-10-24) put the single-paragraph bullet point about `format` right
> after the first paragraph about `trailer`. That meant that the second
> and third paragraphs for `trailer` got moved to `format`.
> 
> Move the two paragraphs back to `trailer`. We now also need one blank
> line before the final bullet point so that it does not get joined with
> the second bullet point.

Yeah, the change in 3dc95e09 was obviously wrong. The results look good
here, via both doc-diff output and just eyeballing the generated .html
file. Thanks for catching this.

-Peff
