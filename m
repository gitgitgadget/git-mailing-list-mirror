Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3246387379
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070376; cv=none; b=HR6COUmSo9kOubIJintwOVGnaH59JszGlTb3a+3mSrNq6bFNjH84+K+r3sewPMBLiuHJmHfxzQ26yyMP7cCOp1R8R5nbLSKEzUOT3u/SXfMe/XGYYBFXZEHZ7rvGd9zRBuT8+oekXPdWXuEGFCEsITQsMm2GPXf2lgxdJzjc3wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070376; c=relaxed/simple;
	bh=GEkH1ZoYaPyidsi4j6vkHyBd5aHJidi2BxAczHX+jHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIVy/67PM/NzbcSFR67nn7Q6iSRMKgQ+hVqGZV7HvKow2qsY6ulVFyWCoB/2xx55qxteFAIPpnY/ppf0BF7RU2TAutXU9G8EJ2Qg3RON9Da/1eBxKFrTl7JwJdUpPhwpZBYnp6xU+q8oX8j4Sf3Q4nqf/0laIeR7pq75Eu9WPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=uI7dh/mA; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="uI7dh/mA"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 6D2744C019
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 09:26:07 +0100 (CET)
Received: from [192.168.3.191] (unknown [92.173.128.58])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 81B8C5FF95;
	Thu, 22 Jan 2026 09:25:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1769070359;
	bh=GEkH1ZoYaPyidsi4j6vkHyBd5aHJidi2BxAczHX+jHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uI7dh/mA19zoZ/bhIVaE2UyVHIhgZdbqd75+GR7y+n50I8t0zIpzDmTae9pseM6FZ
	 2j9YuPWwCtSwiM0CnfdTfr6WceAi9/C4phC+pLtywDmfkPc/Gs1AVZYaD9cpKBFMMH
	 6pvsrzLp7JZ/mOYg4149MyexDmlVFT9INZ2ZiU9DHV4UE1TErbLP0AkqK9aTWJ5nyc
	 0UzSaBsmhX3lv+Ihn+jgFnvJI6cVIdyjSgXdan3BNBzDaaVrRGpvw7Rqzd79s/mlz1
	 CJHQDCI0Z46VLF0rJ643rIOMxCYWZOaMdhKd0nMYn2aR8xP92rAKvhmHpLq5B531G4
	 tkqhAIj/ZufRQ==
Message-ID: <212c09b2-2931-495f-96d9-495f78666f0f@free.fr>
Date: Thu, 22 Jan 2026 09:25:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_=2Emailmap=3A_fix_and_expand_mappings_f?=
 =?UTF-8?Q?or_Jean-No=C3=ABl_Avila?=
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <gggadget.24e@msgid.xyz>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <gggadget.24e@msgid.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 21/01/2026 à 22:51, kristofferhaugsbakk@fastmail.com a écrit :
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> The latest release candidate notes say that there is a new contributor:
> 
>     Jean-Noël Avila via GitGitGadget, ...
> 
> But this is a familiar face, just in a G.G. Gadget trench coat.
> 
> Also map the rest of the idents in the history.
> 
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
> 
> Notes (series):
>     Tested with:
>     
>         git shortlog -e
>     
>         git shortlog -e \
>             --group=trailer:helped-by \
>             --group=trailer:acked-by \
>             --group=trailer:reviewed-by \
>             --group=trailer:noticed-by \
>             --group=trailer:reported-by
> 
>  .mailmap | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 3cf26b1add0..799734821b4 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -107,6 +107,9 @@ Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
>  Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
>  Jean-Noël Avila <jn.avila@free.fr> Jean-Noel Avila
>  Jean-Noël Avila <jn.avila@free.fr> Jean-Noël AVILA
> +Jean-Noël Avila <jn.avila@free.fr> Jean-Noel Avila <jean-noel.avila@scantech.fr>
> +Jean-Noël Avila <jn.avila@free.fr> Jean-Noël AVILA <avila.jn@gmail.com>
> +Jean-Noël Avila <jn.avila@free.fr> Jean-Noël Avila via GitGitGadget <gitgitgadget@gmail.com>
>  Jeff King <peff@peff.net> <peff@github.com>
>  Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
>  Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
> 
> base-commit: 83a69f19359e6d9bc980563caca38b2b5729808c


I spilled all my online identities in the codebase... Thanks for fixing
this with the right one.

