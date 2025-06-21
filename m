Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2622AE8D
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750519724; cv=none; b=iX2SqoQGCzOT81QgBxk4U8U9koVFiHWWvJloraut/BUT2ToOxOtap9e94NbnDfwZFv0R0QFwWLIzIc76cYEOxlsQ1amzJBuPiysMvVKwKudqnOwP/oOyDuNHu8EQh0mw8LN3Iz+mBZHXasnKYiM4IEX2QiT735/0DJ80he+q6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750519724; c=relaxed/simple;
	bh=GdyUXXai+NvjM+LXJwyebs/GMZ3tOnjjw76U1EzRR1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZxvnXHaDOO3sPgM6ouxATHBg4LXIh0Cz5ipgvb1ZlyViYSHwxnaFKmxaJyS13bXResPPo+X1xfw0OuwCRtGYIpyZmm4Ioo8PK24ox+xc+KzcNEbcmV0MONTTpyq12bZ3rB9bq9zXwuLhHDxuUOw6Vbdpr+pkIa3pmwa/KgtiPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bPck11mGVz7QSCM
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 16:51:37 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4bPcjq6K7pzRnlJ;
	Sat, 21 Jun 2025 16:51:27 +0200 (CEST)
Message-ID: <92e92b77-f8b1-4e7c-b426-be09e3f2030e@kdbg.org>
Date: Sat, 21 Jun 2025 16:51:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Resubmittimg Bulgarian translation of git-gui
To: Alexander Shopov <ash@kambanaria.org>
Cc: worldhello.net@gmail.com, gitster@pobox.com, git@vger.kernel.org
References: <20250615122631.41988-3-ash@kambanaria.org>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250615122631.41988-3-ash@kambanaria.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 15.06.25 um 14:26 schrieb Alexander Shopov:
> Is it possible to move to the same format of po-files for git-gui and gitk
> that git is using - without comments pointing to the source of the string?
> This is achievable by doing msgcat --no-location on the po-files.
> 
> The smaller improvement this will give is the smaller size of files of
> the distribution. The larger plus is it will make the diffs we send much
> saner as they will no longer be burdened by the changes of line numbers.

I don't have an objection to build with --no-location. I will just
assume that all potential contributors have a toolset that understands
the option.

Your submission here adds only two new translations, but it is not at
all obvious, even with `git show --ignore-matching-lines='#:'
--color-moved`. Is there a way to enforce a stable order in the .pot
file and/or the merged .po files? If so, that would be an equally
desirable change to the translation infrastructure. My hope is that this
reduces patch files down to the actually important changes.

-- Hannes

