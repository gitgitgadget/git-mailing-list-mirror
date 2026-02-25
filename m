Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9882023EA90
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015603; cv=none; b=R346AuzHly1fjuQUc+yfBG3FV1R2C4eD2ttzn6Bhp6zwivb/jGFX+LLs4oflAJMv1ZIvKKR/vk+P3FH+Ql3DZlW7rin/eDn0TZu4kBmlggUvB9pyJEWJVJ8tInWJlhcJjS9/8kUUlInyEhjec2z1WqmT153G02VNh9pRtTliNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015603; c=relaxed/simple;
	bh=se57fZICSGPWJr3kaqdC4wdabn/ZolIIgSHMvtI+kQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UYe5rXzFN1MyKKF9hs3gRrAIxI0VKAbI2/okydy7IBJ6yhLAmHzjwMNCi85S582mGBtH10TaC5o7Trvx08QRzk72XVeQ8dQZiCgTZhc3dcH+kqHce9QkHFNvkd7fQL5awuQZ3SIxTFvAtbNDLYqLFdZstML9Ctgy+Vqgq1hYkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0Sxu/d2j; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0Sxu/d2j"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1772015599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fpVd4tyYWvDMST3hH1HRl3+Thhrwzh8RpHTI6d8Zlzk=;
	b=0Sxu/d2jf56YFS942FxMi0Z0TkXybTqncK8gkNVOjckuf/MBuqsM9m/J0l6mOaAevKfEC1
	wT6XpmM8/wrWUDgn3RFs3Fn+BwZA/NnbcfVyIbyCjWVT4n/MS8JLQ9ZEUoi6dgoEiWZN4W
	Y3ayP3zfyzTC9hwb2h25fFY0s+paHyI=
From: Toon Claes <toon@iotcl.com>
To: Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 8/8] builtin/maintenance: use "geometric" strategy by
 default
In-Reply-To: <20282180-d018-47db-a44e-93c53af10d00@gmail.com>
References: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
 <20260224-b4-pks-maintenance-default-geometric-strategy-v2-8-8657338c6fa1@pks.im>
 <20282180-d018-47db-a44e-93c53af10d00@gmail.com>
Date: Wed, 25 Feb 2026 11:33:07 +0100
Message-ID: <87wm01m7to.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Derrick Stolee <stolee@gmail.com> writes:

> With this, v2 looks good to me.
>
> -Stolee
>

Also did a review on v2, and I've got no comments about it. Approving.

-- 
Cheers,
Toon

