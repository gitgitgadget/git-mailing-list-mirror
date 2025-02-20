Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831F2AD16
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014955; cv=none; b=GEuyBuxDc+ZMYNDm6ErQyjKevf6zDro30LsD0FffXaLtz0iBt590os93t+0c0smUxp2G3bJgiFx5courHi4AoI8NPaAvZ4nZeyLBn7rDRx3kKPfsRdIVYB9cnbwkIQAma996wZiBrImGlAD7VlJN0jCEirPKL9hxnt1u/5zbnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014955; c=relaxed/simple;
	bh=JWFBrPb9pRSb4uPzPY+0BmPNc7L3pDGV305w0+R6DvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGHEldiRrnNjX26P0kwCJUgsxRTg4GSrNPAAFYnSPa9EtLFfaPOgqInMFtGlA+Vflz0FzjZQfria63lIluaHS9IIG40pAGQD3p0BTvWg+lffsoB22soeIO6P8DqeO0oYkDwPkCkHKWe99P/pFN5hmpW9txNNYUA7ATwZOhFqkkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Ae7FPcKF; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Ae7FPcKF"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id kvKBtWfwZeYyCkvKDtFthd; Thu, 20 Feb 2025 01:26:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1740014763; bh=2WqPejFQ8WyWJMgvwzxHJDcem52rsLQVe47AGoHuX2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ae7FPcKFe6KVPhELFKo2CVlxU0GSPida6f/dHT93PHUElC1ckhtF6ICCHb4GXKlxv
	 i1fz0dg7ptTQ0EFDAhA6dZn8UKjlPE6VRrLYbh/T3daBQyXz9oOtYitOmaWVC+75QS
	 H48IH4XpAApQf3BUPeDi5M0IVBwYWWH6NV5xukIscmZLX5rgFvhRqX0yCh14gUSwPH
	 7UKCUcnrUE2wJylY8ikTxgF1GDEaWHjBixEgdUWFIELnUpj+1FZbQiKNpe90vtKtdP
	 DnCzyxSLrUc98xqI7xECZ1g4HaBPoeW8TnKBmt8R+vkzxgdnhB3vgyDRCChdfJiv7D
	 xtkpZO36H5Zqg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ac7Cngot c=1 sm=1 tr=0 ts=67b684ab
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=Be0SbxFkEju_5r2Mk_QA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <390a138a-fc0d-4011-93d6-71efcb19e863@ramsayjones.plus.com>
Date: Thu, 20 Feb 2025 01:25:59 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] [PATCH v2 00/10] meson: wire up bits and pieces from
 "contrib/"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
 <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfA/Bzyde0v82omvVsimO5loEMnENU2u8g2VTDyN28Q4xFN8IXWqDER0Pl+SqJEWx4Rft814jUoacwJ7pekkontKQYYywANkfshf7LA98aMzQj3rkjSSx
 H8gTrRpVsryLC5kyFa6iJd2fudKNJL2y5ZCzwK7qNx73VkkEh2n4QNwt79LIm6agvS3drgKzsbzngmLp5ham/IUqPPnmJa4a+zk=



On 19/02/2025 13:13, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series wires up a couple more bits and pieces, mostly from
> "contrib/". Included are:
> 
>   - The "libsecret", "netrc", "osxkeychain" and "wincred" credential
>     helpers.
> 
>   - The git-contact(1) script.
> 
>   - Coccinelle via a new "coccicheck" target that generates the semantic
>     check.
> 
> Not a lot of stuff is missing after this small patch series, as far as I
> am aware. Omissions that I know of include "git-gui", "sparse" and perf
> tests.

I regularly do 'make sparse' and 'make hdr-check' as part of my routine.

Note that ci/run-static-analysis.sh uses several targets:

  ci/run-static-analysis.sh:8:make coccicheck
  ci/run-static-analysis.sh:29:make hdr-check ||
  ci/run-static-analysis.sh:32:make check-pot

  ... and ci/test-documentation.sh some more:

  ci/test-documentation.sh:18:make check-builtins
  ci/test-documentation.sh:19:make check-docs

  ... and then there are some coverage targets like 'coverage-test' and
'coverage-report' (I haven't actually used them in decades ... ;) ).

ATB,
Ramsay Jones



