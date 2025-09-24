Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F433FC2
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703811; cv=none; b=lkZZ+JIQtBFSq5j0WciNI7LphOmDhujqCn1CiWZ+ITWb4y2PtJOmmdTAq+kyxv79EkYny9jgWL1xCorv2+e2s44uCE76E6YxYM8C/nSvS/9W1StJJsKBTvNzMQsJQnwdo/3xDn9gPuSlC8218Uf6JgWDS55HpKREUmSR/qWm8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703811; c=relaxed/simple;
	bh=ppIRXKmnAixAylMGh3tYIwqpu1a//ViHRxa4jkXeDos=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Bk6bgAZpuVUXM75nRrMKEJ+BL0hI1T9O/81SR0I95QcYLy0kD32jFiYW3BpvuDisOmbhlgvu0obO8/QR2FJIixgtH4xJ3+0p2JhHJ/fu1j4b8siQr4yBBbi8h7vi+gM0ImdBsZaxSVLEatXYMn0rgFzyzfp/CDOLRdwCfdKoixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4cWrBw6qLKzRpKZ;
	Wed, 24 Sep 2025 10:50:00 +0200 (CEST)
Message-ID: <676d1b04-9a70-4002-ba3c-d9bb03b82235@kdbg.org>
Date: Wed, 24 Sep 2025 10:50:00 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] No context menu in gitk on macos
Content-Language: en-US
To: Marcin Wisnicki <mwisnicki@gmail.com>
References: <CAC9GOO8KCuLCZguZm_dg2MKS=cO=YUb9Uc+VLNTZSXMiO9wcig@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git <git@vger.kernel.org>
In-Reply-To: <CAC9GOO8KCuLCZguZm_dg2MKS=cO=YUb9Uc+VLNTZSXMiO9wcig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 23.09.25 um 21:35 schrieb Marcin Wisnicki:
> # What did you do before the bug happened? (Steps to reproduce your issue)
> 
> 1. create repo with one commit
> 2. gitk
> 3. right click on commit
> 
> # What did you expect to happen? (Expected behavior)
> 
> See context menu like on Windows
> 
> # What happened instead? (Actual behavior)
> 
> Nothing
This has been addressed already: https://github.com/j6t/gitk/issues/31

-- Hannes

