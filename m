Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06601E500C
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365550; cv=none; b=gC4+hWGuTwOpHKFl3rvvOSB4dLY3RTG90tX+6D6J0CJ4t3aynmIl2QhPfMvsORu85jSSBOoeQNsfuTvx9GtVN7HFP5aMXxlip6OF5bj3n5EQ+z/q1d6NK0iZxO0v25KTgK1Tfd4IC5XAs4HXZ6VpZa7KTyv5r7MZL4ZoC9Juo1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365550; c=relaxed/simple;
	bh=HGn6/MCrTqjit/qeDRvWya3bOvcxf1Qe31iZxRvEi/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGtojocugub4Za4sZFwYJCOWTYofQv+lT9jsaU5cJ0Tu7EiAoIWUT0U+1In+WhdqhZT3rVf3/TBkJfEknJcHRYLBap6weKrJurNKJmbHyDANwmzE8/hMD10B25SXhJIR5IdiADzSaIBIwhG5H/JUJkJruUfQGb28phEhcmsosgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Bx28fASY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Bx28fASY"
Received: (qmail 23510 invoked by uid 109); 8 Sep 2025 21:05:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HGn6/MCrTqjit/qeDRvWya3bOvcxf1Qe31iZxRvEi/4=; b=Bx28fASYClR4iqfyad10TLpx6QOVeQ8yWbIZDWWOzzj6fWNwC4D22rsBe2FYsi4oj034qvsF+3MglCUWAuu8qMCM42MFdHzAWQG/k5Fg0u1FePzTao4oQsM0lEos9SKDrji6qcIWQOjKBnq5LhxVbY1SozIGjSTXbBICZtxcQE2CUMm8LqTnWVGgLuDsTyZU3Bg7RLHdJygsRxYCQ/uhXEAj+YtK7H7i3eat3knD+82Cf2JbdpCAnP0C9i2nd50+CQcXTq4BFL6pBkSv/4qcDVWJtX4MsuWJvEDZHnnIZ3HXjvAfajpN2ai//n2sIqjn5qaA2/rPdguvU97ahAJZ9Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Sep 2025 21:05:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 39021 invoked by uid 111); 8 Sep 2025 21:05:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Sep 2025 17:05:46 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Sep 2025 17:05:46 -0400
From: Jeff King <peff@peff.net>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] doc: fast-import: replace literal block with paragraph
Message-ID: <20250908210546.GA1327610@coredump.intra.peff.net>
References: <09aaad696895c18c6d4dda7d6a2f4b77f84f39ba.1757363213.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09aaad696895c18c6d4dda7d6a2f4b77f84f39ba.1757363213.git.code@khaugsbakk.name>

On Mon, Sep 08, 2025 at 10:28:45PM +0200, kristofferhaugsbakk@fastmail.com wrote:

>     > but it looks like it should just be a regular paragraph.
>     
>     ... unless this is some kind of callout-block style?

Nope, I think it was just a mistake on my part. IIRC it is a common
asciidoc pitfall not to remove indentation when doing a continuation
block. Your patch looks like the right fix. Thanks for finding it.

-Peff
