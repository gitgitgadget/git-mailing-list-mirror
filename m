Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887F723AE87
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407764; cv=none; b=XhYhTF2xx6fuk1oMlaLMrkJiq2q7aC0Y2KhM4l4iJCwEJVZ1a6CDtOVutRnUdskKhTvI6IpSzHrO6MsFupKOcr529BgR6YtnTrlZhDYoQRr+G/6umJW5O9vu2FdO/OSsdh/zXmQByvWwR1Ypmv51kObuRSRXEvY4y9rDBzJuWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407764; c=relaxed/simple;
	bh=p/OKMQxI69MvffRVbXKh31iq/fV5jpFugvXrELEgpkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e59/uR6qTnOaquYYyTVbP+McGcG4RYyNXBQvKr8itIqQ+KWPScaqD/9++D41kvV0EVRDzYFrVrK1RjFLN0fRTAATWVze61Ptfiu/s6cTOxtFSWGhz7cgCjnck0D7yxjQlgyDuWxb5lGUKk5piR07XRLdH96kGN7fG0Nd4wKErfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6hxzUu7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R6hxzUu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0334EC19421;
	Fri, 13 Mar 2026 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773407764;
	bh=p/OKMQxI69MvffRVbXKh31iq/fV5jpFugvXrELEgpkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6hxzUu7S3Rscx0+eSYY3QCTL8HfigE3nohs3pTWAG6gO+vwy2sApPtbiXRDC5VUj
	 atjdpbdnSnpEyEw15qe8PisUuNuuLnEWasdjYt9Qj1bxM9eHDiG/Xlz9HJLHjGa+Rt
	 Ruqc6wd9SZmk/uJOGkyoYWiFfKBxEb0s8NTR/99w=
Date: Fri, 13 Mar 2026 09:16:02 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Rito Rhymes <rito@ritovision.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Subject: Re: GitGitGadget's website is responsive, how about kernel.org?
Message-ID: <20260313-adventurous-lemon-unicorn-278ccc@lemur>
References: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>
 <20260313-loose-whale-of-speed-ccdbe2@lemur>
 <DH1OK0NDO2D5.1BKGX8J7KWW52@ritovision.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DH1OK0NDO2D5.1BKGX8J7KWW52@ritovision.com>

On Fri, Mar 13, 2026 at 09:14:38AM -0400, Rito Rhymes wrote:
> Thanks Konstantin, I appreciate it.
> 
> I'll send the patch series in a separate thread shortly for review.

Oh, I just found a bunch of your messages in my spam folder. Sorry! Google
really dislikes messages without a DKIM signature. You should look into fixing
that. :)

-- 
KR
