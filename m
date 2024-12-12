Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D3212B27
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004681; cv=none; b=Ar3iPDOw0DA48Y/39zIqDkLH35PkK5PenpTWQhgz1PXuBMAtjDc71RtyTI5NuUYlx/FsgPUUvHHuTFTkEXA2CES+PzgMFJTJ/28uO1mISrDIEhAbi82xn/7Lbm15Z1Hbm6AdyveCgW/2NawX2fLArWEOuPADK11TYCulPk/ZFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004681; c=relaxed/simple;
	bh=Va9orlNE6zXwEHZ0IeKGSMq0QdAS/s+OlezagdSLFKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VCLRmfYJfu/nZxwdf7zmwlHgye4C2dT0Sb9hWJUQ4D/PWYr2NdLXdkpstG0kpb1t3iD28hLrqw6q9jNinTFUk3eguO1OW3EzOmW/9Bq2iZD6ZF18H0Zen9xeXqdXEkTAnqJeeXxbfypsSD3Zm9CaMKLQ4l5FRB5NGuyfYt2QWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hDOlqcoA; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hDOlqcoA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734004673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4fOns0V+UPHzM9udrW50xTvfB7PpECMUICxMEmcV+I=;
	b=hDOlqcoAabdjH/huYrrehvVn/xn9OZhmV6ciVUw02Yfa4VJ/+Xr4FYkP9oNRMuMlj6BwO0
	Cs7r51pLM8sNlhDzXQa0GBvrWArOdqu/SQDcjUVsrbsdBkBu4w6aXLUIJIPt9YPPSBF6/E
	8Vtygj0vJ01SNVGPPlTrGyk7x6LpjOs=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, karthik nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v3 0/4] Random improvements to GitLab CI
In-Reply-To: <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
 <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>
Date: Thu, 12 Dec 2024 12:57:35 +0100
Message-ID: <87v7vpi05s.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series includes a couple of more-or-less random
> improvements to GitLab CI.
>
> Changes in v2:
> - Use "%s" to inject variable data into section headers instead of
>   converting to echo.
> - Link to v1: https://lore.kernel.org/r/20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im
>
> Changes in v3:
> - Wrap overly long lines.
> - Fix a word swap in a commit message.
> - Link to v2: https://lore.kernel.org/r/20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im

Thanks, all looks good to me.

--
Toon
