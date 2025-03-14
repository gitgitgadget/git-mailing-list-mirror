Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F7A43169
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977875; cv=none; b=lzMi5f2Z8Px2CORFq7MNUoAE6hDVLd4yJ2MF8Vld6n924X+G1HOPQpwjhCLJd9Hs+LXWrlrhrZC6qzlsHmB3xT8BWai6AzCCyxo/i73jguh6C1vO1N2vaU49C9Gk1KWNELLi4F2LbJBlHJXoUfFQMbxrKMrpR1ZVgeVHxNTiQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977875; c=relaxed/simple;
	bh=6Lp/zSrJx3CjP/G18E89iQrYYcRC8hstZiz1vTKPO2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZxPdYFuytSf5B4eUqssZbbpi6Uge6cs/26Vij8ws8xrnNoFYOl9/SSUWV1ivw4pwAx8LfN/IlvUjVRlB3w5EI6J6eVVW8m7S6TsQo4m/VxsWC12qbBxcAbbc3XdnTjOL3JsoHpkdChG9y2lI/uqPbcbkGuiLx6rMvFI6vfoT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hVYLexO7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hVYLexO7"
Received: (qmail 23227 invoked by uid 109); 14 Mar 2025 18:44:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6Lp/zSrJx3CjP/G18E89iQrYYcRC8hstZiz1vTKPO2Y=; b=hVYLexO7HzVmPLAhkDJJNlwcIDpC5/raL2cHIIA4JIiPzlWzzm1GC1BaetZC9zECeT4eKILLPitbNgkWAD+GvI/Fo6F9/IB3po7EOVbSTa4cdjX2dtszBrpi5enCZ0JP0F1Gvd70wiwbfbxywlz5Z+UsFmHIQP34vmD2+CiDePNWNardQPNpnC8gGTtSgCXxgKEHDkw3ZDNWkLV5KAMbMkqEFxmxljgBfErY0A6K55IrPva4BfD0rnyDlmIDTinn8jOj3u8W4yUYQntkyUbq28Y6G4/3dlv7bHtVGbhddZ9db11tBlKLC4uTDK1iJBLAuOtPUwR6VtASm3BfAbj1Ew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Mar 2025 18:44:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7767 invoked by uid 111); 14 Mar 2025 18:44:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Mar 2025 14:44:32 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Mar 2025 14:44:31 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFH] Issues and Contributions to friendly third-party projects
Message-ID: <20250314184431.GB578421@coredump.intra.peff.net>
References: <xmqqcyfdhp0t.fsf@gitster.g>
 <xmqqwmd91zc2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmd91zc2.fsf@gitster.g>

On Fri, Feb 28, 2025 at 02:25:33PM -0800, Junio C Hamano wrote:

> > As a discussion starter, here is what I added to the source to "A
> > note from the maintainer" message I send out every once in a while
> > (https://lore.kernel.org/git/xmqqr05a5wjv.fsf@gitster.g/ is the last
> > one I sent out).
> >
> > Comments?  Corrections?  Opinions?
> >
> > Thanks.
> 
> Around here, no news is a bad news.  I'll rescind this update and
> the next edition of maintainer's notes (planned to be sent out in
> the middle of next month) will not list these updates.

FWIW, these all look like strict improvements over the status quo to me.

-Peff
