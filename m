Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92E1A0B08
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734954760; cv=none; b=lzbDjo63U8n428lfE9JpMfqlAQz7BI4jiVq/G6y2c6NuV877x0X+2V/7PA2BLrRDTRzXU6PSICgd2RyXNCNSktIaZYRNL1i0dE9CzSz+WjKXQc6QwI8vSPRcF5LFQEsDdkbE8uD4j/gONCQ4a+7KpfrSQJVmX1/dRpPB1hAFkV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734954760; c=relaxed/simple;
	bh=qyoqEM4NVwTuRzTaNqNywlOEamOjIFGksCCoDCtXv+Q=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J3KykDIKXka0k0DninyZsj3y9M66VykLoCseRTCE0be6/Lw4r4u0NqyTDyJZa48yopLtzPU7N4eqzZRlaZjMxh90d3UpeYEHX6+iboQB+xWmJw3uwn7HF7SRqZjoKdGzteTwNvuwbSGkyROtXVkyA5C2Sj5qPeEs/2wk13wLv8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=wTFV0htf; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="wTFV0htf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734954753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xt/RL7POlaBt7UxZccZovLhYt7yGNl2Ip43Y/d2CcdM=;
	b=wTFV0htfDa9pWIvFRQ0Y2094Ui7S/Aq8kaPc1qHc307UDeF9B2t9mkxp5p7PpTS8RAwwwH
	4Tyu5m6T9Q57hOBgwoRjaogp16flhearbmWkaOz55OZZFs479S8xDfrwcqAjqWy8t783d0
	NMhz3dsnDIGOLlRtrzy42Lmvcdd1JIw=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 04/10] meson: generate HTML pages for all man page
 categories
In-Reply-To: <20241213-b4-pks-meson-docs-v1-4-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
 <20241213-b4-pks-meson-docs-v1-4-0c7895952cd3@pks.im>
Date: Mon, 23 Dec 2024 12:52:25 +0100
Message-ID: <87v7vafwg6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When generating HTML pages for our man pages we only generate them for
> category 1 in MEson, which are the pages corresponding to our built-in

The tiniest nit: I don't think you intended to spell Meson with a
capital E.

-- 
Toon
