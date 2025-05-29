Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077721A451
	for <git@vger.kernel.org>; Thu, 29 May 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748510534; cv=none; b=f2pJMqqYG5o28Xw/UZdeYxadj+rI8u2pwu4mYU0Fo1J5Y3T+J2IyR2qc3ZC4STN0emJ7uJT42REwckPQtsazdBLkoWxMp+Dg2NVN+kH0m8Nzw4GsH1gbtzP3V8mQUyBV4hwzjEKVaXuZRfPPQZlfMkvPDU6DLSr3zJ8zIrcMaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748510534; c=relaxed/simple;
	bh=w8LNs2egUk45VTD6YGaSnQzaIj50HYHCI7f/coXbESk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uQ5bQjBD61YM2kl0JwhWvdrU2HEE/2Fwc/GAF2SfgAAYC1GSSBKYX10qEgRrP85LfJG8MbmOrb6jPlNa1FibZVHPx31cLNiKH7XhIGFMRxcujJXxd6svl2nL5V9RwBWsEYwud77m8Lu3mSRDGbN3cWzQ6F3jxgWvsteXLMItK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4b7LVN4DpHzRnlJ;
	Thu, 29 May 2025 11:22:04 +0200 (CEST)
Message-ID: <7557e8f2-2b06-4fd9-a32b-cd13b81d6ff3@kdbg.org>
Date: Thu, 29 May 2025 11:22:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] gitk: MacOS preferences fix, minor fixes
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
References: <7c7779c1-32a7-4a6b-a193-be516e620233@kdbg.org>
In-Reply-To: <7c7779c1-32a7-4a6b-a193-be516e620233@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Small correction, just for posterity: the preferences fix is this one
and affects all platforms, not just MacOS.

Am 29.05.25 um 10:07 schrieb Johannes Sixt:
> YOKOTA Hiroshi (1):
>       gitk: Legacy widgets doesn't have combobox

