Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279883E1D05
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453047; cv=none; b=YPp8rn145l8dUb31BTaN5lHktfJtGfXC8RsPKbu125fqiaJJlFUZn1ea7EmsAH6BJ7InIr65qTWost2wuEj86aayLLYpIPHmMrVJR7IUb/hQ2mDNew2vmctcoRGUoljqkG0rh3yS0i8/xwc0aQAgV2ntQQdrxrT5H4UjBT717Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453047; c=relaxed/simple;
	bh=HNyljTzRdowTX13eQfGsTWpoNp6fnQcoQxBnpFoZ0Ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GYHE1YcdWOEyqWTz2LKADrHWKtfA+PstExJgVgTuu3UgXixkC6H5Qs6K1BqWMH1xWOuWEsX6A74vXZT9Tu5n81/9GlRJ6Mt7z/wlyy0wj+gFS7wV8hCdGdlBt8CGcLyLYABTU16bRIr9CSkx2yCrGA6Y5RvieP5hR3BiYwIaMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=MKyt+AOI; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="MKyt+AOI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774453044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RR9AHiEytRb/81ZPXT24BZyXR6NXS4JsRrAd35aw0Pk=;
	b=MKyt+AOIc2Nq8VIpWgdej7d8+kMwz1jE0OXzTDtxjpxmVO/8ZEJ2CfTJfze0wH8rt74Zig
	8gDVcj+eqYfKa9ilk8mnYrh3obBfl6QIx1H3UltDccA1SgLC+kr6Sa+JTWWy6PQMv61klG
	GFTvsUgJcKQ4Mu30uCk9rFMB77YNAlE=
From: Toon Claes <toon@iotcl.com>
To: Christian Couder <christian.couder@gmail.com>, Junio C Hamano
 <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] replay: support replaying down from root commit
In-Reply-To: <87a4vv2ada.fsf@iotcl.com>
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
 <20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
 <xmqqtsu5xaw0.fsf@gitster.g>
 <CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
 <87a4vv2ada.fsf@iotcl.com>
Date: Wed, 25 Mar 2026 16:37:19 +0100
Message-ID: <87341n2a4w.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Toon Claes <toon@iotcl.com> writes:

> I'm fixing that in a separate series.

LOL, whoops I'm mixing up my own series. Sorry about that.

-- 
Cheers,
Toon
