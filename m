Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971532B130
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786183229; cv=none; b=FsP+XKWiGKFEOSdJ3L22rqe32QgDmCMfkm3OFysnhIRN9x0yTI7vJEayF/Mt7ustnjPkeRI5uzZYckxv+6k0pN1yB0GHorx/4idpR059Qu0ilHI1JzD2ijPRsIy+Ofl/vgSDVg2McC+uV4V4ooyBKY2Z+k7DUpyXyEdsru22Eo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786183229; c=relaxed/simple;
	bh=WVRTXXnSLnwDe0YSNeOA/kyc+o1OiZ08B4DBEy0Ub/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=fHdKA2ZCSeluOGbmNKynCTMe3NCnEYXnAPIPWRIPcjy3349Kb4k/H8IyIiQ0FNKSx9gWsC3jPzIDSyIKBW2NsazClK8WqYNuLinfSGkKE2SGW+2jbNECkSLK/spjs5eW82U+J20WHnvZCLnrP37ncYUsVSnKPuSzGlAXFhpdSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (unknown [89.144.223.124])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4hHGjH0828zRnD7;
	Sat,  8 Aug 2026 12:00:18 +0200 (CEST)
Message-ID: <b1d397e1-ab2d-439e-ba45-0ade2c216afa@kdbg.org>
Date: Sat, 8 Aug 2026 12:00:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] gitk: avoid constructing dialog titles from text
 pieces
Content-Language: en-US
To: mark <mlevedahl@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <1e1bcfaf5bbe66fac364d5b7d3a7ebdc5f37531c.1785998419.git.gitgitgadget@gmail.com>
 <f25e5fe8-cf6a-4d87-9c46-bf5b7490434d@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
In-Reply-To: <f25e5fe8-cf6a-4d87-9c46-bf5b7490434d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.08.26 um 16:37 schrieb mark:
> This with the prior patch should help translation due to use of more common idioms and
> complete phrases rather than jargon. Good.

"Complete phrases" and "jargon" are words I need for the commit
messages! Thank you :-)

Now, with a fresh eye, I see that we have text like this:

	Diff: old lines background

This looks more like an assemblement of words and jargon than a phrase
in natural language. Any suggestions for improvement? How about

	Background of old lines in diffs

Sounds a bit clumsy.

(In this case I prefer to say "diffs" rather than e.g. "patch text",
because we are looking at differences between versions, "diffs", and not
patches. Also, we already have "diff" in multiple other places in the UI.)

-- Hannes

