Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F67DA6C
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732192; cv=none; b=mN6EAU2UdCiJglei1Ei9P9A8raNINAX0v19Qr8DTyyIDk2Lu4I4K3jq0V7SgCcTVEWSdDQcmQIJcGpPCCanMzIxS0UKSB8W6RZmjzRllZB+HKAxAnTPshC+puqBbj936BRvgo9/L+VdJfRoMd7vGZDMNP0E/cQklmlkl3V4KNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732192; c=relaxed/simple;
	bh=hRwS8tVbNjPLg+ZWqJPPeCFObu2tZZvdGtEWVYSQY3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtDzzlNyp/4cKZfy8nalQkACW49H6I2YyaeRjVpU75teS1eEQgtV2vP+pVQLIcXKzKL2Z95b987k/eUPmZQmAism9QDpRSBZfFg4vpUjFuVvFBPiiEKKVQXfylcGZTi7weGZw10bi9P2KaXTQFe/X/Zf7NMEMgcEw0KQ1a6LqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mbicf7AG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mbicf7AG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB602C4AF0C;
	Thu, 15 Aug 2024 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732192;
	bh=hRwS8tVbNjPLg+ZWqJPPeCFObu2tZZvdGtEWVYSQY3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mbicf7AGaFVlo8x5kZHf9AepIrEfLlZjI7ptPwxmt6vx0CNVG+Iq98Pa3OICVcCsu
	 Z1NbhCbzkFVwY2ck4nHHVa74IlcuX00S8VpCcW7H4s7EMKcYCFACxjzsEmqp9j1Jut
	 hrs1UBmVHpSGY4BHXO3ahhG5MnBUKqlF4QQB1w24=
Date: Thu, 15 Aug 2024 10:29:50 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 0/3] send-email: teach git send-email mode to
 translate aliases
Message-ID: <20240815-small-gleaming-parakeet-cd9d5e@lemur>
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>

On Tue, Aug 13, 2024 at 05:05:08PM GMT, Jacob Keller wrote:
> It would be convenient if b4 (or other programs interacting with git) could
> make use of git send-email's alias file support.

This is, indeed, a very frequent request.

Acked-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

-KK
