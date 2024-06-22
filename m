Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E2537F8
	for <git@vger.kernel.org>; Sat, 22 Jun 2024 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719040423; cv=none; b=GjvypmsI296TgrnqxKtwCakWM3Dxm5lQu3jHtEsul4qllTG0CDwEfByGKu/FKEkxA9j1dDiWMpqgkqrOaiOdHbPu/aMSDPgWx01aIhJzFK47EliU8Wl1ZuOk96fKDA8eA7cXxSCgXEvgdN2qFR04uFwn45ZrLYiuwFmTR0eulMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719040423; c=relaxed/simple;
	bh=hgLdD6l1QnUgQJG0N1JmDcNIV49xlgQbki+vys2uV2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W03Y1MdLJlVdS68egB3+ixScvzdFnsW3aeuiLlKkLe1m5PjV5UcuwgRYMCXWS6KUTLglhxY3Gznmd4CbGU6SH4uSYvIyuJ0XB9HRonWMdbYvrFoJkjssA4h+nYfFLYHdLN23csRtunQ0y+3Rm708LHFx3CObP9Wz1K9WhP7x4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4W5lnb2D40z5wFT
	for <git@vger.kernel.org>; Sat, 22 Jun 2024 09:13:39 +0200 (CEST)
Received: from [192.168.0.105] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4W5lnQ3yT4zRnmS;
	Sat, 22 Jun 2024 09:13:30 +0200 (CEST)
Message-ID: <22755bd4-7219-49e4-9e8f-ac9663291fcd@kdbg.org>
Date: Sat, 22 Jun 2024 09:13:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-gui: Visualize * History does nothing on macOS
Content-Language: en-US
To: Stefan Haller <lists@haller-berlin.de>
Cc: Ilya Kulakov <kulakov.ilya@gmail.com>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
References: <38A18180-3CC9-411B-B5D3-36C5C32B6EE9@gmail.com>
 <CAPig+cS1o5bqK2Ph1fFt2wi6QaOO2=83xwoqoTLifA6z3NssXA@mail.gmail.com>
 <41408b88-2938-4112-a02c-53876e20f5b1@haller-berlin.de>
 <CAPig+cTaBxoJbsVsZLYLZueZpSkmt2zRJzgE=HOO30FvxpUUnA@mail.gmail.com>
 <8fcf1aa4-6c80-4d66-ba95-0cbbfd67540a@haller-berlin.de>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <8fcf1aa4-6c80-4d66-ba95-0cbbfd67540a@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.06.24 um 08:12 schrieb Stefan Haller:
> In 2022, Paul said [1] that he would be willing to pass maintainership
> to somebody else. Johannes, now that you volunteered to take on git-gui,
> could you imagine doing the same for gitk? This would be awesome.

I can imagine it, but I'm not yet offering to do so, since I haven't
even evolved a git-gui workflow.

-- Hannes

