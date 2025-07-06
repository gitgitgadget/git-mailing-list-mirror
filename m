Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC65749C
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802163; cv=none; b=UNZH/LFVCnPQMmrEoTC9P+MPqXJnPsVlstnTdG3McxZyTO7WNJduAqpq46EGfL5uOxGP3zT6XV51LBRzlUtHktcLt6RfrqYInt0dHt++khqE1/SO3hNDMoKpuuHoSTzjYiTQMv7814ojCJX38ErLbaF9G7P7zZ0o8T52i9oiaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802163; c=relaxed/simple;
	bh=wQKES5He7XjKl2zyk1LOS4qULvTOnzKTKNOpnEFzVRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q8smLL1lFYdB7dPxhdJjBxCeoobL5kEhbJzgeqLSw7oC19accyTo5QyA28jRrbqZWifyta8N/ycV2wLAgKQnkd5ca/57YvbmruDIAtrOKnT77g2s1/iEYmVPUhnIEiVqrUmhZPvKvT/cknWby//qvB/hpfwxfcQ58skqbsup2nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4bZlps5Ccsz1r5T0;
	Sun,  6 Jul 2025 13:42:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4bZlps4sdtz1qqlW;
	Sun,  6 Jul 2025 13:42:29 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id zFLOWaa4g0Oh; Sun,  6 Jul 2025 13:42:20 +0200 (CEST)
X-Auth-Info: 01frKSrk23P3J1dM6VPYlpHpW+zlKz298+W26sjndMz+8YQYzOwO+KV8aL0gCRvx
Received: from igel.home (aftr-82-135-83-180.dynamic.mnet-online.de [82.135.83.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sun,  6 Jul 2025 13:42:20 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id E6F8D2C1F4E; Sun,  6 Jul 2025 13:42:19 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: git@vger.kernel.org
Subject: Re: How to restrict command =?utf-8?B?4oCcZ2l0IGdyZXDigJ0=?= to the
 first search result
 per file?
In-Reply-To: <fb74577d-f7b8-4fde-ab5a-5283e70b8258@web.de> (Markus Elfring's
	message of "Sun, 6 Jul 2025 13:28:47 +0200")
References: <fb74577d-f7b8-4fde-ab5a-5283e70b8258@web.de>
Date: Sun, 06 Jul 2025 13:42:19 +0200
Message-ID: <87wm8lo89w.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Jul 06 2025, Markus Elfring wrote:

> File contents can be searched also by the means of the program call “git grep”.
> Would you become interested to find specified items only once in each file
> (instead of multiple times)?

Does "git grep -l" suit your needs?

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
