Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B930E0EE
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231807; cv=none; b=cEADvR3sXmXjx70tDDI31tTIcqWCXypzMFRdUFC34V5YvHa/vGQAvMG0tOscd7s1auGe3IVWXBv2NqpNh4fINTKGrFinfV9ULtRNnhXnWwkQ46P+X/D2ax+0bJFeirsXRcA99q3b+kpvSI58b1AugH0M2Dmlrusy3saHonwxFUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231807; c=relaxed/simple;
	bh=Hgi/25r1DI5ANjrtjQfCUcQcplsh15MBxTHFckfhnr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I82D2CmRHGGNR7M7AddM9XWd035tphb5G7ASyVHG1GYe/r7VCVbPOJ3i0Tw5w+M1eOkV3i/XwyFDlt1xbTECDdEp8UAHEAtXaLB4oKUbC+jrzd54MnR30p47nfM9ssP6Mkya1FCbtT2ISTi8l2WPZiy1BGqql/BLa7HqCU6k71o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gl9NM2jxbzRnlp;
	Tue, 23 Jun 2026 18:23:15 +0200 (CEST)
Message-ID: <d38d233c-a7c9-4457-96c1-bfb75af71ffe@kdbg.org>
Date: Tue, 23 Jun 2026 18:23:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Silence po catalog output under "make -s"
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
 <pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.06.26 um 16:56 schrieb Harald Nordgren via GitGitGadget:
>  * gitk: gate the quiet helpers on -s in MAKEFLAGS and give the catalog rule
>    a QUIET_MSGFMT prefix, so a silent build emits no MSGFMT/GEN lines

I've picked up this one.

>  * git-gui: replace the QUIET_MSGFMT0/QUIET_MSGFMT1 pair with a single
>    QUIET_MSGFMT, since with --statistics gone there is no output left to
>    reformat

But this one, I skipped, because I already have all of it in
https://github.com/j6t/git-gui/commits/hn/silence-make-s/

Thanks!
-- Hannes

