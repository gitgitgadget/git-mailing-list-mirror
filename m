Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5EFBE5
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498144; cv=none; b=Q6B/JaY+oIWktdHGNo2wKnEh3vCVwg923oF66TQXLycWaIHAAyviDjmOVr/YA+gTNZ69O2B407wa+6QFiViotXT68B9HDdPMpKfFPZ5Fmz9mXu3T83MEFEN10TpWnCiboZECRgYviIjsh6I2oxDK6At3mnfvOpg7R4TZunOLN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498144; c=relaxed/simple;
	bh=21nb5NeLQJEwQMRl4iuMtgmcfYLRXJFushfGwD0OnfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iaJwiqw3+Eoc3o0xGsQ5wHmOPbNXoADsgqjsIB4ctTRr8Ep1Umkn5RVf5zP990Ep3OabKGbrfibyH/voRqDsx06UXR2u+5wlFUCpg021cHWAY2owt/j++TM4vp571CvXNjBgQe/gyV/XpZ/e+/prUMDPEhmcqTXSp77XzkyCZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 27614 invoked by uid 109); 29 Jan 2024 03:15:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jan 2024 03:15:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18030 invoked by uid 111); 29 Jan 2024 03:15:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jan 2024 22:15:42 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jan 2024 22:15:40 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/2] some unit-test Makefile polishing
Message-ID: <20240129031540.GA2433764@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The patches fixes two small hiccups I found with the unit-tests. Neither
is a show-stopper, but mostly just small quality-of-life fixes.

  [1/2]: Makefile: use order-only prereq for UNIT_TEST_BIN
  [2/2]: t/Makefile: get UNIT_TESTS list from C sources

 Makefile   | 2 +-
 t/Makefile | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-Peff
