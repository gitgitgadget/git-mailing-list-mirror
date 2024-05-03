Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89715481D1
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758524; cv=none; b=bxo8NFCcMcrWPwOHP54EgLJ6AGnyR15y81/mCEE24rFIr0BJsNsWrPqQ7ucY5nw71i9SCBBiv0Fu3SdourvjaNBbA7ERuKWR3kiJQVO2XtRZ/vb+8UOMUxZciEjRTaxaJt521KOV+g0PHaCz7HJ774mzNDZPVCY8PZYU/uNDsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758524; c=relaxed/simple;
	bh=Jps6KVwqFm8fRpGKz7WTO25hAakw7xYIC39T7mdShS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLBqrBdzySa0jFfYIhmtJ+Zqza8vW7b/N7ZrFpUYiAKpiUy5G2UqwF8cNP4cnI1ggpfK6dB4imQ18UEG/ANT/tTeTJMvpKQ5sN8OZ06pcif44ap+j2aCrMqfmSLzGdRw08/U7sPbSLkkYr6r6YCtqzbuU/7ijPF34Sd5OXpuWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11849 invoked by uid 109); 3 May 2024 17:48:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 May 2024 17:48:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17510 invoked by uid 111); 3 May 2024 17:48:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 May 2024 13:48:43 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 May 2024 13:48:41 -0400
From: Jeff King <peff@peff.net>
To: Beat Bolli <bb@drbeat.li>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 0/3] color: add support for 12-bit RGB colors
Message-ID: <20240503174841.GF3631237@coredump.intra.peff.net>
References: <20240429164849.78509-1-dev+git@drbeat.li>
 <20240502110331.6347-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240502110331.6347-1-dev+git@drbeat.li>

On Thu, May 02, 2024 at 01:03:28PM +0200, Beat Bolli wrote:

>  * The color parsing code learned to handle 12-bit RGB colors.
> 
> The first commit fixes a typo, the second one adds some test coverage
> for invalid RGB colors, and the final one extends the RGB color parser
> to recognize 12-bit colors, as in #f0f.
> ---
> 
> Changes against v1:
> - add test coverage for invalid RGB color lengths

Ah, I missed that you had sent a new version when I responded to Junio.
Yeah, this whole thing looks good to me!

-Peff
