Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7E1841
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473877; cv=none; b=a4X/NIgTIZ6ZgXMTk5aT5VO8FbqvLQq568i2vU8XCYRXnRo8v/etf2e2jEm8qgiMdRc33SLhRZPUsH5HIQIspXwd65OytQWs50noivMLupKo9JAI9TiiPtv6WNFdEZsptIfODVEj+cZKHJKE41sjKppX2gt7If0uHc0JCv8aQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473877; c=relaxed/simple;
	bh=GAw00Tf+Rvr3maVmUY5AFlb4FcvI7ciw9m+Og3FhBSk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rlqSxxjBvttGenlv+UYJZTQEgBqlHapWf/Jf1d4KpUOMsCY53mJa/aooEoQjcFn8FuyndZlZf3rA2iXZ0cGdADJFEUcxWrfJ49CQiQxUxdrc0wlNEwAAvKKMuFnE6fZndYR67aTAwANPMCaSETCXxPjTdMRd+rxlMMBYNNGI5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=v6JwbvxQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="v6JwbvxQ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708473870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUKfFD0i7jZBbsLLlFziG2LrQwiKdlFTLQ2RmmsJNEU=;
	b=v6JwbvxQ2073vupkhOSESqmFyVl/KHkFI++4VvDmneJf4hQrBm9qam2cIBdyAFhgPiI4W/
	zIIxnZa8dMExtgaIF2T/LOWZ9awK+Kt4TIqNKowpUDBEQVyB2PIqMkitcLB4fBfvJ1oINF
	SnPDV+PBYTbgKmI0LL/XmEO1Um6KF5Krif3ryXi/Ey2CqprYxFpejJyBUteMmwozfx9YGY
	CApBPiY9x7nPD+CzcpT2ELS+1aXDVHseRCx5HSQC7GasZnJHItMBRAy0IED/5AV6Q5RYn1
	E1J97PTUMs/IUq+oLzxkxwclHMRco9+L/Rnqkz2ESVWpM1+KdUPO/EtQkarJ9w==
Date: Wed, 21 Feb 2024 01:04:30 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v4] documentation: send-email: use camel case consistently
In-Reply-To: <xmqqle7elp62.fsf@gitster.g>
References: <88f1fe08c3047e14090957093ee8d98b0f60cb6c.1708467601.git.dsimic@manjaro.org>
 <xmqqle7elp62.fsf@gitster.g>
Message-ID: <9900bb4dc72101b48267ee7bc4b978be@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-20 23:57, Junio C Hamano wrote:
> 
> This version looks very good to me.  Thanks.  Will queue.

Great, thank you!  I'm glad we've reached this state of the entire 
patch.
