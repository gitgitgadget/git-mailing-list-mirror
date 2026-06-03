Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982F3D7D77
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452761; cv=none; b=KDDs753girqV8AeEC+DrDg9ojlql+Hm6r00JVYfMTbk2neo4Vu+2+STNeE5GnFH4Hk14rwUoz+n+bh30EZr8rwR3vZTqt3DH5kLJmLoiIZ35/WWh9KzcJ4w5L/KvYGEuGID45cH0UlPwC/5ZGJzdNup3n5LHRlph23l2XyBZAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452761; c=relaxed/simple;
	bh=IvpU40solk76Ax+KCGeD4lucWP1xRGe4MBASYE12SK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ercvYHaO8q9S1aOFXEtTw8wxPm5swPkB3iYKLOon7eLoCI7YEXJQlNujfmBolrgXxD8iS4hNrB7ieQd7seBhlZoxkZkTXSdEy5GY9zIcumLDww+kBbzLSlfllSh+phc7s777FDnRQWcBvVNkLvy3mSXJ3OELgtXCGXh5LxSUWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=ACeW0c6Z; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="ACeW0c6Z"
Date: Wed, 3 Jun 2026 10:12:22 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780452758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=buGIpZOd0EwjwYc+PVWzJsk8B4VQBRvgOknSV8L3t7k=;
	b=ACeW0c6Zz2gcMycXH/yC2kyL2pDha5VmYbMmmrRv15bT8ZbpxdTjefaaKB95qdpOSevPys
	HxQ69UGLzvXMm3CjFF8u5z+K3b82RelxGGnmGJkkUYcZ1UhckEmH03eomn33q7/VthAEil
	qSPSnNWfM9SzW2uxAE1vRpYZYaPGNtwtmFxxL1MMlTp3u+yiC1JOl32NuSI3+Stupz3Aos
	BR/mm2KeYZBtUf9NOR5TIwLczX4XCjEODrCcV8XaH7NUtcxrVxfgv69bHvxWiEXxrQFB1B
	2Eb7918hrWEiWFZIRJJYcmv5WR/nwvNpPRC5AZjFb69KQkptfd8d/WUnKS+KHQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <ah-Nhr2PboWUq6eU@wyuan.org>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
 <20260602170955.Z4b7y%taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602170955.Z4b7y%taahol@utu.fi>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 02, 2026 at 08:09:55PM +0300, Tuomas Ahola wrote:
> Huh?  Doesn't MyFirstContribution speak *against* shallow threading?
>
> 	        [...]  make sure to replace it with the correct Message-ID for your
> 	**previous cover letter** - that is, if you're sending v2, use the Message-ID
> 	from v1; if you're sending v3, use the Message-ID from v2.

I don't get it. Doesn't shallow threading means every following patches
are replying to the cover letter? Replying to the previous one is
--chain-reply-to, if I'm not mistaken.

Thanks.
