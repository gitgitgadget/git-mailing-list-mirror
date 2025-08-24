Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E11862
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756073071; cv=none; b=DeDfO7AtGRxk/cDlWofhI7/45qcPWroAgbS14ZQQP2ZYqoDkK9Rp1GWYbdkUrUcPGKGIp2JQ70MjHeTI0eVSMhPEsSumMLqFBclvsyIdBL9alkyfa5o5dKnt5TL74XbdOZT1viCi+f6aKUoO6VACaKWvuLMgDaFQuEr1qmYK5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756073071; c=relaxed/simple;
	bh=u1VSYE8RFGwpvLVD0XWbux1pW5ck6ji6DupNd2lPQ+c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CnKf8DQUowaVja8fEANY7MAYoASQJ7cMah+1SAxHKdPew2Gps0JesXB4+TqU7By4kHGsUjbiD+xI07OoNUAev9dHyPBogkxrokP7ctWtiHxnfs2goGdSp0M5IcOMxBHXxUuz3FV+FOJ3LliBvBFsa/IuPoYodCCdKOTGnwMkHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Y62P37kd; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Y62P37kd"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c97FB1R8czlgqTp;
	Sun, 24 Aug 2025 22:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id:received:received; s=mr01; t=1756072925; x=
	1758664926; bh=u1VSYE8RFGwpvLVD0XWbux1pW5ck6ji6DupNd2lPQ+c=; b=Y
	62P37kdGe0pusOVAHRFHgLwYUUv0hFbYiiL4lBZXU0Stude5ai1GAxV3D9qNHCOp
	JpS31iFyHVrd3DvtaZhAUGf5rtgb4c/T+7wrDlqC51sDugEDzJ63cgIpYDhqMpdd
	orReWiUQrAvF26H4gloC2RK2nHEBLQ6AX46x0OgRsynK9TkT9gjkhxCjXAADd7UM
	vKUDyOfQVTYcULvUD2CIX3YhKyGXiB32pdh2PFdvyPiqV6TIwPwXddsT20HiXT3A
	4EndX7fv/3ZKbE1GHrEk1mPskLSwagigNjBAGBZbjlh/P+fvLHtmv625od8EdVWV
	PgvpG/PtYKbeh/HmE+Wfw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZHMLHTpbR2m9; Sun, 24 Aug 2025 22:02:05 +0000 (UTC)
Received: from [192.168.1.12] (c-24-6-146-61.hsd1.ca.comcast.net [24.6.146.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: davidoff@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c97F640JczlnfxF;
	Sun, 24 Aug 2025 22:01:59 +0000 (UTC)
Message-ID: <9fcbfcc4-79f9-421f-b9a4-dc455f7db485@acm.org>
Date: Sun, 24 Aug 2025 15:01:58 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Monte Davidoff <davidoff@acm.org>
Subject: Still use git whatchanged
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I still use "git whatchanged".

This is regarding the removal nomination message in git 2.51.0.

Thanks,
Monte

