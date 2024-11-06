Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCB1824A3
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 06:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875477; cv=none; b=ZCSfmfPK45LJsf+zOF6MiMPT3tpb55Dxtq3jIfVkoqEjQ7BLXGQaCdvOGqZcCnwBBKkX+YaOvRGKBxOJ435hav6Ft5gq5qETseUY9Vu67oK6dwdwq55Q6YVXsiJxQgP10w7VnhuOIsBPSYQd8wDyybIrU4s1Okias5TCujO30cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875477; c=relaxed/simple;
	bh=NhzzubYHZNdS8Fknm7VvLWPdHKTYwmh3dpAK93kwjDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGXEMUd2K//kFxzchltnQ3wqIMBEK0UZepKPN5WxrIuQfjsdWBnEQC4n0A5phIBnzFjb0TaZ0QUNyquXvQFk3fFnFYvEtlGGuVmz+LcP2PPRmbOy2A4mHbNCFln3y1Y+XE9Rnec/5qUzUuUpl0PtUTcNFj7PobV1fVpNGyX2IOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Xjwfg069dz5vZd
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 07:44:27 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4XjwfP0N0TzRpKb;
	Wed,  6 Nov 2024 07:44:11 +0100 (CET)
Message-ID: <1483501d-d798-46d6-93f5-f5edaf915e99@kdbg.org>
Date: Wed, 6 Nov 2024 07:44:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] compat/mingw: implement POSIX-style atomic renames
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
 Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1729695349.git.ps@pks.im> <cover.1730042775.git.ps@pks.im>
 <xmqqwmhhow3j.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqwmhhow3j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.11.24 um 04:54 schrieb Junio C Hamano:
> Reviewers, how does this round look to you?  Is this a version you
> folks are comfortable to have in 'next' and later in 'master'?

This round looks fine!

Reviewed-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes

