Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC421516C
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738739727; cv=none; b=Rw757URLwfZI866+xl6lNnR8eswtIqzDx+C9VioRIShoLDa+9kI6H5UJiEXeEfCz9aUynbuLpFpBwD4mmyyGpPLzOCetDrPGHKW/eoTnDHTC5ap29H4M24IEqDcfFLrFIjwmCFM7QiEHerKRgbbUtSHemvoUDVAGAFNnVhu7aeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738739727; c=relaxed/simple;
	bh=qk+0Eeh32vO4yljGwRi1ULxcJ5t3XxH4Hf0mVPZNs0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVbFPs7yvWX5vTZMUdlRbV/hrruljCA/yf6plAgj4z4hb+AuM0xxouwATeSIyeVrt68EHk3mneC37ZoFrK6t5BkJLN8cWUi2Ib2NdpMAUVX4fu5mE3hWO9NTd/Pa3CrVXeSHzrGiSXiIe+gzT6Jid+HkPQHg0Abeo2/do7IIzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Yns2G3x7fz7Qb7t
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 08:15:18 +0100 (CET)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Yns2600HZzRnlK;
	Wed,  5 Feb 2025 08:15:09 +0100 (CET)
Message-ID: <b2038430-62dc-41fa-86c2-c0a14bd25e0f@kdbg.org>
Date: Wed, 5 Feb 2025 08:15:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] diff: --patch{-modifies,grep} arg names for -S and
 -G
Content-Language: en-US
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <xmqqserjsfrq.fsf@gitster.g>
 <20250205022422.2019929-2-illia.bobyr@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250205022422.2019929-2-illia.bobyr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.02.25 um 03:24 schrieb Illia Bobyr:
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 47a7c1..52516 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk

Please exclude this part related to gitk from this submission and send a
follow-up patch with only this part. The subject line should then start
with "gitk:".

-- Hannes

