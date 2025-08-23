Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320FB2C190
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755978909; cv=none; b=LSrszPTUhs3Z6+mnfTVHIM9H7MOuyknC+m+IkPFMinmhGY/A1H1LnKSMgpxq6A3U/vwW3BeqavF6PRXTUHeb8IomSIPIaXrcwA/lmSFfQlm+efOMKrRi7Xtb6XHfqwF8JXl9Y7ra9pZGytlLqLN/DpQ4pqFerq3poUhcMusOvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755978909; c=relaxed/simple;
	bh=2rlcnCeycZXiPZyZI2i4uEMN4g1HjPDAI6wM9B0T3Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ge+KdAlu0x48QAOoYZZ3N+gD2j97G5dn3waGm+mkNFHsQQjpXMxIo56vAM9DES/zvRg4UBO4g8LAweL3lB7z0YZ0twGEaggg8TaZwMkTpTw8ehHcyIL+Yg5h5xOr46I95dNI1zM6NRD4fC9JQ5csMe+MYukEtYjmRExrK2bTHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220182.atnat0029.highway.webapn.at [89.144.220.182])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4c8ST34MyCzRmx3;
	Sat, 23 Aug 2025 21:55:03 +0200 (CEST)
Message-ID: <ec2e704c-62f6-417e-9aad-94de91e354c3@kdbg.org>
Date: Sat, 23 Aug 2025 21:55:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] progress: replace setitimer() with alarm()
Content-Language: en-US
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
 <86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org>
 <ubouc4oefkouvoikedo2lcui3wgjgjovbilxnf67g76gmrp75e@ujkfg5asyy76>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <ubouc4oefkouvoikedo2lcui3wgjgjovbilxnf67g76gmrp75e@ujkfg5asyy76>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 23.08.25 um 21:38 schrieb Carlo Marcelo Arenas Belón:
> Would you mind cleaning it up and making it a patch I could rebase on?, or
> would you rather finish it off, since you also know the Windows parts better?
You can pull a much more polished version from

   https://github.com/j6t/git.git progress-wall-clock

I'll wait until CI shows all green before I submit the patches.

-- Hannes

