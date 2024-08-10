Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C0F4E2
	for <git@vger.kernel.org>; Sat, 10 Aug 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723295731; cv=none; b=XgUsnZzEFBeic62nMh3uW5fjZdMgFxo42y6xVXRjJVuvqSmvaqBFWS7CvcSD2EAe1xoJp8ypax5GthhcXyru/qqwYjkvEHwnl2g6TG60VtX9TGOnYtcLzB4vnus+Yt+rntLfHs5x5lJZD64ODuNeYcruoFnpHC20aecs2plXESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723295731; c=relaxed/simple;
	bh=xVAZsutqTcJo20QC3ZGeoXGohpSZInQ/G/Y8LhRfhvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIIwSgAroW/hYbzPaOvOooTvDlOieJOVzliUDdDa1Z6nCCIq7FHm84BexPYkWDwnJOaqF3fa/ygd0l437tiOgIv1wRMB8O/LvmOWEIECTvhkQfTWPBuO+6+ZcjhyL4mythwt+rcTDbfu93JHWT7IexcC7YPfSSKZ2Vi8Uzak/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=oKwVeiZr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oKwVeiZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3843C32781;
	Sat, 10 Aug 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oKwVeiZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1723295728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVAZsutqTcJo20QC3ZGeoXGohpSZInQ/G/Y8LhRfhvU=;
	b=oKwVeiZrYW2HJJ0GBVrMHYJYDalgGXCYYNFwu71YZoG1xRCE+SdRe98SkClzhOJA9Krzgv
	w1i/SeHWpIr9S/KtNwTenK5OtlQM3qZlwhuARssQlUdvzrTjuiVExTsLkbSlb4XSN2p3eb
	XBigMJukbyFLkJZDAmwKf2nKu9AIdKA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 721c5a1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 10 Aug 2024 13:15:27 +0000 (UTC)
Date: Sat, 10 Aug 2024 13:15:21 +0000
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com,
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com,
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net,
	dsimic@manjaro.org
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
Message-ID: <Zrdn6QcnfmZhyEqJ@zx2c4.com>
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723242556.git.steadmon@google.com>

Still the same name for v2? Cmon.
