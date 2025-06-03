Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623918E1F
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985368; cv=none; b=j2GvmTrvOrAN76QoCfPjIDdoHdPDqbGGb4rNiir2gLdqCQvSHhmEbcI+HTA3D65b7QSV5M/qJwAr1jt9J98eNgawd9hJ7zlPTRrE5i+82hRrrMGaVXWnM4398SaRdE1Ucjng/Kw03F1RJvk+dDeUBxfVWFDkHqC37myRyN8PkIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985368; c=relaxed/simple;
	bh=z6oG9DNwXtSTniWKKXqb1n1cKO+AgN/TMHfDzWw7YTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1bXgCR4ER52f11zuKqp9sCcbRL8E/0e0wUGM6TGlWaEpx4iVcod8BtTjHXXyQrXPPnGwMbQkZ04LZKYTwWnCd0B9YFbVqAiGyhpAHKf55bYVOLdrQCfvwjQm/CtQPqyJXBa4QTGyjTA6ZSsXZOPGk1wb85Mzh+fVwKN/QGE9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4bBk5k400dzRnD3;
	Tue,  3 Jun 2025 23:15:54 +0200 (CEST)
Message-ID: <61ee9fac-303e-435d-ab0f-8338c23f2d5d@kdbg.org>
Date: Tue, 3 Jun 2025 23:15:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] userdiff: add support for R programming language
To: Junio C Hamano <gitster@pobox.com>,
 Rodrigo Carvalho <rodrigorsdc@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <20250525210236.116342-1-rodrigorsdc@gmail.com>
 <20250529221805.97036-1-rodrigorsdc@gmail.com> <xmqq8qm8k7p8.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq8qm8k7p8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 03.06.25 um 20:20 schrieb Junio C Hamano:
> Rodrigo Carvalho <rodrigorsdc@gmail.com> writes:
> 
>> The patch appends userdiff.c file in order to support R programming
>> language function header. This will be useful for those who use Git
>> for versioning .R files.
>>
>> Also, add three userdiff tests for R programming language
>> files. These files define simple function and nested function,
>> with and without indentation.
>>
>> Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
>> ---
>> Changes in v2:
>> - Add support for function defined by '='
>> - Replace word regex to '[^ \t']
>> - Add new test that handles with nested function
> 
> Sorry, but this fell of the radar.
> 
> It seems all the reviewer comments on the previous round have been
> addressed.  If everybody is happy with this version, let's merge it
> down to 'next', for the next cycle.
> 
> Thanks.

Sorry for being slow. This round looks good to me, too.

-- Hannes

