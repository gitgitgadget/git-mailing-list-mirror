Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE5208D1
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510869; cv=none; b=GvOxlXXYvUbVMWgBQ1vPnx6WgCSVh598lE9C7Mun1/fQIofnkZ/+kbnIi15s94f2NXaCE/kuO96OJ7EppTeC6WcyisbY99SaW2W95mO3tL5AUMpLo3qxuynLzJyWNrfHGyYug2ob/F1X2ljW2flKNPXL5caTNon71jROe35T69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510869; c=relaxed/simple;
	bh=28y+wL6towChzgx71yaQUmoaLM/pVKoBf6BSFQP/zYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf3hpPfthsalG9G0Zu7L6mcS6Kec7Y+9CD4nsr/DLjn9hZ7ZqJ/Az3x41OPfyOvIeGfA0AHntt4z1DUNjfd8pKMJCqyUDPQuz1usBaGGcoUquZ+ShaxQ4vBgll93bAys2tfVusHsTI2pcIiGtMAJt19vtBbhyL3LjxYKe6BZ10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19834 invoked by uid 109); 1 Aug 2024 11:14:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 11:14:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31322 invoked by uid 111); 1 Aug 2024 11:14:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 07:14:26 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 07:14:26 -0400
From: Jeff King <peff@peff.net>
To: Hong Jiang <ilford@gmail.com>
Cc: Bo Anderson <mail@boanderson.me>, git@vger.kernel.org
Subject: Re: [PATCH] credential/osxkeychain: respect NUL terminator in
 username
Message-ID: <20240801111426.GT1159276@coredump.intra.peff.net>
References: <CAEcKSiyo3dyNpGkE_FWE-Y710RV0H3EytM2psC=+by=4wP5qpg@mail.gmail.com>
 <20240731074228.GC595974@coredump.intra.peff.net>
 <9AA59434-916C-4978-B3A1-33FD70619BFC@boanderson.me>
 <20240801082556.GA640360@coredump.intra.peff.net>
 <CAEcKSiyf7JPypM93XLFJLjC1T-k9h6kushM7GqTyCBe8rico=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEcKSiyf7JPypM93XLFJLjC1T-k9h6kushM7GqTyCBe8rico=g@mail.gmail.com>

On Thu, Aug 01, 2024 at 06:57:31PM +0800, Hong Jiang wrote:

> I confirm the patch works on my system.

Thank you!

-Peff
