Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6C3424D73
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649759; cv=none; b=Xyx23qxRIGWjJRxhga8yl8sysyo//am5VbFjdlEDxVg3uuo3OWSyzfRW1RQLqW6UfzlR/Ws/BkLwfrvc2HA1oCR478agDRRj+e/BqrQdGbxKikkHRhZNiZTe43zatgU/PAtMjoxKP7UA0wT8faTUL8PSgbpm5lHkhCUOTEWCEdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649759; c=relaxed/simple;
	bh=z8OU0yMudnoGyTO8coEhVc4b2Qr4NPrNlZSYR5aPEOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=KACmbGBBd+ML9vBLfju9eHQ/V6BtXGWwNFUbiqWNLA0ckCj4LdRBNnOYRHDxwCExGzuGjfSjOkeELvhuwv/nItVp4VoRQksr5/Et1gO1w+JzWiwMJ5AZ9Pl/c1OztnLgcwMnkm0qbdlbLpvgNhArrJ4ODRUgWQ1t+Ni81aGBiAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.103] (unknown [89.144.223.124])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4hLbDz3hcDzRnlT;
	Thu, 13 Aug 2026 21:35:47 +0200 (CEST)
Message-ID: <d6754ded-89f6-48e9-9755-24c45c90845f@kdbg.org>
Date: Thu, 13 Aug 2026 21:35:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] gitk: use more natural language for labels of
 color preferences
To: Mark Levedahl <mlevedahl@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
 <45d5b05281cd4f3f43290d128d631a47975225f3.1786540582.git.gitgitgadget@gmail.com>
 <787b9472-d9ac-4d1f-814c-f7be9318ff55@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
In-Reply-To: <787b9472-d9ac-4d1f-814c-f7be9318ff55@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.08.26 um 19:00 schrieb Mark Levedahl:
> On 8/12/26 9:16 AM, Johannes Sixt via GitGitGadget wrote:
>>          markbg      markbgcolor {} \
>> -                    [mc "Marked line bg"] \
>> +                    [mc "Marked line background"] \
>>                      [mc "marked line background"] \
>>
> 
> Not a new issue, but "marked line" is not a good description. What this actually controls
> is the background color of commit message text found by search criteria in the gui, not
> lines of text, and (as far as I can tell) never any text found in the patch text.
Actually, it is the background color of lines found via "Show origin of
this line" in the diff panel.

When reading this code for the first time, I thought it has to do with
the "Mark this commit" in the commit list, but it doesn't.

-- Hannes

