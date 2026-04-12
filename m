Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923B21D3D6
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776023827; cv=none; b=pEkuM7FHAHk5XrXAUinnTUQ+rTQPBMTKME6vTylSFc/GpkwpjhA8sissd/2WfLP/TWX6kgvo4kehb/hOv0+5ImyGf7UNmgBlyTJFVi/vBb5bt2E388jCz4oB/tD3g2IPMmKZFlEKbUPMo+Yro5Q1Wg4dlkfMEACVqRg5qVP6bhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776023827; c=relaxed/simple;
	bh=ZmsbUKCcmSfI+F/FvAHHNHAZyn8DaqE1//tCFHPsG5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h10Zto7L9v+trf+0DhQCDxPqOEoZNBSEax36ZPYT1a4LCGG/46CiI9MTLmYywaFL+qO8B4fhO3PtSZNyZftXznFAKtwhHg9YuHPEXovNb5Q08kGPmE+Ff1lLEu6QJS94aSTTGXzZJeUadulaXaSQAp9smkkz8MKdVyGD+N6IUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hhhH78MF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hhhH78MF"
Received: (qmail 328847 invoked by uid 106); 12 Apr 2026 19:56:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=ZmsbUKCcmSfI+F/FvAHHNHAZyn8DaqE1//tCFHPsG5k=; b=hhhH78MF1pH2grVa1rSg+EzAwLKkUIzXDk/p5na7TGlwZqnXipAoNH343xnrnvyC8z2zlAuL/XocuA7XycNUYsxATB4RHwg33pKodESVvNOjE2qQUAuvcY4fyaES0+W05W7okqMgnNC9BhPWFiLMlV6je7J2Mzt7s1UXIRp0OUP0Sli2ebRTPYE4Aj67yAlR9ypRXNsog56UymWOlrfbHU/I5iHqZFEhDYdGoeCxwXO2KgNTnz1O5AZvHrH9pshtpj7uh20UjcMVmfEV8usQO+ngDeOGG4Gv527zGuKWVLcQQKm1xGM75+4uXv7I4u7P/9OIp3dxPh/eux1vo1ZJUQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 12 Apr 2026 19:56:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 544082 invoked by uid 111); 12 Apr 2026 19:56:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 12 Apr 2026 15:56:56 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 12 Apr 2026 15:56:56 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] gitglossary: fix indentation of sub-lists
Message-ID: <20260412195656.GA1691477@coredump.intra.peff.net>
References: <20260411190625.GA754966@coredump.intra.peff.net>
 <fb4dff1b-d304-4f29-a96c-373b1a73989b@app.fastmail.com>
 <236b32a3-a04b-4d20-8290-02a464037b1d@app.fastmail.com>
 <20260411214213.GA1563438@coredump.intra.peff.net>
 <20260411215518.GA1651019@coredump.intra.peff.net>
 <ee8d43cc-c38b-4a55-8237-94f92034d62f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee8d43cc-c38b-4a55-8237-94f92034d62f@app.fastmail.com>

On Sun, Apr 12, 2026 at 11:10:34AM +0200, Kristoffer Haugsbakk wrote:

> > But asciidoc being asciidoc, of course that is not the end of the story.
> 
> Ouch.
> 
> > That technique works fine for the "glob" and "attr" lists in this patch,
> > but under the "refs" item it works for only 1 of the 2 lists! I can't
> > figure out why, and this may be an asciidoctor bug. But we can work
> 
> You mention “asciidoc being asciidoc” but here it seems to be
> about Asciidoctor?

It is. I meant "asciidoc the language", not "asciidoc the tool". I
didn't want to be too harsh on asciidoctor specifically. I think in
aggregate the pain comes equally from both tools. ;)

> > So using the extra blank line for the first two instances, and "--"
> > markers for the second two, this patch produces identical output from
> > "doc-diff HEAD^ HEAD" for both --asciidoctor and --ascii modes.
> 
> Nit: s/--ascii/--asciidoc/

Oops, yes.

-Peff
