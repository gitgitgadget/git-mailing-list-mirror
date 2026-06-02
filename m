Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4A393DE3
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379944; cv=none; b=jupTndFCqMaw1RdIxhQgCDdV5tl+l8BOmyukGfwLToKdbIz941nCoCS95053npPCnl8mMW5TFtQx6WBqjP41sXOxfmsjY3wQPXdSPn0Pm993T50HKsGZER74ZJYlWuhxgMfz39TNhLnDa8E48x9kgeOHeL7iB48T/NyDMnO2T+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379944; c=relaxed/simple;
	bh=oZQui6C7hX1aNMhwXHyGpgDIbxe+qMArILr7RamRN6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggquDK7FRG07vXBFDuXo5Xh61/3AE7GWi5fZMXYmWG1xFKUJvNCtqO6E973wIHXdlDPTW/OHDHFdtjWFPr3y2n52v2zcZTfTvS3gQVepqOW78MnJWhlqRu5J4lBbTwDOltq1Ztu/bMxDmB0sK5Qz6m9qW9hNZ/34897wmIGh9Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=AyvCWs6d; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="AyvCWs6d"
Date: Tue, 2 Jun 2026 13:58:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1780379941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6a3zME/7CYzYt4FNvv2HENlKG/yKACgF1WEMMGSMcgM=;
	b=AyvCWs6dhnQoYnrt1A03smVZhrv+9xjg2HlzR0LLkA/BQxvAcOFe/bpNMx713epMKeO8h0
	GVAJMPMPrkfOzM/GoHsOiE2BA+V7SYoJ0ixnpuVD3t2hwGSYJ7ZSeo0VIeCbP/dhsi1ROV
	nQBU0cCipZDqaObN8s4Fxe36UFaOboFbl26QFCDAUwKlio0xruZx3/dXXiZmluiA9qcqa3
	gAyK0jQ69Pv6q+APqIZJ9kx8geVwnqQ2IxdS8aHtEDJnFwQsVIOb6hjmScN4zyYH9YIm0q
	ifqDqzCiHM4Sb6qh6MV6h8uBNScDtSwJAfqSNvN6B1Q8IhF7TZMoTf+FO1RJfw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrew Kreimer <algonell@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs: fix typos and grammar
Message-ID: <ah5xFk36HZGWdCND@wyuan.org>
References: <7b502e20e9495cd4720496bd6738a1fbeb453410.1780041658.git.wy@wyuan.org>
 <xmqq8q8x3nox.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q8x3nox.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 02, 2026 at 07:23:10AM +0900, Junio C Hamano wrote:
> Sorry, I lost track.

You are welcome!

> How does this patch relate to the large patch from Andrew that you
> reviewed earlier?  Is this meant to replace it, or is it an
> independent effort that may or may not overlap what is fixed by the
> other patch?  Something else?

My patch is an addition to Andrew's patch.

I think it's better to keep these "boring" typos thing in a thread,
rather than in a new thread, so I replied in this thread, as it would
be better to avoid cluttering the mailing list archive pages and leave
them as much as possible for genuine technical discussions ;-).

Before Andrew said he was preparing for his v2, I was planning to sort
Andrew's patch out and make it more logical or perhaps split it into
several individual patches. But since Andrew replied he's going to do
his v2, I won't take credit for his work, of course.

> Thanks.  All the changes in _this_ patch looked sensible to me (and
> to my agent as well ;-).

Thank you! Looking forward to making "real" contributions one day :)
