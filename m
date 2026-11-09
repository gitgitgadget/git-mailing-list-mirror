Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.208
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241434;
	b=cFHCUPrcQelTiZ1zyNUwtpH8g+IlDvcvx4nZxTxf23FD8iDAXz1anY24Vpzp/4yyc/AS
	 GTftLgkA4McjKekf0hzcZ5lgQ35RfmaDQ+34YB2JF0kw8ltlBmFq7Ens+BzmNiX2fe3O5
	 gRD8/vXGH3tblmG41X6UN1dmfSk4TCj+7FPnAt/Rz/XrGiIDAmMgeJ6Wk9xch0w1gnWe3
	 xkRon6AOZEwBN7D6/K3jteWNwcjRh368pqKAZCnasGqOjwu0n33qfLjuEAPRBndtGivUr
	 QjUowEwfDtqssftTU/yF3Ou+a57kPAOfDDnPiz7N6CktLHdInZtorL2NJllnnwr8Jtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241434;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=biJIULNU4m6Vn0X5YI2T6mY1hy29gjPS2wfPlbC+8e8=;
	b=stywLrS/OZbY2Nq7w/knbD1yHIHSOHm7COtfWzcS5D3mtlk5hltQhH45OtVClDDSfgtL
	 7h71kYM9F1Tb/c+x+/n+H6U878wh8UoEdrvu/dwFgmoGAx2NhcFWDbATfxHdSIwp4+q/L
	 doCjkl54oPkkeI07ejCBoGVNO3zV6PrTVt47RqZws1J83Tv6LPQp8CHLMeJrCtV5Zfby1
	 pIs+DIGEh0VkwduCp5nM4c3/2znqGEQbVUDrgfJWC+WLxUW05DqnaaSOoFv2FrRtBpAfz
	 yI5ap/ZfC8jCYyvRKOo4Mqju/XnUye/P6WCPCMlonw4P4s9CDXu9ivp4D+1XDPGvkiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=DAVBVzv4;
	arc=none smtp.remote-ip=95.215.58.208
Received: from mta1.migadu.com (out-208.mta1.migadu.com [95.215.58.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B22B606A330
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B22B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=DAVBVzv4
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JBy7Pt+BM0aYWEDI+HxHYQDFSZBYLi90O4IqfLvo6v0=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794241431; v=1; x=1794846231;
 b=DAVBVzv4Q2xcZViE3/fC8eMOAUW8uHdJKp4+P2SQd+vlCiW8CVhmZYkxNO8QNiz8f4coZh45
 9mkgb6Xs1AbzU5MryhYvU61y2B65yMDQ2vT8KdWCjjt3JsvXh7xr/pMsftRm1Lltl6ihUyymgOW
 7FyRAztoJLLKi+kLqsk3R+AU=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 04487d5488d1154f;
	Mon, 09 Nov 2026 16:23:50 +0000
X-Mizu-Trace-ID: 04487d5488d1154f
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #03)
In-Reply-To: <xmqqmrrlfzcd.fsf@gitster.g>
References: <xmqqmrrlfzcd.fsf@gitster.g>
Date: Mon, 09 Nov 2026 17:23:44 +0100
Message-ID: <87pkwex9bj.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> * ps/grep-recurse-submodules-fix (2026-11-03) 3 commits
>  - builtin/grep: read ".gitmodules" via passed-in repository
>  - builtin/grep: read sparse directory trees via passed-in repository
>  - builtin/grep: read submodule trees via their repository
>
>  A regression where 'git grep --recurse-submodules' failed to read
>  nested trees in a submodule has been fixed by passing the correct
>  repository context pointer instead of relying on the global
>  'the_repository' variable. Additional latent bugs where grep_cache()
>  and grep_objects() incorrectly referenced the global state have also
>  been corrected.
>
>  Needs review.
>  source: <20261103-pks-grep-recurse-submodule-v2-0-b00e3b3dc865@pks.im>

My comment on v1 was addressed, and I've got no further comments about
v2. Changes are fairly small, and seem not at all controversial to me.

-- 
Laters,
Toon
