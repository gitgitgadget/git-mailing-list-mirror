Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF223A29
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710916575; cv=none; b=VHGJJ8+LVaMFqZHnD04ghKbmEbvoiVdMyQVv+qBPGC202Ai/hNzKNBJEIbWMk0yYbJ5tjMiaWX7ZZm3AHs6LbkQ9pOxolw1Hv0mynuYQMETBs8YI4FxENQ3nkFL8JRymRHHsZNNMKWNb+w9qEKDqE/HdFqEE+ZfI1HdJfig2AoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710916575; c=relaxed/simple;
	bh=xv+etGFLbl/uCKAp4Awliijr4j+7MeLklfYXRQo/sZA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ISXx6T6+dsYecwcJcNvrid+USg2uyAoISofTLDaxEMx/kBAkn7bJX9LE3Nn8MErfprt/sWObcd7DXSD1Omqp56ehOOU71YYfr4CZEqFv0F9QmDHxAc/4IhvioS9lsSK+3R+oN9IvMyK28L4aJOWg4ld7kb8bbyZOaREurWW5b1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ekBYKwCN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ekBYKwCN"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710916568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LD8d+u3kmcpBKPKSGeU63Sx1KU5vccddJupmgndHAE0=;
	b=ekBYKwCNDYPk9A/tcSLjKRXL499Rh9txH1pMmlXwzj3ZIkfR597KQGcQv9l/ppL/hCmOYY
	y3R9TkmjF5wk3RupgiiS5xuS/rTRkvVlV4gWcX4i4WPXNSt042TbkzuvZYCdSByispcmE9
	0ui1iXhmvbAyqgmYbQBTD907MYNCoeVH9YbG4AaZqli9C/3X0n21LBy2mz88R8aIvgfbfS
	MVR9ls8OYls94K20d6cM1A2qTjdR3Parx+bfrfBKc9TAnCYIe1Bkkw2qmmGszQIiGhEtCD
	8vfJPs96vN7xC3SwGGNPS0htCyIgsX8sb2olUnJX6YFuPmu0D8mg0shKCB3Ahg==
Date: Wed, 20 Mar 2024 07:36:07 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, rsbecker@nexbridge.com, github@seichter.de,
 sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/4] config: minor addition of whitespace
In-Reply-To: <xmqq5xxhl8gs.fsf@gitster.g>
References: <cover.1710800549.git.dsimic@manjaro.org>
 <2161355e5c9a8ca0c8c0d3e5115a8843be1f4111.1710800549.git.dsimic@manjaro.org>
 <xmqq5xxhl8gs.fsf@gitster.g>
Message-ID: <60422ac2db78435843f11f2ec8ddaff2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-20 07:32, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>  		if (c == '"') {
>> -			quote = 1-quote;
>> +			quote = 1 - quote;
>>  			continue;
> 
> Obviously correct.  Will queue.

Thanks.
