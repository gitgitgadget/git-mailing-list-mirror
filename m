Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6535C1DA21
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818376; cv=none; b=UK1e2zhgeV8ebNt9jqwevtnqkxxIhpNzzR/3v9r9ZfVexvq51vxLQW3ENTpysYqlhbWfJaKy933gRJhUql2kZxhC3a7E6nz+A/A25MWlZDX2O+RMoT7OxUajOsXCB7EORSPJaZqPs11vNNrNhcB/7AibxCd3MmTi6t0NjpcOqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818376; c=relaxed/simple;
	bh=dq0xcOeKcHS+Ozo59yarFR925NyhEDGhMvlrEZmJKss=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQiu790KjZvow/OaC5U9j+E3NUGfRMHJkGHG/COSeWd30MYGukngZ8hwpk5xU9gGgSpMwnAh3mIb1jHnwqJaVG70i5SvMdzBeEloh0H6LHlNHePzvNdv9WH//3IK9XIw3d/ApkkUiXCrVlr9B/AzR7zjLxlFq+fbg6GbwLKozHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20578 invoked by uid 109); 28 Aug 2024 04:12:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 04:12:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23200 invoked by uid 111); 28 Aug 2024 04:12:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2024 00:12:56 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Aug 2024 00:12:52 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: Re: [PATCH 0/6] unused parameters: the final countdown
Message-ID: <20240828041252.GA4009884@coredump.intra.peff.net>
References: <20240828035722.GA3998881@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828035722.GA3998881@coredump.intra.peff.net>

On Tue, Aug 27, 2024 at 11:57:23PM -0400, Jeff King wrote:

> When applied on 'master', everything should compile cleanly with the new
> warning. There are some new cases introduced in 'next', but I'll send
> separate patches to go on those individual topics.

Those are at:

  https://lore.kernel.org/git/20240828040944.GA4005021@coredump.intra.peff.net/

and:

  https://lore.kernel.org/git/20240828040803.GA4004932@coredump.intra.peff.net/

I double-checked against what's in 'seen', and there's nothing new
there. Of course I won't be surprised if something new pops up while
this topic is cooking, but CI will start catching it in any branch where
this is merged (and the solution is usually pretty obvious).

-Peff
