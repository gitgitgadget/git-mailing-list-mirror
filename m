Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26774489FDA
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058305; cv=none; b=LRRTuwFkrKBYFGTigJa6PG2Xbe1sX37RGqdGjwluZ1Oz5pubTbGAGBvivivUJoqQh1O88Zz/zrFuY+dYP7EFeL6RCOZNqYpr9fVNV6iR4YHH52W9sjUMydl7iT4CbcNt54p275gOBI7KFPTkiQZzvEYsX158xDHmvUK4zlSw7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058305; c=relaxed/simple;
	bh=a5iSEudXT4cIbpYzkvjcIxwyYhjAOeGwWbKLGqTzG40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOQMqNeesijn2DCYbdmFaxt/L10ysKyaVt78/z9dkc29ngPQ8rMlaHN3bhgvJJ4yEVo3HnUjpe/BU3hZ1/Gu0pP/iW76cN7J7+DnqCBbKNL32JNBDeD1Jhn9lN2FakgYhRNSbcr20vXRVdCB7SIxVBdplcz9v/3Ekc//CsU9qzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iWBN8PkQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iWBN8PkQ"
Received: (qmail 31337 invoked by uid 106); 10 Sep 2026 16:38:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=a5iSEudXT4cIbpYzkvjcIxwyYhjAOeGwWbKLGqTzG40=; b=iWBN8PkQCiQ4q8IDqhNuIJbbNHwMuvHktRVXzDYj9XSaf/URAZxCjl7lSdz87G5KJsR5M68qE6RAU9T7pHlpqrZWZh+Ye4hhCY9lCd/7GZ7+0U7e3IrCYD+gcss2COlL/zyR8E1AIEqEQjFuMsyjC7qMX7qCyR+ekKHuRFRPh+lbH8GF66BfQepFL8thAy6Perj7zrbN9iMmv9/bh/gzP8xwe4izCkD/RKgDpwc3SzH7y/+nAwvlgwEZIv9jUb03UvP8Kb/Vgt8pTvsN1rD28fb1PYIYWPAUX/LD3yn40QZoHIPA7w28HpEafnBhXdMj2nHDY3Lq4tNINFvnjefrWA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2026 16:38:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157576 invoked by uid 111); 10 Sep 2026 16:38:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2026 12:38:20 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Sep 2026 12:38:20 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Brigham Campbell <me@brighamcampbell.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] doc: Make asciidoc bullet items separate
Message-ID: <20260910163820.GE251185@coredump.intra.peff.net>
References: <20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com>
 <9f455224-f156-493f-a21c-27a8922f3360@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f455224-f156-493f-a21c-27a8922f3360@app.fastmail.com>

On Mon, Sep 07, 2026 at 12:18:48PM +0200, Kristoffer Haugsbakk wrote:

> I wonder if this gives different results for asciidoc and asciidoctor.
> 
> • asciidoctor: seems that the bullet list is correct with or without
>   this change (no change)
> • asciidoc: needs this change

Yeah, I think we've run into this sort of parsing subtlety between the
two before.

I imagine this is how you did it, but for the original author and
anybody else working on documentation, it is often useful to do:

  cd Documentation
  ./doc-diff HEAD^ HEAD
  ./doc-diff --asciidoctor HEAD^ HEAD

to see how your changes work in both systems. You can also do:

  ./doc-diff --from-asciidoctor --to-asciidoc HEAD HEAD

to see how the two renderers differ currently, but there's quite a lot
of noise (differing wrapping, indentation, use of quotes, etc). All of
those may be candidates for examination and fixing, but it is a lot of
noise if you are looking at your one area. ;)

> I also idly wonder why git-scm renders this bullet list as it ought
> to. This hunk has not been modified for a while. The second paragraph
> which ostensibly made it conjoined was d9bccf2e (builtin/maintenance:
> introduce "geometric" strategy, 2025-10-24).

It uses asciidoctor. :)

-Peff
