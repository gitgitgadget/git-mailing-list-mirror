Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCFA1D6DA3
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202576; cv=none; b=r9Jdjc8NLJLB7V9NMrbZJXQG0GZzWDjgJJZ0gQFKqlk6igO8JTjX+scRKb5HpMC0JtI2BN5epRv1XBBFNFUSfrnE1AlvM1WYeVWwx+RpCOmlosLLyBeVVGcUJOfQIWWFbvkDG9yYWMXrkDFGpQ4RnOUS5zsn39osD0F2z960Zss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202576; c=relaxed/simple;
	bh=6NAe4pbreCOHfMXnbFUZAAulQv0icaMJCbKmhEoqC5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kamwo1E4a9Npx5jCzbG9ZPpn0ZSI6na26i8pfLfxw3ZPbpzUhSZAbeF5LB6LsMiSHkbk7TseWWR0CO3GS6mYGsyHPY/pBHHfkN4TigZJbE/3LCEbaEZul3r3eUr71juCo8FEDJuMInXiX54gCR7QSUNOINqCb00OQ2kk0CnsBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=Ul3CHOOS; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="Ul3CHOOS"
Date: Fri, 18 Oct 2024 00:02:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729202572;
	bh=6NAe4pbreCOHfMXnbFUZAAulQv0icaMJCbKmhEoqC5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=Ul3CHOOS3b0U4RZ4FR24vhvU1M/nRPSVpfaaOeZcQyArNQh1PBv1EyyjpRf7w7Vnd
	 PWm7U8HCEtMZa0AXH06FKuD9a2ZZ0KH4Wyne26QkYY1veoQhpriM9MhOF2da5iZBZt
	 G631zpb+yIflmfhL4KMMbw0JbX0U1xyPf7IOiQNim1cuQKupu8xeG+EKI2mp5MCpzT
	 bTq8dvlSqeL2TDB0qt3QTxlYRcEvS1zZEc18UbArEdbZgjDOdVaowSbeeA8/mfzKvs
	 ulagAtIdSzVnJJWuNfrwfGMR1UR7Hk07je+n5kPT1NilFP5yMnHYOgzub43GRqx3i7
	 O6HZOS+0WQQ7A==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4] builtin/shortlog: explicitly set hash algo when there
 is no repo
Message-ID: <cinnj37fsmmgn6x5gibkvj7mtbn6vyv4pclxyv5sgpz75b5uim@ptzc3xjk3lfu>
Mail-Followup-To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241017093528.18157-1-wolf@oriole.systems>
 <ZxFvQsV7FHel/pZe@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxFvQsV7FHel/pZe@nand.local>

On 2024-10-17 16:10, Taylor Blau wrote:
> This version looks great. Thanks, Wolfgang -- let's start merging this
> one down.

Thanks! And thanks to the community as well for the help and feedback,
as well as the thorough discussion. It was fun to contribute, and I feel
like I learned a lot :-)

-- 
Wolf
