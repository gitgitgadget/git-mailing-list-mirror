Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5150407568
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473640; cv=none; b=vFrabSFumD4o3a6xDGBij8maXf7djxTNRrcMmYKnf7YKFNJC8DGxnI7V7V91TaQI/1JBWluDsmQCgOvchdgz4L7CD6bH7T2yp9pbyZECqAhxr1TEegleoZ/Vf4wJkysxQr+XWxNK7ljDjJNO06T/WduaFZfEfbAcQ1bmbdCO8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473640; c=relaxed/simple;
	bh=rcwmJk9LR604wDL9UgkSjoNFb3HSRnBMuQim1b/aRu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeZ+aMlvsWaUKAr1d4GpdLVgIpVH3C9faoeWqhpo4LFYvcNJ3+N7JDyQAh/t36K2R2hhiKY8D/8X4Y/A0fexH2kRybZmQ6pVpHZxUQAeoO8S8Cf4TxvCdRf3nQ3epFnZ05FuOZN27Odnj3C5mnVq9P98jG6dPWekWILzQMgYP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=x96sCqKE; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="x96sCqKE"
Date: Wed, 3 Jun 2026 16:00:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780473636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4n4k/I4v0TBpMLFnHWMW4kifob2GvFVgdSHT62YNduA=;
	b=x96sCqKEv9p0Nl35MPxkJLYZCAibLf6DhMH/LF5cReTs3c8fKjiieRKoF/alUVVXfGv/mG
	BOYIYaXM7WtIo3oHUGT1z9ep1gH3m9i5oeIaZZ6x+b59xh7s6oYchsXTPqG0Sq7b9Bx9V1
	HROfcwZLcqZTmnQgcLGa113ule4xQg9MPk3Kwnn4BhzPfkVFsKCdP52aWOU57wwEw8zH+8
	Uk5cxrnrjdtGef1wHBQfj1vNE0f+JHypb9pDUwlxPEWpazvatugnWLvW3NzU2dQiyg2jBs
	yiFUkuA3zLk8BlMYDTwyIjv6YXYtg7SMoyJUZrbO2vxEXhk+WBDDQMyhz9LCkA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/MyFirstContribution: recommend the use
 of b4
Message-ID: <ah_fDKBinqbMt5ZO@wyuan.org>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-2-a7ae5a49e9cf@pks.im>
 <ah8ALHMDVA2Gzz10@wyuan.org>
 <ah_PwOsbYfDCx0H2@pks.im>
 <ah_dh3uozNdYcL0_@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_dh3uozNdYcL0_@wyuan.org>
X-Migadu-Flow: FLOW_OUT

That said, my ideas may be too nitpicking.  Overall, I do
think that introducing b4 support would be a good thing.

Thanks for the replies, and for bearing with my questions/comments.

Weijie Yuan
