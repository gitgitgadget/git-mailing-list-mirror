Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.231.85.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276230;
	b=FPdHnsCv6MmQLSVPubN+GZY99CwdJ0b2X4J8F/e2hpMuuZcH89Ey8T4Z2svXk1VsUyan
	 UeA7NgByW+0/1u17GEYi+v/ZTbDfST/ns2yI/plKPv8X/o3K7QaMaoMZMjjxQeOFQqzii
	 rW2oRZDVfEWC1KuAx6WCizRBNLFulU08gIjfIK1ZXC/wQ0EKzJUPWlNvNUjKc/182SlWW
	 0w8Cec+tVPaal9Pa191sqJPC5tffuxeTE+pCDgkxVodjGpYXSnwFXQa4qJPd4tqRt59Xt
	 cP+lUGl19z8X0bt7DGxCLWtSXCDBs5gaOlwMLEIpoHybST5m82Dt5zXf1mpBL72AEnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276230;
	h=DMARC-Filter:Date:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Bar;
	bh=szysN+vuz43obpG7/1+MiDYx5qMawaZw4pzFoywvRHU=;
	b=hn6n/TA5Wy6bagZYJjFKgZxwGXAIsnnpN4SaTG1LVGaefEbcDQMYp9aLbIeifp5KJlw/
	 Z9orsS8+xIU5FQqesBmbLmZToVxblgdlCh7RoSCXdd6XEjT1a9HU5eFI6/wl3bOumT2Z4
	 N+4FHGSa1Rgi+6dscj34+5CWCJrYIgyz/4YXDJokFTqfzR2bYvOqL9QwaHeinaRg4i30Q
	 h1GExRngNAEMJi76NxCYBLeenXPlFyEBh0dLU7g21r8sV6luhyq0iehFnjJY3ZUVvS8s6
	 Y43SjCtUgsZ7rEwpnytjKEYCLqHpGFPgtW+lMoM9wQgjT8HI3u8GrF4KjDtfadgwIzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=delayed.space;
	spf=pass smtp.mailfrom=delayed.space;
	dkim=pass header.d=delayed.space header.i=@delayed.space header.a=rsa-sha256 header.s=dkim header.b=LRxM+Eod;
	arc=none smtp.remote-ip=195.231.85.169
Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD229606A31F
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD229606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=delayed.space header.i=@delayed.space header.a=rsa-sha256 header.s=dkim header.b=LRxM+Eod
Date: Thu, 29 Oct 2026 13:16:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1793276221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=szysN+vuz43obpG7/1+MiDYx5qMawaZw4pzFoywvRHU=;
	b=LRxM+Eod6PF/ThWiIX6H2m/Vbokkf9gpfBI4utHJ4MRorFrYLY7+TehumGlou8Qi36jsLe
	wtr1teVY9sPZkSQGAWpQyRRn1htRHLeR4zQxGdcKOE0oQLOdtx0Zl+NwMditj8MYIMjvNh
	JvpbuYfZsx5g5n+j8QMIDZh/jMvHqprq9psH5jm6U01G+YHfaf3vXm/mKEmkGlzsPmYyv/
	d0r+bs0ZGA1hOEu7Up9eh4cyODvLAtAH6d5V91bbzEeA9VOZvegra2IQmeJ2Tzq0qwG0pB
	Llrd3uwMOZwh3F4OiXOUNAxGbVehf2i9uUQL4PX7afUit/qmYvYjO40DCviAcQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: Re: [PATCH] bash-completions: add --[no-]graph-indent
Message-ID: <auM4thx0rLN1-sUi@exploit>
References: <63106e1dec45e82c7f132a18816b2d1fffb52752.1791921033.git.mroik@delayed.space>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63106e1dec45e82c7f132a18816b2d1fffb52752.1791921033.git.mroik@delayed.space>
X-Spamd-Bar: --

Cc'ing Pablo since he was the author of the topic related to
"--graph-indent".
