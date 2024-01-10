Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55A4C3A5
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="OX9sFniT"
References: <20240110141559.387815-1-toon@iotcl.com>
 <20240110141559.387815-2-toon@iotcl.com>
 <CAPig+cTRHHJ3pzWJtVJf8rKhvAJFYqrO0JsyTRTi6T5s+gznDg@mail.gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1704900155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pg6iy0epqFKTeKqdsiRsfDAZXcil8uneGyqaRPquax4=;
	b=OX9sFniTYqjSnyG4FQALjvWJ//scqMryaLsNNSdjiSRMre20aCdRi+b5L1Aw59h5/i9cBh
	5y2Uvg/uZOoLDbRyL6OeuXE9lYldY43r+450vbhyKyzdVTrrIBA9Agyjg3/7NkTeLeHqhd
	PwXrropwB76CGNPuD3P8mjP8FulGuts=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon Claes <toon@iotcl.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] builtin/show-ref: treat directory directory as
 non-existing in --exists
Date: Wed, 10 Jan 2024 16:20:41 +0100
In-reply-to: <CAPig+cTRHHJ3pzWJtVJf8rKhvAJFYqrO0JsyTRTi6T5s+gznDg@mail.gmail.com>
Message-ID: <874jflfc26.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


Eric Sunshine <sunshine@sunshineco.com> writes:

> It may not be worth a reroll, but I found the explanation you gave in
> the cover letter more illuminating than what is written above for
> explaining why this change is desirable. In particular, the discussion
> of the reftable backend was very helpful.

Well, I wasn't sure the explanation would be relevant in the present,
because the reftable backend might happen relatively far into the
future.

--
Toon
