Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CB407589
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905896; cv=none; b=GEzvRmH6g5Gzx97EO6iESfw8SbyOkp7QSTPWlvoPtTVSStYpcC9Yw/J/mPteNrlzm7gcjrCmCZN/wnPbZeehQtKGwcW5dqEcZTxNGBUCT0fbGS0p5nGjBMeTOGoQ5x2sOplokA3Dzmg4JDdr+59jMBuqL7bo0J39DI0rOAPQZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905896; c=relaxed/simple;
	bh=VHqJJ+TIiwJe4dvJBL+pLkTaG0WGWSgnAdRoFk2tx34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jtq6ySmA09nxyJfKo++WZlLCSSoU6f3oJ1bjqLPifep7jhTABrDSskIE2Df6NemO/1ZzEt0MHzFO6/xlfWz9U/68XgjZkA0V4iNPwER3pVUWaXAka44OY06A5UbxPXIqCB+Yya7uDMi6Tyz14euhkulS6c9ubyFSjhyi7IZdI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=qqbS9mx8; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="qqbS9mx8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768905888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pnr/eBQcj1p3MdezQ/teBlu5naTWFz3o8RhJk+/9EqI=;
	b=qqbS9mx8O8p3U4l8RY1BFrBVfW4CaUwF1XjLKdWslgyUSLQ0j3gag5cC4JYPua0DoJR4mR
	dbIGsmDdgEIIh3ocFB4yQwllw4RQdJ9QB3DiJAcQt21HAxQX5JxmC+dKjSTIaIL5sjlPgD
	XZtj+JmEmlca2iniOcUAzauIVw+kYJ8=
From: Toon Claes <toon@iotcl.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>
Subject: Re: [PATCH v2 0/5] Change git-last-modified(1) default behavior and
 add documentation
In-Reply-To: <72aabd0f-bafa-4013-99b7-f065e8977f8c@app.fastmail.com>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
 <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
 <72aabd0f-bafa-4013-99b7-f065e8977f8c@app.fastmail.com>
Date: Tue, 20 Jan 2026 11:44:30 +0100
Message-ID: <877btck1gx.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Fri, Jan 16, 2026, at 14:22, Toon Claes wrote:
>> Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
>> Cc: Gusted <gusted@codeberg.org>
>
> I think the Cc list got mixed up.

I Cc'd you because of
https://lore.kernel.org/git/f0c508cc-5c6b-4c4b-a3f3-0cdd8d1071e5@app.fastmail.com/


-- 
Cheers,
Toon
