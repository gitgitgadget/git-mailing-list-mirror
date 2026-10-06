Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD54734C9
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298174; cv=none; b=SiZEvws/zyypxWLkaaupUAt9D8l6bPL2RDboRYDuzSGKQ6IqT90KjQeGAuuJE9DYTPV79JNU/XkmBaMCJzhjCObdQn/bBYClMLzVHm/As3cljwYMFDSsaB8lP80U9umzE752wnp7AoIxy/zjV0j8XXlhdrM0fVONv005lTyDz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298174; c=relaxed/simple;
	bh=55TogaVW/eYtERey1kYuuTcvq1K9X+6h1mokxvKF65k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WpYUnUyV9G0+DZ6of2tSN8vW8qwDO25Qlht/2GA2ZdMf9zR1yrbZP9xQmy0xhZzAG1NapULPgI3OaxfBFOA75lJOiJSPecaDDEBNaZOwSPRzJ5MmH5dmIqLCWW9OtKQhBuQFqEFOxpS14DCLtm86wWspskXe6HlhmyNEsudAXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=albellus.de; spf=pass smtp.mailfrom=albellus.de; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=albellus.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=albellus.de
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MkHd3-1wpnLF19In-00d6bC for
 <git@vger.kernel.org>; Tue, 06 Oct 2026 16:49:28 +0200
Message-ID: <164ef290-463c-4a7a-92d4-00a56aab71be@albellus.de>
Date: Tue, 6 Oct 2026 16:49:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: git@vger.kernel.org
From: Mae Eckert <mae.eckert@albellus.de>
Subject: Hash function transition page links to hijacked domain
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZobMZV61XNuKussk3qDB09/iarUceHyo9MGSggDT6zq7orqZdUn
 pFAS5rpPtMmTLL9BvjVK8mtXRxROs+4HHH2GmAIoCYaIX1ldxWktd5w05650BXxLSjjTvbd
 pmfUoz1/a+crmcJy8EXws/tEChzqSm878dCjgZE/IAXt8BaMdd74a5jXjZSFcoYESiBupQW
 OnfNEEV+4VftiYgbfBRHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6HFKEeZs/4U=;USrKINDIV1wGxZe4y0fbRO4W1OC
 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

Hello!

I'm a mortal so I don't know how to contribute this fix myself, so I 
figured this might be the right place to ask.

https://git-scm.com/docs/hash-function-transition (2.55.0) links to 
https://shattered.io (which used to be the SHA-1 paper), but now it's 
some cybersecurity editorial thing trying to ride off the SEO I assume.

web.archive.org caught the domain being parked in May 03 2026 at 
https://web.archive.org/web/20260503225438/https://shattered.io/

The last good snapshot seems to be at 
https://web.archive.org/web/20260207211148/https://shattered.io/, the 
link should be swapped out.

Cheers,

Mae

