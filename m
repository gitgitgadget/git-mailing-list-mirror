Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564498;
	b=LMFLa0cIAzeNXyP5Wv7BMK3UQtDBxtSrlAnOa/I/cOVzWLwkjD3YxxL437qHIPgFyyyJ
	 3OQXX7dfsL9YuDZcL/b4Ye0ehW70LJc/4ul7hDNN3hz1NPyo9339CDsKuKhHJi+3WAo/1
	 Gf8/aO638vLjdPJLqvMD68UXFUP9CXsXc0qIWeK+VcfsGFqCxSosnXvJdXx7YohMMPYWT
	 J8AQLv/d/+VwXEcJKVaUD0INGRXuMfvgWFHj1FksZm+VQOyllTftZxtJUUoUICRpsM7iG
	 Au+MjyVtwRSAvppoFpK1V4BJkfV1ZmEpaPrUIlxKDwpZ69WV7+Ti9038GNQ20i0y1jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564498;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=wp1s0WVKdzc5Ip16hPLg9JsFq6+4kdcIUTmxdxioeEQ=;
	b=3ARyy3cy2DeafBpiS2OGjzWyejpS6UqTk775nbXRyH10K/YMLkE0rudGDFTxm6kpPdyM
	 KqFQxLofJp9DotjN1PLhMa8uROwbTOI8lOH8Tqtg46urDHir3bQrzzmuHAgn3eYASodyT
	 qr1RWTkLVAf618rafV0JLrf3lTxHFYvFsOLCgVZiqUntVWolIlkADI5EBJd6VyKyWIaIt
	 9hIXyK6GlxB7ge5f4B418z2Oh4JDjp2bPEnUtBqrYHpDjETy5O3c2BIvohZJlm+xNYTzZ
	 RVM1QEMky4nCRD71rkUVcQcQk0eq3n21bdwrVYNDxItfavf/kSBxH3bHEYOgiNKT2YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=kwo9maXo;
	arc=none smtp.remote-ip=95.215.58.200
Received: from mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B0606A327
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 10:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 917B0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=kwo9maXo
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2kwFZfa/2eEFDMjaGKqdtZxS76HvfKtrEsaL/x9S5x0=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794564495; v=1; x=1795169295;
 b=kwo9maXoPfiakjcnZjSiaM12dDcVGuFI/eT+0Gapx5prh+fSYvz06jQ6hcTxKF6W0alTo3xk
 rQmaHFTBKj8Za5xBonFbCv8nYOa42dEJHvKj66LQ/m7B79h1hZ5t3Uai1qoZFjl4xPISwz2XPN+
 kxt6LWJ7Oh6h1B1rQxV2xXp8=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id f7507719e4f2ac67;
	Fri, 13 Nov 2026 10:08:15 +0000
X-Mizu-Trace-ID: f7507719e4f2ac67
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #05)
In-Reply-To: <xmqqpkw9fwc1.fsf@gitster.g>
References: <xmqqpkw9fwc1.fsf@gitster.g>
Date: Fri, 13 Nov 2026 11:08:12 +0100
Message-ID: <87v7613uyb.fsf@dev.null.iotcl.com.invalid>
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

> * ps/odb-loose-stale-cache (2026-11-04) 2 commits
>  - odb/source-loose: fix existence checks for newly written objects
>  - odb/source-loose: extract logic to retrieve subdirectory bitmap
>
>  The loose object cache has been updated to track newly written loose
>  objects to prevent stale cache entries from causing existence checks
>  to fail, which previously caused issues when lazy-fetching missing
>  objects during a partial clone.
>
>  Needs review.
>  cf. <xmqqfqxg32uy.fsf@gitster.g>
>  cf. <CAL71e4ONN4OQUZ2S==0TRWqZgA8ogT0smRL3Rk46voTm+0Tihw@mail.gmail.com>
>  cf. <55e14977-dfc2-4acc-bc71-a91915fa251f@gmail.com>
>  cf. <20261105194314.GB2898829@coredump.intra.peff.net>
>  cf. <au23Hvzp09yrym9s@pks.im>
>  cf. <xmqq5wyalzi2.fsf@gitster.g>
>  cf. <avHOTt_PEJUKq9Dy@pks.im>
>  source: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>

As various other people confirmed, the changes also look good to me. It
fixes the bug at hand, that's the most important.

About the NEEDSWORK comments, I'd suggest to integrate that as-is (above
OBJECT_INFO_FOR_PREFETCH) for now.

-- 
Laters,
Toon
