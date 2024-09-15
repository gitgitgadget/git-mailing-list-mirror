Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E9946C
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726398683; cv=none; b=pqYU4v457SUt7axf9gKaC8hKuNkkrYHqv9djUw8T/HZSazBuKo526+B7cpRjTXWx64nmilWN9k80Gew8WMOLQ5dnmqMkdn9ExjzUH1OwsieX0xadFU0JJiza9t90wqDSb2P+qq0qb7gVvoaKwXKfxiMT5PS+X4wSeYSeGg9miGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726398683; c=relaxed/simple;
	bh=93cfw8LftGyKPbSm7b2KC74XmKsODZkJBPoyGhPBfH0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fSWhldHold7FkiYwrEDJiBdsQLXD0VGdVqyR0F9wT9uXAMEbgOZCDakh1/RBQibZ/kPhSEnpY2TuKyQJ+Gqf77Ks9ta80Awzt9Y6ga4cItRickPn/Uo1D6SvTShBOTGa5L7QJWMRprSekeBT6YIrRjZxOK0I34L9B+Wbdz5aWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8054 invoked by uid 109); 15 Sep 2024 11:11:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Sep 2024 11:11:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22035 invoked by uid 111); 15 Sep 2024 11:11:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Sep 2024 07:11:19 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Sep 2024 07:11:19 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/2] a few git-jump quality-of-life fixes
Message-ID: <20240915111119.GA2017770@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Here are fixes for some small corner-case annoyances I found using
"git-jump diff".

  [1/2]: git-jump: always specify column 1 for diff entries
  [2/2]: git-jump: ignore deleted files in diff mode

 contrib/git-jump/git-jump | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-Peff
