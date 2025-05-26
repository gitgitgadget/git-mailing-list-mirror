Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC31E3762
	for <git@vger.kernel.org>; Mon, 26 May 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249259; cv=none; b=TNJWBZrdGw6/ilmoMq0H5q7OnvM4aBhtVcvFG4SDEDjxlN9Brq82chfbQrfNnZkKUF9MzsvvygdDkZXEiuv+PmjOKFKjsERnxq1vrnuAdCQw88aKUtRD3/448L293/Cov0o0H0FgPoNeUMSZRjhQrptasXI7HDlRJrit9xtQ6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249259; c=relaxed/simple;
	bh=ayaQiIzfZDomKNW23QljhwU7MFVHHjcDjJRjOSbtz2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=utCSgYLvHQ8UbBG1xJiSsTX+0uv42Y8thaKl+i7yz8c+56Ydm6lx1p7E0wToK6pKvp01aKMtI5n36eFJj+ovoMXxmuF8bIwHf6fOBlqi4PSuh8bmftrkYzwAHVdEWzaVWKwiqEnh1ufXXptJnZ3cT4H56ForFRs7dlwIyl27VjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=kAjKhlW5; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="kAjKhlW5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1748249251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vhz4LJZQcj9GfrKV96JVyBf5b4BpKzPzuK/xPE43gRM=;
	b=kAjKhlW5iBAruA+MHjjLQf7yLoz4txAz9wa7825S1R2G3YRwFyp4rkrp08U35mSSxxXrtz
	ltieE5v9nhTs0kWXcIl9mdaHR5J++ovwWSioCdlG3AVs4OR+F/ykt3F5osWEK+bXeJDSSo
	HlQ46qhs/dpQIk8EIV7KstM2CuA11Pg=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Matthieu Moy <git@matthieu-moy.fr>,
 Eric Sunshine <sunshine@sunshineco.com>, Todd Zullinger <tmz@pobox.com>,
 Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 04/11] contrib: remove "thunderbird-patch-inline"
In-Reply-To: <xmqqplg8rx2b.fsf@gitster.g>
References: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
 <20250512-pks-contrib-spring-cleanup-v3-4-32e151b0bfb0@pks.im>
 <xmqqplg8rx2b.fsf@gitster.g>
Date: Mon, 26 May 2025 10:47:16 +0200
Message-ID: <87h6173giz.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> I've dropped this step out of 'next' for now, to give Phillip's
> update a chance.
>
> cf. <20250516135540.218937-1-phillip.wood123@gmail.com>

Makes sense. I've gone through the other patches and I think they are
worthwhile and look good to me.

-- 
Cheers,
Toon
