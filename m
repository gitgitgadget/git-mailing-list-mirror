Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC871AF4E9
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735039981; cv=none; b=tZwZJUL6I8Ry/PEQVaXMzIJoWXSiwwc3VpOf4Eda1UvY1Pj4ttXNMw7qFRzELMjm+f3FXeyP4injjVB+hzHrjWTIjsKUCJvfwnm13AdIFyy16XAxZxGqHn0q+zzu4YBQ05WFY6ZhOkf7bkFQhbgYHLzEbQN+lrD+bd5OgQZh0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735039981; c=relaxed/simple;
	bh=NhylzfAVO2anjsD1YRH53uYhEUF2IgGnAq/PrP00Irg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=KIZ07vUumu+744hrdT8PUBe6hmnuhsz67/wfyABqaebUqRJpiePKOy1qLdUcQT17w1VrmgunAMk+bBLDIhO77lzm5mGwtmpBObw0evHt47cAK6Nkb/TfOALnt9UM3RbKWkWxvnnTsKCtEa3p7ZDM6spM3adlIuhHGiPBd+tmSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4YHXnH32kHz7QW5X
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 12:32:51 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4YHXn54dNmzRnmS;
	Tue, 24 Dec 2024 12:32:41 +0100 (CET)
Message-ID: <5f046e53-6e58-4c07-bf74-3c47eac8d8f6@kdbg.org>
Date: Tue, 24 Dec 2024 12:32:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2 1/1] gitk: Update Bulgarian translation (327t)
To: Alexander Shopov <ash@kambanaria.org>
References: <af81f74b-b5ef-4557-b929-c56fc3309d29@kdbg.org>
 <20241224101802.13762-4-ash@kambanaria.org>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com
In-Reply-To: <20241224101802.13762-4-ash@kambanaria.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 24.12.24 um 11:17 schrieb Alexander Shopov:
> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> ---
>  po/bg.po | 730 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 385 insertions(+), 345 deletions(-)

Thanks, queued.

-- Hannes

