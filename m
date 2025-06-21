Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04CB191F92
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517781; cv=none; b=PeeCX9U3Ek74TTUFT2CSSCVfGxYek+vWQPUc3fIBkaBuOWTVIghDve+TLphrKg0fPYE/FRJasaTq1GWU4zVcOcIYonbSD7GNjpFChK8Jab2cFPoauKyjg8kHsJGDkwoz/NfDLhxM1EN6wknEnz/V8X9NaNTiwIkYPtLS6SLEEXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517781; c=relaxed/simple;
	bh=HitJdH9kST2KV5p50CBP+jy6A36DcLWVvGQGxheSOHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kebab8il6hKOjT+2DlbReudEP9dJ6CaRxuva6vk3VkKXRYLzeMvQed37bndfkVuSjUXg2+sOG+horkCyxqI5QXkz64LmrQdJ5EjJw4Q+vvnSlOLk+CVRjO0UPY8mPLGmWmNGBLtvcwZIzgwJmr/aKQXXtqkLPYM3LmpQNlYVviA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4bPcqM2pTqzRpKJ;
	Sat, 21 Jun 2025 16:56:15 +0200 (CEST)
Message-ID: <682f5bf6-74b9-4a4f-a667-79253cc6dcbc@kdbg.org>
Date: Sat, 21 Jun 2025 16:56:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] git-gui i18n: Updated Bulgarian translation (578t)
Content-Language: en-US
To: Alexander Shopov <ash@kambanaria.org>
Cc: worldhello.net@gmail.com, gitster@pobox.com, git@vger.kernel.org
References: <20250615122631.41988-3-ash@kambanaria.org>
 <20250615122631.41988-4-ash@kambanaria.org>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250615122631.41988-4-ash@kambanaria.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 15.06.25 um 14:26 schrieb Alexander Shopov:
> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> ---
>  po/bg.po | 3608 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 1787 insertions(+), 1821 deletions(-)

Thanks, queued.

-- Hannes

