Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3719DF6A
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168456; cv=none; b=dYM9RKOHwhwo6/37njS2RJw2r7XqIJIqNTn59oxJohPYkQhDlsCSb/T9RKoQRV4FOV0vSpTRnH4u4536yfK1dyLmqa78KTmxgLd1kfw6DZaD5waLY4i4eU61M7DqtoTdPNySz5CFRwwZkHpNAaPOWp65JLXKIHMUfghVR3RSBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168456; c=relaxed/simple;
	bh=GJlViBMSHdsciY883XIY/I8SQfVEdLeytAG79cgUWFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JFS2+eKCthmd07hvaX/H4HAs2Ehqf11kke8+U5h/vS7D3ccUDUyCRR0sHfejq59Ib89K1b3jngNFj272Y9o3gzw+iFjqM9jDRZE5ZyqhygxKSoeNwINf7jBl8njehh2O9BTNMGO1cfU0kwlhdIpYmOwGih9FQb2oQC2aWx8IlyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=5h3jmZYn; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="5h3jmZYn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743168450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EwRqH1krCtCnBaAjoHhFHw/DHnZ/mTJWwetXHO/1JQs=;
	b=5h3jmZYnPX7vHAanIBgbG72XcooDoW1qDPj7SwhM5se9McewdrwEHJ+xkQn5NNZ62eJ+VA
	PenggQqpSuX+w9DTsjKyC5XRmlGN2gs7AU1u+MH842rjk/Am7VEHA+PWEBXh5K+FRVPAKj
	ptCDJIZFuIMVSw/BqY2N+k1TAChaE1A=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/8] Introduce git-blame-tree(1) command
In-Reply-To: <Z+XJ+1L3PnC9Dyba@nand.local>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
 <Z+Rl43VR3ErE0Bu4@nand.local>
 <20250327063243.GB3042475@coredump.intra.peff.net>
 <Z+XJ+1L3PnC9Dyba@nand.local>
Date: Fri, 28 Mar 2025 14:27:15 +0100
Message-ID: <87wmc9ffpo.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Taylor Blau <me@ttaylorr.com> writes:

> Sure. You can fetch from the 'tb/blame-tree' branch from my tree (which
> is located at 'git@github.com:ttaylorr/git.git'). I owe a huge "thank
> you" to Victoria Dye, who split out the various topics from GitHub's
> fork into individual rebased branches.
>
> There were many more patches on top that came after Victoria's split
> above, and I applied those manually. The commit structure probably needs
> significant clean-up and polishing before it's ready for serious review,
> since this is more-or-less a raw dump of the work on GitHub's side over
> more than a decade.
>
> It also doesn't pass the tests in t9932 (and the test number should
> probably also be reworked, it's in the t99xx range so that inclusion in
> GitHub's fork doesn't cause collisions with new tests when we merge
> upstream). To that end, I removed everybody's Signed-off-by in case I
> have mangled their work in some way unintentionally.

Thanks for sharing. I will check it out.

-- 
Toon
