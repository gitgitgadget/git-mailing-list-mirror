Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF0188733
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734974347; cv=none; b=Lg9Ksho1JfwoG8mSKkrmUxGTJUX3WLApmEG4Z8mjg+uQcDOUoSTXauV0bC4jHs+BxKH1n6XsPBbs+fGJbubob4HpnC5hKW8jEgVPGEslSl7d6CWt7/9gbWWwFzyfE0NEwug9c7kRMRPjN+rS9/3onKEF6hZAERA1E36mGCBeswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734974347; c=relaxed/simple;
	bh=av2coKk9TqBhfYDbvNw4KQQAjwxySv4HD+7febSH/QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=UDTtfN3H0b8Sxl/D5QHOB0ZJSYt247V8b3Vdaxso0ZA6jM6EIQMoIYAlpvKYzpOfFZrg31GDhLf+4IBY4Mr0Vxd7cZT1lDrmHDIFxmTXCE/btR1zhjpAsmRsmj1aYMgnMuIMbyC/WAxDNeDfWPk7rjW6GIRox9ERX5jYC5JKDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4YH4W54d4QzRnmN;
	Mon, 23 Dec 2024 18:18:57 +0100 (CET)
Message-ID: <8966f6fe-98d6-4c3c-81da-4ea1a1fa1ba8@kdbg.org>
Date: Mon, 23 Dec 2024 18:18:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] git-gui i18n: Updated Bulgarian translation (579t)
To: Alexander Shopov <ash@kambanaria.org>
References: <20241222200707.98738-3-ash@kambanaria.org>
 <20241222200707.98738-4-ash@kambanaria.org>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, worldhello.net@gmail.com, gitster@pobox.com
In-Reply-To: <20241222200707.98738-4-ash@kambanaria.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 22.12.24 um 21:07 schrieb Alexander Shopov:
>  po/bg.po | 3721 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 1890 insertions(+), 1831 deletions(-)

Thanks, I've picked up this update.

-- Hannes

