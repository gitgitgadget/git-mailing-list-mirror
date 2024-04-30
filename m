Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D57464
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474771; cv=none; b=i9Sb5riH+dKjFgkaA+p349zLeMTL56uTiik1NYNON/9KqYnkmGjtvkE2BGZ1t5YtFiof6t9haC7PlBc1yR+Zm0YQSYjFY8y5mBiZLSbWTte98UxDJQjLHkLocAv1Dr9+t5o/kgYs4WCiPvVIaYE3al0nbU6hgiKoMJDjj5Ufqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474771; c=relaxed/simple;
	bh=nw7cmcFbxrLKhE5RSsRhpqy5K8QX2HkK+pOkPhiVbs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKBKHF6B7DMtIY+tZD29+aY6rIN08BxFM2RrstBdXtDaG7u8UzyH0CgCpJ1w0PJUbKX2KZ6PNVAVZJHICh93j5Rtmdj5ieCUmWTDm+2RJ3i4bTW0FseOX8I5R7Yx3HuWT9K0DsjJp3F9HjIm9a6CcHnNPLD6UqnfBqw9V55N+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3917 invoked by uid 109); 30 Apr 2024 10:59:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Apr 2024 10:59:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5897 invoked by uid 111); 30 Apr 2024 10:59:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Apr 2024 06:59:28 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Apr 2024 06:59:27 -0400
From: Jeff King <peff@peff.net>
To: Beat Bolli <bb@drbeat.li>
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 1/3] t/t4026-color: remove an extra double quote character
Message-ID: <20240430105927.GJ1279403@coredump.intra.peff.net>
References: <20240429164849.78509-1-dev+git@drbeat.li>
 <20240429164849.78509-2-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429164849.78509-2-dev+git@drbeat.li>

On Mon, Apr 29, 2024 at 06:48:47PM +0200, Beat Bolli wrote:

> This is most probably just an editing left-over from cb357221a4 (t4026:
> test "normal" color, 2014-11-20) which added this test.

Yeah, I suspect that is correct. Modulo a minor comment I left on the
third patch, the whole series looks good to me.

-Peff
