Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E7347B4
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341560; cv=none; b=SVCTRX0Mwd3GmHwmeh+h6TPyVFhbOo4QlP/ewaMWg0irfyRzdqrbUWlw+hrBQJrBCDJ8kKNNp8i0y9oK9Oqfx1nUbFZNQWcIsLhS8w7BDaN6IjYVcKnW3vl6lZzNWw/NJrWLh+Izr99sd8pTkydnEJ9eZukSQ1L4oGRsBAEbMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341560; c=relaxed/simple;
	bh=R5F6uSw6EyBqYWEbPau75MYHH4A4neEE0vilpRc0DY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O3MEVhdCmp3qOMYC1iYe2+Yfdzh3vHu/zdWiSfO6ecFdxjWlD06FmPehH1niyHGO9NX/5CRJXY0zqgU1kEEbA2Ve/hYSlcd/R1qS+QQzFOFHJ6wofkzyQTwpsLq/RpabyCLObFSNhjNcNhfTC8IPgViu6cTS2HpUFtjQKCx8pIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=sQfRFmiK; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="sQfRFmiK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734341547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jUYfs1Pqvl5O7hjEsiamCw0H9OZAZsTOM0yAs2pLIho=;
	b=sQfRFmiKmjd+LIoWms93E22/60moKakpDfdGe3WFv+jmXy8JIxzkisBV0xl+WkNRvDmevJ
	u1y8j2lAir9gpi6Z8kpZXfHfTrjxnUymVJrnIYzcaQi8U15XrJ1OuFPCH36mysIgBYvscB
	5hP0Q+d4PmkMtkfdchNPNs3RCZGIEgA=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/8] ci: wire up support for Meson
In-Reply-To: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
 <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
Date: Mon, 16 Dec 2024 10:32:16 +0100
Message-ID: <87zfkwgehr.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:
>
>   - Improve a couple of commit messages.
>   - Explain why we remove `-x` from the unit-test driver.
>   - Remove unneeded `CC_PACKAGE` variable.
>   - Improve error messages when tests weren't found.
>   - Link to v1: https://lore.kernel.org/r/20241211-pks-meson-ci-v1-0-28d18b494374@pks.im
>
> The series is built on top of caacdb5dfd (The fifteenth batch,
> 2024-12-10) with ps/build at 904339edbd (Introduce support for the Meson
> build system, 2024-12-06) and cw/worktree-extension at 2037ca85ad
> (worktree: refactor `repair_worktree_after_gitdir_move()`, 2024-11-29)
> merged into it.
>
> Thanks!
>
> Patrick

I went through the range-diff and looked at the individual patches, and
I've got no more comments.

-- 
Toon
