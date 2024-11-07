Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973D8BEC
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997830; cv=none; b=G4VhufBTbXRt3SUzUZVkKonqlFtXbzFbQYLnbmQnlrj82fAr9b04rcf7rvhCpuqKRWUT95hNKGmWUudMgjLCn7C4vVgv7rWcE2F7L7sII95Uw/GFo9ZGhgHoQJ0+1Tnyg0WcSff3UubSUOVxrR2pnf90hDO4H9+u55wmg5mjiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997830; c=relaxed/simple;
	bh=Rzyof1evT2LxApqwpa2ejzXb5cGJFPfZSlpcsIvtK7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qs8YPTV+Qxfu77rIYCWF8Qqn9P3BJMnad/jjn3ZGXZXPxwmsuj9Qz8qTTD8fIwj5ftaqSz7JiJSlrU9A5iIPVan4o21Bc6tlBSu6Xluhb/uC+LW/oNy6cevgk4jKyIdNKOq9FeIXfDX9/kVUqcfF9+el+QA1Z7cXkEiJhbFW+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Xknvc5YMxz5vW9
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 17:43:40 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4XknvQ6KY9zRnmF;
	Thu,  7 Nov 2024 17:43:29 +0100 (CET)
Message-ID: <8228ce55-0603-4cc2-9cea-d65a3caa5ef0@kdbg.org>
Date: Thu, 7 Nov 2024 17:43:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] git gui: add directly calling merge tool from
 configuration
Content-Language: en-US
To: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 ToBoMi via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1773.v4.git.1726064619705.gitgitgadget@gmail.com>
 <pull.1773.v5.git.1726136277300.gitgitgadget@gmail.com>
 <2ee3a148-23eb-48cb-8e10-551437fb03d3@kdbg.org>
 <AS2PR08MB8288A8DC805BF4FFB67B1709E1602@AS2PR08MB8288.eurprd08.prod.outlook.com>
 <AS2PR08MB828858E352C40E3488B1F5D0E15C2@AS2PR08MB8288.eurprd08.prod.outlook.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <AS2PR08MB828858E352C40E3488B1F5D0E15C2@AS2PR08MB8288.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.11.24 um 15:16 schrieb tobias.boesch@miele.com:
> The documentation (https://git-scm.com/docs/ 
> MyFirstContribution#after-approval) says that my "change will be 
> placed into seen fairly early on by the maintainer while it is still 
> in the review process".
This document is only about contributions to git.git. Git-GUI has its
own repository and workflow.

> Since I cannot find it in seen or anywhere else, I wonder if there
> is something wrong, if it just takes a little longer than I expected
> it to be merged or if this change is merged somewhere else.
There is nothing wrong, except that it's on me now to submit a pull
request to the Git maintainer. This should happen in the next days.

-- Hannes

