Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951F2E3395
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741844257; cv=none; b=k26lZP+WS46uKknMr0+0wssio9oFnKk2ZHmaSqyQeVdpEmQKjqFF2LVvEVo6mlyPi3xLil6JzwwfGtmAqPHrcGKvX/Jribre0ttXKacrRWRm8XvGT1+HWibUD8+V9GpE+Kh3OgsdJ8ejAEK0J2HowesRmzH930OUdfiZCArpI5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741844257; c=relaxed/simple;
	bh=33lClb7LQtnI2AysI99jjO0TqBosVfgFf79pn5q+9Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSbt0/lCQ1qusw7zLpKcSho9zTDqM36o0IkrEfIu/rUhfuf6xaDzwV8pxC6nilUB4XvlllLSYjsOwKVg8qiLwkOjk8VH33jcFG/TerBeDom6KQPQhKj/zAK1xgF2MexSI5sX9sJfJ1qy4c5DjfETgM4gBkEFRq3KiNDuZBBMQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bLRpayf8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bLRpayf8"
Received: (qmail 20825 invoked by uid 109); 13 Mar 2025 05:37:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=33lClb7LQtnI2AysI99jjO0TqBosVfgFf79pn5q+9Cw=; b=bLRpayf8U415WrX7qustB2uDMxKnfHDFUXyvrGfCaaxD3e5t1fedQVJdRQA4VLTZrjw6rP6s1djzWMh/CNbOaIFewjleSXxJLqGwNzF9RdpsFVsC3Rc1wCWzmOr2jJ1COKPgBE6qdCDWCyRBXem3SbhHBWc48u5VbdifmUtOkOw1dZTXb4EuRIeHtS+wfhwUkANb00gJKrt2Wc58q0gICPB1Ff+lBrNS4rfLlHPaIl3Mgyj2sFR31ZQV/sBLvgfA3eOHJ0SMd2HYr+JYqPnsvMc+Or97Vx/1jt7jgW+uvcU+3hkCBjvMt/nQNCa5opoKRQS8QtiOvw4/9F1yJ3T/6w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Mar 2025 05:37:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11629 invoked by uid 111); 13 Mar 2025 05:37:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Mar 2025 01:37:34 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Mar 2025 01:37:33 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 1/9] t5702: fix typo in test name
Message-ID: <20250313053733.GD94015@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309030123.GA2334191@coredump.intra.peff.net>
 <Z9H82waDYvC3RVBH@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9H82waDYvC3RVBH@nand.local>

On Wed, Mar 12, 2025 at 05:30:03PM -0400, Taylor Blau wrote:

> On Sat, Mar 08, 2025 at 10:01:23PM -0500, Jeff King wrote:
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  t/t5702-protocol-v2.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> > index d3df81e785..cea8f92a3d 100755
> > --- a/t/t5702-protocol-v2.sh
> > +++ b/t/t5702-protocol-v2.sh
> > @@ -665,7 +665,7 @@ test_expect_success 'even with handcrafted request, filter does not work if not
> >  	test-tool -C server serve-v2 --stateless-rpc <in >/dev/null
> >  '
> >
> > -test_expect_success 'default refspec is used to filter ref when fetchcing' '
> > +test_expect_success 'default refspec is used to filter ref when fetching' '
> 
> Maybe I am not seeing enough of the context below to know for sure, but
> 
>     s/ref/&s
> 
> ?

Possibly.

I think you could read it as "it should filter refs" (which it obviously
should). But you could also read it as "it should filter some singular
ref that we do not expect to find in the result". Of course the test
itself seems to just snoop on the protocol conversation, which I guess
is more like the first reading.

I didn't really want to get into word-smithing the test titles. I just
couldn't handle seeing that typo over and over while working on adjacent
tests.

-Peff
