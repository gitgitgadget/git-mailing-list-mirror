Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D6383
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734975083; cv=none; b=AODOb9SoT2qYQqGzCXNOzEPq5djbyYWXZahyK59V+z5cazNBJD1Y/k08iNAdoUuQacWXxkglQybAL3bSAOoT0tTJZJ5NuXjIgDI1I0r1eW4cun7DjYdaGkysuhNt3W7NQb0Hd0+0tCIqDP9syVbCdswC1zNaqT3gutzvWTBPGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734975083; c=relaxed/simple;
	bh=7+ZQ8bqdrKCepISRby9HxyAInyeGHYsXiezTxhOKc6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=hBsXn8u/ki1w8Nfo1xcq/j3rRkmDKoDcJ3pTGDDN3G79K1w3V3Fkq27k+/WaY6pITWxd64ZTTqYQubwCq+0oWNyo/RiX7wl7iS0rYA3SBIMgqG/5I+P7pdcuk1n9LJHFPjG8Vn2+vcA+nT716dpDEuZ7z3cwTcVK+Wsa/yfXiZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4YH4nM4LX8zRnmP;
	Mon, 23 Dec 2024 18:31:19 +0100 (CET)
Message-ID: <af81f74b-b5ef-4557-b929-c56fc3309d29@kdbg.org>
Date: Mon, 23 Dec 2024 18:31:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] gitk: Update Bulgarian translation (323t)
Content-Language: en-US
To: Alexander Shopov <ash@kambanaria.org>
References: <20241223133918.25133-3-ash@kambanaria.org>
 <20241223133918.25133-4-ash@kambanaria.org>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com,
 paulus@ozlabs.org
In-Reply-To: <20241223133918.25133-4-ash@kambanaria.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 23.12.24 um 14:39 schrieb Alexander Shopov:
> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> ---
>  po/bg.po | 696 ++++++++++++++++++++++++++++---------------------------
>  1 file changed, 360 insertions(+), 336 deletions(-)

> -#: gitk:2203 gitk:8681
> +#: gitk:2206 gitk:8739
>  msgid "SHA1 ID:"
>  msgstr "SHA1:"

> -#: gitk:8700
> +#: gitk:8758
>  #, tcl-format
>  msgid "Short SHA1 id %s is ambiguous"
>  msgstr "Съкратената сума по SHA1 %s не е еднозначна"

> -#: gitk:8717
> +#: gitk:8775
>  #, tcl-format
>  msgid "SHA1 id %s is not known"
>  msgstr "Непозната сума по SHA1 %s"

> -#: gitk:11508
> +#: gitk:11571
>  msgid "Auto-select SHA1 (length)"
>  msgstr "Автоматично избиране на SHA1 (дължина)"

These strings are no longer in the code: "SHA1" has been replaced by
"commit ID".

I am unfamiliar with the translation workflow. What am I expected to do
so that you can make translations of the current state?

-- Hannes

