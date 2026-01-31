Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866511F4611
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866848; cv=none; b=vFrsviUB5h6H39YWARhfpCmdM9gLzGwWyKKwv8wioJHpD7Hz6Rtj+wIrgzxGF16Nf9g2m6AdGdCNGwZ+3LmYFbS8XLybbZvzuGTZ7hkvdtt+vEDKNG+3OylvnxhD3DysbBXRWC8+EzRqwTiHSMfQw++ZclwNdpsjswrQTLJvjMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866848; c=relaxed/simple;
	bh=sfyQcNDV/m0O5sUCD6wdyG9vj/+hqRO3b7KsQnZCZRg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyZ3wkr4EKYQ7K8+NVbcZvcpRpi1np7/+YkSB/yw7aNoRA8qRAM8lmS7FjaX1IKQCBdJGwlJKmdoN3pTSCLZTGYq/NpjefrrEDFnt2a3MuztNQpDkBa/3DlaJasMRt0wJ7h/xkfFOwmGzCpCPjck3ISryBqLjkDuJnK0UhClxPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 87CD34C93E
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 14:32:03 +0100 (CET)
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 695C0B0056A;
	Sat, 31 Jan 2026 14:31:53 +0100 (CET)
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: What's cooking in git.git (Jan 2026, #10)
Date: Sat, 31 Jan 2026 14:31:53 +0100
Message-ID: <12827696.O9o76ZdvQC@piment-oiseau>
In-Reply-To: <xmqqwm107za7.fsf@gitster.g>
References: <xmqqwm107za7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 30 January 2026 00:52:00 CET Junio C Hamano wrote:

> --------------------------------------------------
> [Cooking]
> 
> * ja/doc-synopsis-style-even-more (2026-01-26) 4 commits
>  - doc: convert git-show to synopsis style
>  - doc: fix some style issues in git-clone and for-each-ref-options
>  - doc: finalize git-clone documentation conversion to synopsis style
>  - convert git-submodule doc to synopsis style
> 
>  A handful of documentation pages have been modernized to use the
>  "synopsis" style.
> 
>  Will merge to 'next'?
>  source: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
> 


I'd like to have a feedback from Kristoffer Haugsbakk 

Thanks


