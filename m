Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5815E7E4
	for <git@vger.kernel.org>; Thu,  9 May 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267526; cv=none; b=V7i+cBevccCZFiliPmSE9cYqxgLRXDOyf4FjfH9QUa1yp7B80EMNpp1yrxwpMz2lLKkPxotD4TccA6BQBtkg/CPWZ4moEplpXnb2hdrwH4Ob3RXXcCyCxHL3g4z2M8fSZwn+fO5Kuxy+VYQm7qf5jNbONhhHaThnN7dewA6eOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267526; c=relaxed/simple;
	bh=3TwWK0UgbIRbgcGD+ee3KVVa+PjP5SEPooRuVnWxppo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ws28sw6frSIfa7ThoCd95SvXT7+MajAHu4bcBrpirv5ultwwbCGOAAG286W5f0mgadwti4ItKlPLfxAr8I0ub/eBMM/zUmIjBIci/nIz5j929LWE1IIf4QJxCNoux4371wrw7UYnc9CarxrD2bSYGpn+cG+PZPrcGXY3OBttbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=JJFfc8Fg; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="JJFfc8Fg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Type:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f1G+Gdd+ZfZpHpK8xaJEjK2OA/dMZejRGF3cDUwhXTo=; b=JJFfc8FgCq5ShM3Hvb3cczVy9A
	UoxcH/D/+xsXhTbGf+43xPeeo5oZPoiMXsAbmu211JrjdtOjzFB88m1VVrBADH82JqHBiuBRdLftP
	UEyZ/HW5mn7xLTIPDY7KUR1t2bqxCI3WRipcOszTMJ/Be0b2egFS1TE9Cz5dCi5sBdFlQ1FHKwXZD
	G3RkAFuZLc8QE4q1M1w+xkrAdXZDr/tPCCVzmzc9gmw3IjDYflKgF2pvgpOUirF8Kj3xn+HUK7rHF
	S6UPm8pQYWZ3P3RG/zanKOSSdjpQQMMrYR1oO67oXHL8Fi9N+r9kkq+VlBm8LH6dTeAEHqSTBRE5a
	IgFinIRw==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:60524 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1s54vt-0000000Fhkb-40MR;
	Thu, 09 May 2024 16:39:42 +0200
Date: Thu, 9 May 2024 15:39:41 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
cc: Helge Kreutzmann <debian@helgefjell.de>, 
    =?ISO-8859-15?Q?Jean-No=EBl_AVILA?= <avila.jn@gmail.com>, 
    git@vger.kernel.org
Subject: Re: i18n of git man pages
In-Reply-To: <xmqqedacxdv1.fsf@gitster.g>
Message-ID: <d130d861-0071-33ef-5d40-9fd703ff97f6@softwolves.pp.se>
References: <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de> <xmqqjzk4xlis.fsf@gitster.g> <ZjvHoykzIo34YJaT@meinfjell.helgefjelltest.de> <xmqqedacxdv1.fsf@gitster.g>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Relay-Host: 185.114.57.50
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

Junio C Hamano:

>> This mentions https://github.com/jnavila/git-manpages-l10n, so I can
>> point our translator to this source.
> That is a good move.
>
> Perhaps we should make the manpage l10n project easier to discover
> on our end to help volunteers.

Should it also be merged into the git.git repository as well, so that 
translation can be synced with the upstream version? The problem with 
an external project is that it is easy to forget about.


Looks like I had cloned the repo and intended to do a Swedish 
translation back in 2019, but never got around to. I guess the lack of 
visibility made me forget all about it.

-- 
\\// Peter - http://www.softwolves.pp.se/
