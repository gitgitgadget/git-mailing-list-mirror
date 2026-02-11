Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F59356A2B
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770849706; cv=none; b=qs75MEnKEr/0w66mhKgWT388/js7W72uKuoPYkvmcTNq18gnIBqNob6+FKgYVFB3OdnIWf16gxCJd6jaDC4Tjdj4KCXpPT4/oDjcS7txoA+AqKtQ5Qw4VGwIkd2q+MQIzM0niiImJVPYQK13raZf4ANQt4Hd7oflzP+TJR6WiTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770849706; c=relaxed/simple;
	bh=iCfThRrh8N1wE66oreycWeAwdlcQbaEocnQ7e9F/8tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhOIAKmZhyYChNB7YhSN4GM6ExaJ+BAkeVEKoTpTgYNBUmgv+yFz8MNnEDyXNH0yinSeWW6jPCI81+kX2JgXi1dK8b5LTTQVYLhcxIaPRjpCxuGb2E6ISuoSW4HAsEGlwYlxJC7xzK7kqD/oNYIZ85fSGl5LkmRtTylzlx1QVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4fBD1n6tsHzRnmQ;
	Wed, 11 Feb 2026 23:41:33 +0100 (CET)
Message-ID: <5975950d-873c-4bc9-90b6-e062021ab5de@kdbg.org>
Date: Wed, 11 Feb 2026 23:41:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
 <20260205093748.GA2177239@coredump.intra.peff.net> <aYSFGG7lCg6Sw8vy@pks.im>
 <aYYLLI2Gb7YlBtKt@pks.im> <xmqqjywjrnx6.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqjywjrnx6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 11.02.26 um 22:05 schrieb Junio C Hamano:
> Patrick Steinhardt <ps@pks.im> writes:
>> On Thu, Feb 05, 2026 at 12:55:04PM +0100, Patrick Steinhardt wrote:
>> The fix has been merged upstream. I've created [1] to verify that the CI
>> now succeeds.
> 
> Hannes, I see that in your tree
> 
>   https://github.com/j6t/gitk/commit/ddae547e3775638c238c11f30120f1e7e763fba8 
> 
> has Patrick's fix.  Is it a good time for me to pull from you, or do
> you want/need to finish any housekeeping tasks like tagging before I
> do?
> 
> This will hopefully help us unblock one of in-flight topics.
Please feel free to pull this commit (it's today's master).

I was pondering whether I want to include more topics in the next pull
request, but I didn't find the time to make up my mind. So, let's take
the fast route for now.

-- Hannes

