Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938C2134AC
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 06:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754373832; cv=none; b=TXsW4BqsM/ZP2iyH6b8gEfbdn9cLa5zQJg7I8jruoQ+VtyDH1q9LzX588W2EZFCT4V5ks2pzMa2Mx7sg/k3rPlIpuYILmrO49oxRKtEgsem3feNBxW8aO3rS4pTHf+8etPPZczy3NjgllfmbB0ShsBfoZ+iEa/WfmOvNAQV0oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754373832; c=relaxed/simple;
	bh=Fl/m2V0/jfeAYJRBU2DgB/+/FFDCKP8fQmPgnoVn7Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=N2DJH8SknRAUwTBsdlWjkEuXInGuV/57254v6ce0EJcKzbM1rKAUb3yeVjKcGmYQjLhcNRepuZzz3z/4ZILALyB1627cATjUpWKgY+fJw/SGy5vSLTRp49l+msM7NPIcAaboGyinP0f8JS6sqbiRkEse4pQ1p4ZrbXODZNZF0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4bx2tB6h2TzRpKy;
	Tue,  5 Aug 2025 08:03:46 +0200 (CEST)
Message-ID: <4d08a37e-2c12-4e3b-b6a6-028e2d6c0a22@kdbg.org>
Date: Tue, 5 Aug 2025 08:03:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Feature Request: git mv --after (new flag)
To: FMorschel <git@fmorschel.dev>
References: <1fa7a8d8-3ae5-4913-b3b5-21d8f67e567d@fmorschel.dev>
 <0afc01b2-11a2-4f77-a858-7a444e8bb1d4@fmorschel.dev>
 <2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 04.08.25 um 16:05 schrieb FMorschel:
> This is a request to add an –after mode to git mv command to explicitly 
> mark a filesystem rename after it has occurred (analogous to mercurial 
> => hg mv –after).
> 
> This would allow IDE/Language refactor renames/moves and would make sure 
> git still detects the moves correctly for keeping the correct commit 
> history.
I've wished for this feature several times already. Though, in Git
parlance it would be spelled `git mv --cached`.

-- Hannes

