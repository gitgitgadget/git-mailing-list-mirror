Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA91DA31D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467890; cv=none; b=lgkTm+KjiEx59qGcGpGEcJWIG1hZCEqO8ie4nXmt9LKYUVHsN1ZsBVH+QLhfIzzG7/9ysHxSwVr27BJJ/U9/U/Ho9um0pgLUXO8+NDnCSApsnhptwOvNvf9mn9ASvCrmAf2ldKVANArQJIpCnE5uBXWjQrQ9YZAYMj/QET1rlM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467890; c=relaxed/simple;
	bh=K2Osv4pR3YlBKWY5e3K11VCWtilo4kDVkTjn1V1FviE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iu30rVq2A0wxSS07lU5STnvHlVfKgoDc0humJnsCG4FKELJpMk9xOkSpm7tjU6Vl09sqAg2+g9vCgi/zGZY77U9PPzXc7CmFHd5bbYIPatBoWcCCSKEaLkdOvUvRWMFdlTjJ/fFAUQT73bFVHbQ8QrDE0O6PWXTz+oA6KByCu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4WzSpk09KxzRnmS;
	Wed,  4 Sep 2024 18:38:04 +0200 (CEST)
Message-ID: <562614e4-5384-4220-896a-20b3f79771bd@kdbg.org>
Date: Wed, 4 Sep 2024 18:38:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IGBnaXQgZmV0Y2ggLS1yZWZtYXA9PHJlZnNwZWM+4oCmIDxyZXBv?=
 =?UTF-8?Q?sitory=3E_=3Crefspec=3E=E2=80=A6_=60_providing_NON-empty_=3Crefsp?=
 =?UTF-8?Q?ec=3E_to_the_--refmap_ALSO_causes_Git_to_ignore_the_configured_re?=
 =?UTF-8?Q?fspecs?=
Content-Language: en-US
To: Han Jiang <jhcarl0814@gmail.com>
Cc: git@vger.kernel.org
References: <CANrWfmSe0ekbRR9VsX8jALWQQVdhDv-2WTSm47jHTiV9-Z7-pg@mail.gmail.com>
 <a33a73f7-e6dd-4f97-a635-c6c5dfcadeb1@kdbg.org>
 <CANrWfmRdz1Xxud=f0GWrc=nURV2xZU8Wm=8u2X+W4tL4d-yeTg@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CANrWfmRdz1Xxud=f0GWrc=nURV2xZU8Wm=8u2X+W4tL4d-yeTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 04.09.24 um 13:12 schrieb Han Jiang:
> 1. If the doc says "providing an empty <refspec> to the --refmap
> option causes Git to ignore the configured refspecs and rely entirely
> on the refspecs supplied as command-line arguments" then it's
> reasonable to guess that "providing a non-empty <refspec> will not do
> those".

Fair enough. But then in section "Configured Remote-tracking Branches"
it is said that "The latter use of the remote.<repository>.fetch values
can be overridden by giving the --refmap=<refspec> parameter(s) on the
command line." So... I dunno. Just my 2c.

-- Hannes

