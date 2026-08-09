Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA435C69D
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259085; cv=none; b=HtPHcOs67230VzMjH0p5fVcH8k5InrM8AFUkirfy+/XAl0BJlWfdM60Ar8jDWenXd1qDUqmQfJjkO/XBHIV1nQtOOmOAHYY4AiBjns4m+quLvW/rYx9LLhPiO2mOtKqZcyHvjgtIjlHip72a6lesH+eQb/eG6mDanKtji2++G+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259085; c=relaxed/simple;
	bh=q4iJrCDvmTda9HMqZHQd5jrAaqD1nIAGAAjXZktlmpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2j+6t8qtLJL5hcryPfPz3tsKOKZusLXiENkf2xWxmmJJAmKHKrPOi+CT/dPYVJbC9phO9Nw1rKVMuWeUF42CTSjMcDQ+RF8Bq9jspI+dTZwVFCcLvHQXy7HlRTg58GYh7LTjToCclczBvORLtzPx8w6D9jKSEK/mWLjCXLJBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (unknown [89.144.223.124])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4hHpm117b8zRpWV;
	Sun,  9 Aug 2026 09:04:32 +0200 (CEST)
Message-ID: <27207bb8-96ca-4442-a0d1-81340d5558ee@kdbg.org>
Date: Sun, 9 Aug 2026 09:04:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] gitk: avoid constructing dialog titles from text
 pieces
To: Junio C Hamano <gitster@pobox.com>
Cc: mark <mlevedahl@gmail.com>,
 Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <1e1bcfaf5bbe66fac364d5b7d3a7ebdc5f37531c.1785998419.git.gitgitgadget@gmail.com>
 <f25e5fe8-cf6a-4d87-9c46-bf5b7490434d@gmail.com>
 <b1d397e1-ab2d-439e-ba45-0ade2c216afa@kdbg.org> <xmqqecg8bmjk.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqecg8bmjk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 08.08.26 um 18:32 schrieb Junio C Hamano:
> Both lacking "color" is not a problem because it is easy to see that
> this entire thing is about "color" from the context (like these
> appear in "Color" menu or something)?
Yes. The page's title is "Color", and there is a section title on the
page that mentions "Color" as well.

-- Hannes

