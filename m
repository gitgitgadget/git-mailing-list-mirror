Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E917BA5
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379822; cv=none; b=eySk6O52W3+X+Rmr/xSmxtp5YP2uwPrFjjpRJsWILjN6jIbL8RqvzshUr9UoJTwXPETypwyT86zwaAN9xvBzdXGUtK/cgkpDGMYKVbEAsxHeKQE9hdiR9rNJNqPPD1HIDkoSx6Qr2uNgBq3Pab8Q+Y4c5a6lAE6VI30N6cvwWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379822; c=relaxed/simple;
	bh=Yqszk6NrHY5SG5b3FXjcYZKlTx9AB3VVNbSz7G05MKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+Harikk1Edw43Id/J+Aw+aSr4raIQQgHIXIrRuh7VnlqOCg2o4nZ9Vo5TehqXpqC2jMkE2GoD3z1UuTkpyQui39+k/T+LV1PJAr85kJoUIQcvW6wpU1gw492fM+5h/scZjJH9TUR0GUwsUfIHW4jNYRlt1KACM0fiNq80JzbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20289 invoked by uid 109); 29 Apr 2024 08:37:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 08:37:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27000 invoked by uid 111); 29 Apr 2024 08:37:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 04:37:04 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 04:36:59 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/8] tightening ref handling outside of refs/
Message-ID: <20240429083659.GA233736@coredump.intra.peff.net>
References: <20240429081512.GA4130242@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429081512.GA4130242@coredump.intra.peff.net>

On Mon, Apr 29, 2024 at 04:15:13AM -0400, Jeff King wrote:

>   [1/8]: t0600: don't create ref outside of refs/
>   [2/8]: t5619: use fully qualified refname for branch
>   [3/8]: refs: move is_pseudoref_syntax() definition earlier
>   [4/8]: refs: disallow dash in pseudoref syntax
>   [5/8]: refs: use is_pseudoref_syntax() in refname_is_safe()
>   [6/8]: check_refname_format(): add FULLY_QUALIFIED flag
>   [7/8]: refs: check refnames as fully qualified when writing
>   [8/8]: refs: check refnames as fully qualified when resolving

Ugh, sorry, I managed to break the threading due to some too-clever use
of mutt. ;)

The other messages are on the list, and hopefully shouldn't be too hard
to find by date.

-Peff
