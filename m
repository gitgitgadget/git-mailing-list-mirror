Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91F1C3BFC
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772265082; cv=none; b=r2V6MBCkTgiadZQ9hPmY4bajYmfH1p6p1VtTnrNnTdD8npEO+W8TKks8L0lPAQwMts7b3x6/j74CfffdC6n7LhJAotdeu8jSFLik1pLe3nIsHmqHUQGbG5ov2g0R0NmsoKoFErnQkfVlZUB067Llt+lPygAvjDODR+k2Rc0heqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772265082; c=relaxed/simple;
	bh=5KaIAB7U9qP34lXAHOaKU5TkjS6BM2bngJ3rq0/rr8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ne7bwoIf8RxcabhEtwvoDF2Ij+3fjVrgHiCSbEeqAqQmMQTYqRWNnreOADaw3tOfx1PueJw0Nyuz8XkJiqXsHKhEnbY/pJDKk6cO6MD9qbOJs800CmNWXuzH0q/hG9XXshAYeOL53sD/CncpLqLsAj/sfCM6vxI4gG6Or/enWqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4fNHSc6h9Kz7Rdgg
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 08:51:12 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4fNHSQ5p1dzRnlK;
	Sat, 28 Feb 2026 08:51:01 +0100 (CET)
Message-ID: <8526ae9b-804b-4f39-b5bd-1a8971cc7d6c@kdbg.org>
Date: Sat, 28 Feb 2026 08:51:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: support config the color of linkfgcolor via Gitk
 Preferences
To: Wang Zichong <wangzichong@deepin.org>
Cc: git@blumia.net, git@vger.kernel.org, gitgitgadget@gmail.com,
 gitster@pobox.com
References: <xmqq8qcet9ln.fsf@gitster.g>
 <3FA6BA9ACF1B34AF+20260228033725.2546976-1-wangzichong@deepin.org>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <3FA6BA9ACF1B34AF+20260228033725.2546976-1-wangzichong@deepin.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.02.26 um 04:37 schrieb Wang Zichong:
> This usage is actually from the example provided at GitGitGadget's
> landing page:
> 
>     https://gitgitgadget.github.io/
> 
> If writing multiple CC trailers is preferred, maybe we also need to update
> GitGitGadget's documentation as well.
This page says:

"You can CC potential reviewers by adding a footer to the PR description..."

The commit message is not the PR description. Please don't add Cc lines
to the commit message. Edit the PR description on Github before you
/submit the patches with GitGitGadget.

-- Hannes

