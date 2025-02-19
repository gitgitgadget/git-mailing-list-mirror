Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A778214A6D
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988907; cv=none; b=hl5zaIqYPl0gJE2Q7lrB1ZM7OG1tj+MvDSYD6C0MIkAaTrD71PXA9vU02P7gdvVOuKQ71EFpq1GoPVY88UaxnPQCeSdx/lsZNvLXspekaKlaO+9gB+vMB5d7ESA2iaWDe2C//vPUv78NJboT3Aqceje0hTu2ffsae/v18Dy/Kl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988907; c=relaxed/simple;
	bh=ixeYOmC1jXzhCv2rFIKuh0lnoORtEg7FJw8Vd8fwVSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5Bc2LHUmbhT9jSJMC3ilRQUxoEUSH+yeaoheiyAqhnKXKDKRFwDKicce5/Pf7oRc5xsoXe6YT6WqWQsL6R9ZVUnnxmY29nk4VR9updP/52T1rEiLa1k0coakgnpw5z25Le6W32SQKRfLAxp4nPEBmOM63OZJJcgiS0Mr9KuMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Yyk3w5c9Tz7Qd6s
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 18:32:28 +0100 (CET)
Received: from [192.168.1.103] (089144220218.atnat0029.highway.webapn.at [89.144.220.218])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Yyk3m3YTBzRnmQ;
	Wed, 19 Feb 2025 18:32:20 +0100 (CET)
Message-ID: <a901c673-ad55-4e48-b580-c48ff6eb138c@kdbg.org>
Date: Wed, 19 Feb 2025 18:32:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] gitk: extract script to build Gitk
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 M Hickford <mirth.hickford@gmail.com>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
 <20250218-b4-pks-meson-contrib-v1-9-c3edd292beb8@pks.im>
 <xmqqeczuj3fc.fsf@gitster.g> <Z7Vxx_yQSMlXfteX@pks.im>
 <67441cc0-ff56-4159-b080-868161605bf6@kdbg.org> <Z7XFrDmcUVIaotqC@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Z7XFrDmcUVIaotqC@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 19.02.25 um 12:51 schrieb Patrick Steinhardt:
> I guess the easiest way is to land the Meson support in gitk first,
> pull those changes into Git and then I'll create a follow-up patch
> where we start to use gitk as a subproject. Does that work for you?

Sure, let's do that.

-- Hannes

