Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD17F9
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712595; cv=none; b=uWjlrOR/aR/MYCGDR5xmqd2jpC3K4oUEghaLWjJsDIlQqkRfOecGaTWR3FXQvcy5ZV5Y3FZvEkJJNimTE/VOweC0lrtnhl8LwjaTrLWPV0YoVIxd51pEETXklamWPVxemPE89wibYuleOepeARH2NqrXkxnDwJChzEUe5UwWkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712595; c=relaxed/simple;
	bh=9MUrJNCSWn++riczLpZ9ZjGb/ajbJ/FbSIzA4/6A1vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntkQiiuB70yhPYtF9BECXI6D2h7g2YGs04G6Zx3K8UBIadjCRQUEK2ZiTlnK/ilCO+Jx+05RFfMc6S1d9XyCFhp0kAQagsU101IZ4VBtnhOMlfMQgiCvEzoP/LjUxfig82h0CxI6Xmc8Ja3VRpmhbyS5+LWoQ7bLSwZlGlYGXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 511 invoked by uid 109); 20 Jan 2024 01:03:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Jan 2024 01:03:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6681 invoked by uid 111); 20 Jan 2024 01:03:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jan 2024 20:03:13 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Jan 2024 20:03:11 -0500
From: Jeff King <peff@peff.net>
To: Peter Hunkeler <peter.hunkeler@gmx.net>
Cc: git@vger.kernel.org
Subject: Re: Suggestion for Git docummntation Book, Chapter "7.7 Git Tools -
 Reset Demystified"
Message-ID: <20240120010311.GD117170@coredump.intra.peff.net>
References: <54482cec-88de-4e88-a153-f699c2c087d9@gmx.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54482cec-88de-4e88-a153-f699c2c087d9@gmx.net>

On Thu, Jan 18, 2024 at 07:42:52PM +0100, Peter Hunkeler wrote:

> I appreciate all the work that has been done to give us Git users good
> documentation.
> 
> As a rather-newbie I have to lookup the commands I need for rarely used,
> specific tasks. <git reset ...> being one of them. If find chapter "7.7
> Git Tools - Reset Demystified" very helpful. There is however one point
> that newbies might not (yet) clearly understand: The git reset does
> *not* do anything to new, untracked files that might exist in the
> working tree. To cleanup, the advice from various places on the internet
> is to issue a "git clean -f -d" after the reset.
> 
> Maybe it would be helpful if said chapter had a short discussion about
> non tracked files, how to clean with "git clean -f -d"

I don't think the folks who work on the book content tend to hang out on
the development mailing list. You might get more response opening an
issue in their GitHub repo:

  https://github.com/progit/progit2

-Peff
