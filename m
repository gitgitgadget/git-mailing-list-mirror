Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8903C6606
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983276; cv=none; b=ijvNS0xHakLPT/foitWocjNWK+DMSbM+tH0ElxrvWuMkMoVmGS4+ddt7MlM5X7CWjSpFk779ddZRQ40iUGHjwX7egBdageAgUoMfinYY0qOpGs6kK/amoORu2YoFoq/rHSdrrt3qiw/lsTyowqtqTZ6yJQ4Dx54ywUg4g1f2udg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983276; c=relaxed/simple;
	bh=2zc258UZfjJFTrQqJHxJiwxdL01Mj3HIsC1HBFabwm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPX3TBBq/+AvrH9vkk4sLBYEFYCW5JtF2Q18MrNrOSZvs/q3Y5LvcVPm1rQebWTe6pbMmeoMJJHuwelXdMFDII4NU4KHmp3XigHzOSs0Sj/4T94rtZWfZ572cDavZbbU5Q671SWJwWmSzdKp+beQiR0aikYkEdmxOqdAhYEin+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hgBDJ0Wskz7RCKT
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 21:47:44 +0200 (CEST)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4hgBD634fTzRnlT;
	Wed,  9 Sep 2026 21:47:34 +0200 (CEST)
Message-ID: <9f078382-411f-4865-9f01-4fe0b1ee118f@kdbg.org>
Date: Wed, 9 Sep 2026 21:47:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] mingw: rely on MSYS2's metadata instead of
 hard-coding it
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org,
 Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
 <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
 <4cc14553dcddbd7fb1a49864ae988bad19626391.1788981436.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <4cc14553dcddbd7fb1a49864ae988bad19626391.1788981436.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.09.26 um 21:17 schrieb Johannes Schindelin via GitGitGadget:
> [...]
> 
> Note: This keeps the same, hard-coded MSYSTEM platform support for CMake
> as before, but drops it for Meson (because it is unclear how Meson could
> do this in a more flexible manner).

I think this paragraph is now stale and should be removed from this
commit message. I don't know if it makes sense to insert in 12/12, though.

> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Except for this, this is looking good now.

-- Hannes

