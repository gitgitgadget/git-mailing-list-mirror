Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46C1581F9
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758476; cv=none; b=TinfHnmvXu39/96YtIyUZp41IxkI/YjsOAcRz9uZaL2QtAUTOvDzDAWSlPakVHSmaxAueiriERGG5Mtf5o3CDfXfvmMnmws/j2ff0XT4isT2K2RnUbJt5WYPPdzX7O6R/KnlnCsm8ETzh38Z2k9M4jA1l2DWS21Hv9ljtCvqW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758476; c=relaxed/simple;
	bh=4K4M95Y8Rp+7RLsf67rfdKLFAz1SFSFVRk8lAn8oDxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFcEoDvXtOXZFBxLW1dPrNiA3NfdlCNg/CTB9nDaDxRjXp4lC8dTOX8Eh6wBj9x6Og1ooioiSBUe2IM2hV/++9z/DJy+CAXP5Wz4cBCKBRhnyh00x8bCgMoPMJlF+DnXCaUKyrL4dy4XL3HdBV4+zZYmDFHgslLLpVKQJ5rRXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11838 invoked by uid 109); 3 May 2024 17:47:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 May 2024 17:47:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17504 invoked by uid 111); 3 May 2024 17:47:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 May 2024 13:47:55 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 May 2024 13:47:53 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Beat Bolli <bb@drbeat.li>, git@vger.kernel.org,
	Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 3/3] color: add support for 12-bit RGB colors
Message-ID: <20240503174753.GE3631237@coredump.intra.peff.net>
References: <20240429164849.78509-1-dev+git@drbeat.li>
 <20240429164849.78509-4-dev+git@drbeat.li>
 <20240430105727.GI1279403@coredump.intra.peff.net>
 <xmqqmspazrj3.fsf@gitster.g>
 <xmqqikzyzoam.fsf@gitster.g>
 <xmqqa5laznbx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5laznbx.fsf@gitster.g>

On Tue, Apr 30, 2024 at 12:01:54PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Ah, I take it back.  The preimage was added by [2/3] so it is fair
> > to say that that step would be the right place to do that from the
> > get-go.
> 
> Perhaps something like this can be squashed in.
> 
> Subject: [PATCH] fixup! t/t4026-color: add test coverage for invalid RGB colors

Yup, that looks good to me.

-Peff
