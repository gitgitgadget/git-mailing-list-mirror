Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7149519D07E
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773622353; cv=none; b=mUcgy8rrAFkRnLwSVt6Act45hEECu20SYksJ6yufIxwSgNSfAklH0PBTsU9FfJBFCI6XPMR/kJBMCV3BxoFeUJAGzPnNLlwDw5Eb3Ka6KyLmFQvhMV6GUpalHroR5BO5HmmczgNPDFinJA6Zg8fZ0JAGxNRva1/aNyD0GLBkWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773622353; c=relaxed/simple;
	bh=XKAzziTC8CsH2m6JbnpJJLd7YXgWId9B0uA4GtcFODY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H87NOgL7zZzitqWXUNxHCNnONn/RuY9nVZ3pQJGyCpOEz98XMpNBsfo5vSU5ercjmJxPDRtdNiavywymC12U1/eGzQRIv5X1nwy127NosIi4TPZIPUUnKCpW54xy2azzRlk1vFf5/WK+y5coezedwdrhEdPViclDGq9KJQ1+5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=TPArdkBV; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="TPArdkBV"
Date: Mon, 16 Mar 2026 01:52:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773622350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKAzziTC8CsH2m6JbnpJJLd7YXgWId9B0uA4GtcFODY=;
	b=TPArdkBVIKgIMM9S4QO3xyC0TcABmo3p3hQrBeO0iDccj/DEPZcJDD2UOGqM1baWvqlxkt
	Z48jOstSfcl23ZIZFzPpy/ag0RSaadeHOMk5yHtDpVoIdJ936+Z7LmFtMtUy2LkBmLLqk9
	hTLKRTlMjnyFLDg8IOlGPgv/3o/LnQ8nx037rrnvH9pi93Kybsoy6p6iop8pUhJANE5rt7
	4xo/8Fv+JERVaiiQfUaDmMdGgZClKrlQOCNEcN0izKSE5uy3JjsMfEr2Wc8xBGK9Pwj2KK
	eArZsqT+L+PmMVb2QVTXBpvCqFpmcKHA9PDp97x07DAYBh7B3PMW0fEQJE402g==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Tian Yuchen <a3205153416@gmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH] apply.c: fix -p argument parsing
Message-ID: <abdUJ4A8GUaRxwPy@exploit>
References: <20260313031950.1695103-1-mroik@delayed.space>
 <20260316005120.7079-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316005120.7079-1-mroik@delayed.space>
X-Spamd-Bar: ------

Sorry, forgot to mark as v5
