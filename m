Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC03EEAFE
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592142; cv=none; b=WSh6UA+qIgtknwbmbSkkZckVvWoY9Ynb2NPloqPXnh77ntUpJ3WujJSTz0HqQwPRmrFuNzAiiiTi19BGocevPhC/c9zAR9QYltNXbSMzXWMLkGH23VQVWuh5vaPNeWctO5swEO2K8eMVuVlaJUgnUeyh3qhc6fJZYuljfWVN6q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592142; c=relaxed/simple;
	bh=beosyd+jdERd6wFF3xz1q5p7jQehaWUli7GKxrYaT1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jVvAUkbXT7mShrAllYWlERZWPCm4aHSCI6rPQxqbCwRpUuzZcaD74s7tvP0NADRBafEwBbDU64L0/BXE6xjcc+fAuN3riF/GatfMd3l+hNIJZt3MICRhNF2KzpfKXbjvmK4Gr2CAq7e6f7ufgGTbctItinUvKjAl3yJonlJGGqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=iS6zzZms; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="iS6zzZms"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781592139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c0AygoCgMsTyryG9Ry7MGVygQUfn/vxjreFBqkQvRmk=;
	b=iS6zzZmsVk3iE73ItQ2nETV5b09BBywlrsnRfNaHBF3ESS+/54i0gEDsJ4yrwMHaZVrSs+
	8C3DyOjXB+0GwvQ7/mxjDIFQ3Hydd5T4V/s19e4ps3YnqdPviUQQ9kUfbW+GUSCR+8kkvA
	ZYdjWq9PEGuAF/LS/N1QUMzRumX5FCI=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] setup: drop global state
In-Reply-To: <aivsoM9Qwv0m_P1c@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
 <airVOrTboNDDGBak@denethor> <87ldckyygk.fsf@emacs.iotcl.com>
 <aivsoM9Qwv0m_P1c@pks.im>
Date: Tue, 16 Jun 2026 08:42:13 +0200
Message-ID: <87a4svyoje.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> There's only a single change to a commit message I've queued, so I'll
> for now not send another iteration.

Yeah, not worth a reroll.

-- 
Cheers,
Toon
