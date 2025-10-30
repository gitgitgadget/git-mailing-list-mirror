Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9294366FC8
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839368; cv=none; b=mikaokoNBGFR/2O3sSpYTSct08wGQ8+mViAZNCsFhxnbBYAbnkjxZRiwmbT3PrgrOYWisiANXFSgxwuXfvj4KNwr/E1v77RCvwoEunpgiuzvyJsHFNQzsv7b6OAh2M4ciULmEzj6YCbeoSW8n82UJtKD/+MNWnP4QrBK3zP100A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839368; c=relaxed/simple;
	bh=J/qv19haRfy20PQDyykuIDYuYn7aUd3hUyljdVs5cJs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBZbPMlOJyNzfLd0JNm4DTVeRvug9MiRtYKNqoELJJMMoNMH8qKvj7/skEOoABJ8s44WdLsbRZRJLEuK3PMzQxXyRqgQBvb6gpQbEQD+rYLuVIWF0bo/4uVGkD04oq+1xKyrm8jvgAHJJFEVdlmeiYZGGjxso2ufaBhEyKSIKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=KUc9OVth; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="KUc9OVth"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761839360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J/qv19haRfy20PQDyykuIDYuYn7aUd3hUyljdVs5cJs=;
	b=KUc9OVthjBIZCSV1rDo5DcW5fpdgem8su4Sk6oEw1xI0YgoCwoRG/ji3a/FaVmQbo6dojP
	B8jsxWEsZEQEhmIIHu9iBDBqA1IqzEDvXUxJ553kOi8W/a6AdPLGkrTqXhIo2RM8GaZfrE
	C+3Ab9HVFyF+p9mrE2vQvpzMnDUe8z4=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #11; Tue, 28)
In-Reply-To: <xmqqh5vibpqg.fsf@gitster.g>
References: <xmqqh5vibpqg.fsf@gitster.g>
Date: Thu, 30 Oct 2025 16:49:07 +0100
Message-ID: <87qzuktmoc.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hi Junio,

I don't see the patch I've submitted to speed up git-last-modified in
this report? As a follow-up to your response on v2, I did submit v3[1]
which resolves the -Wsign-compare issues, but I forgot to Cc you. This
version was acked by Taylor[2].

King regards,
Toon

[1]: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
[2]: <aPrCaSOA/dclWye5@nand.local>
