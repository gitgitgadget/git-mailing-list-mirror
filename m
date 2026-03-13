Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E401B4156
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407050; cv=none; b=FOVhC7FbkuSmS7DB67pxFic81sPY530bLmKJbqoPRIzaGDgYGqMgGTjxtFVxPoD3+n5ygiYO2+yzQ76FYIXhuJuv1Oa06V4gozIUmPN2D3tqFFtmO0h97wn4NHjvuVKDgHst7HaaC31R1iYE9JWDDhwS0FUiYDR2oapbkUH5Vdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407050; c=relaxed/simple;
	bh=07gMEmNiciboHsDBxOanNJtSU0dYpNIjVp1ikIw1vaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWYlnhvym/LnsehYb/WEuh5otinOCM0UW9cGPgEyUahL97WrdvW+cYRNzYZUsbYbVCDw7Vh+1sumvxa4FTHzTlSwTlCP7JxpYvu9oXMRPH5u9IQ6XtEwW1AC2ZIQiHiV14KzwfYmpYq2eWPf4HHBgAxszm1KkZ3u/5aVblYszVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rouS1EXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rouS1EXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9B8C19421;
	Fri, 13 Mar 2026 13:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773407049;
	bh=07gMEmNiciboHsDBxOanNJtSU0dYpNIjVp1ikIw1vaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rouS1EXhpyFk6d0AOBmibXwXzi+X5okddZYbNxNyz3RfUexq/nh3Kg6Lzjbg0/zXq
	 Q2g3LMVIIzVUgPV0q6lyhLziLY6JKz+EhoQTEQZOy3wLrgGU4hFvVm8M28gn7BBOlB
	 ZMXbvt2fie9N0BEj1evXQv3aRMoUtbnDGDDhAc9o=
Date: Fri, 13 Mar 2026 09:04:06 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Rito Rhymes <rito@ritovision.com>, git@vger.kernel.org
Subject: Re: GitGitGadget's website is responsive, how about kernel.org?
Message-ID: <20260313-loose-whale-of-speed-ccdbe2@lemur>
References: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>

On Fri, Mar 13, 2026 at 07:52:13AM +0100, Johannes Schindelin wrote:
> Hi Konstantin (and Git mailing list, for transparency),
> 
> the website of GitGitGadget was made responsive recently
> (https://github.com/gitgitgadget/gitgitgadget.github.io/pull/26) meaning
> that it will look good not only on a desktop, but also on a cell phone.
> 
> The same contributor (Rito, Cc:ed) told me that he would be interested to
> help kernel.org's site become responsive, too. He even has a live demo at
> https://kernel.ritovision.com/. Interested?

First time I hear of it. I can take a look!

-- 
KR
