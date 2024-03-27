Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F428E2B
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530003; cv=none; b=ZqOIEErRrxEnLswdhF+8giMM/7FW/F8QJ5Sn6W98Dkt57+cDNEyNx65R2JCuVd9+bFWeIJnJDN5hlXi4/GDCv6zN8znybHv2/GZ0fq7ZQfS+ivsvggB8lnMbgUh6gJx9Y/sHt4A43+xXct6kYz0xZWD9lGefDArYtblZkbW4f8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530003; c=relaxed/simple;
	bh=TxjuEvVLUxAA5OELDlZlq5UkUiD5tykGBh/QQdb4XXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVXT8faZrCv4A98vNUA5SXm5gqp/vq7DdCmP7DHEWwtEm/KF3v3/y1TYFNbKihuKqSQW/MCb0nwb5w0EqObO2nMTZrStsfFTAJktwA65DZ1Vd7ctR3ux/31X3j0GhP0WTnGdxlhBTVw5KICNB5gaNSVE++kK2nkA+9JGWW+RonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22060 invoked by uid 109); 27 Mar 2024 09:00:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 09:00:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24749 invoked by uid 111); 27 Mar 2024 09:00:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 05:00:06 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 05:00:00 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/7] test-tool: add unit test suite runner
Message-ID: <20240327090000.GB846805@coredump.intra.peff.net>
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1708728717.git.steadmon@google.com>
 <xmqqjzlo8yqr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzlo8yqr.fsf@gitster.g>

On Tue, Mar 26, 2024 at 02:33:16PM -0700, Junio C Hamano wrote:

> Josh Steadmon <steadmon@google.com> writes:
> 
> > Please note: this series has once again been rebased onto the latest
> > jk/unit-tests-buildfix.
> >
> > For various reasons (see discussion at [1]) we would like an alternative
> > to `prove` for running test suites (including the unit tests) on
> > Windows.
> 
> Folks, what's the status of this one?  I just checked the RFC thread
> and this last one (more than a month ago) and the issues seems to
> have been addressed, but I prefer positive acks rather than "we've
> seen it already, take our silence as the sign of endorsement".

It is not a topic I am really interested in, so I was not following
closely. But I think my earlier issues were addressed, and from a quick
read now it looks OK to me. (I left one small comment, but I don't think
it's a big deal either way).

-Peff
