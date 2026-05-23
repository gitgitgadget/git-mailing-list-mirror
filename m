Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D6C3128D9
	for <git@vger.kernel.org>; Sat, 23 May 2026 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779557101; cv=none; b=cUl6H7Os29HfrTHxWMVY4Hub4rWXt118l2bI1VzZ2FE3gABkdW7iIqFyljdHsaE7vDjpNx3ZjDEO3seQ82YMObITZjt3ZCnY6Y6UNHxGZDL7GRuYP9mrhUgXnVIW3U/d0j/TGikGol6TN3oqBR208Llba/3dO+6xhoCMOxgr5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779557101; c=relaxed/simple;
	bh=JjYVnL70ZuCwQvw4BHef6GRoovyNS2kofid/+vkAIek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYp4YwgSWwi3SMHCO4J7g5ArKE+OPHPhMy5Jif809qoqDemoePbf//raU5M/qWSU/3A46yiiBudEuCZaonVXNYriNfgpQ+RGcuIOWQcDX5R2cL57edOEQeOEXXMbAcSvVPBZfuAAlXF1diJBFqHUP1sOlnN7y6c0xzOplvR5lJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=e5LPTQnh; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="e5LPTQnh"
Date: Sun, 24 May 2026 01:24:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1779557097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhdDFW3oV0yVRe/HDQmXwNDi/Vkg8ZMQbST7Rr+tkmw=;
	b=e5LPTQnhaEsSLg8AV4R4J+p87PxrOQ0SOE/mn4vXSBGgMmZmQqY+XRWvNqu73VyrqSzq1g
	dLnjUqF8hws6YGAI1UmA/ErHLGhjn72IqxvHsqMezdfHPzLphB/FMSfHyTG24lN1xR8Fto
	gGMouu8e0jg14Q7daGR5vBsvmoAXl/kedSZoiqS7AUdQ4YztvYl0CEl72/+kRjoO4Hmoqi
	ujoE+I56fzKT8Av7Z6L8WA3+VmfQ0P+BedeJebuNNjnAxwZ7zWBRqZUa+mbkMtuDhmFyYG
	UxSkscjkdE0bji6l3InKKNCTl3EKxiMDN9aoHRFU9Yyd4RjeAyqgU0igxYP0aw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrew Kreimer <algonell@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: fix typos via codespell
Message-ID: <ahHi0r7DZYfQ1Xqy@wy@wyuan.org>
References: <20260506101631.18127-1-algonell@gmail.com>
 <xmqqa4u6aotg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4u6aotg.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

Hi Mr. Hamano, I've checked the rest of patch, I believe Mr. Kreimer is doing
great.  Meanwhile, I'm wondering if you are happy to accept patches
about typos or not, since I have other remaining corrections for typos
here.  If you don't mind, may I send a version of it add sort this patch
series out.

Thanks,
Weijie Yuan
