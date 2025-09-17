Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715052FFDE1
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134614; cv=none; b=rIUQ9KzbNR9ZbCHDUDZXnbLCAMqIGZUNhzE1Sta/vedXmFQC9Jej0I7Ww7/UdP0i9U98q/jaYWHiR165a2ZEWWLDp0QbnjZFVCBvONdGdjNZeSZBdw03rB/dedfn6nuGxxihDUpxYnpKHYY8EALGNf7gFQYYEsE+eqZTKUQiQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134614; c=relaxed/simple;
	bh=paGG5IDhNkLVUvGJ23vrnNFCzWutCpK+INfx6GO1pR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JMEJX5AIbXNNixxXdsQZptrwS19uFDbyKICuJy0U0DcRIw7gs6miHODBhQfUNR6LOTuNynmSPt2Vctj37iseLP6YMbyrQLN9L3YhqE1oHWg3E3M1Sger/bdX8/Dc73WYnZtmRYiGz87S7qy87eBLm2kY+fVFoBsNB2WhU92DbEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=1mfLH4Na; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="1mfLH4Na"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1758134605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+wnXYQRLP9Hl9E+cE2kjCqV4RtY6LE0tms7OgmJG+0=;
	b=1mfLH4Nak2O3LFY7oJIbCYcFwjVa+epEI19pqERw0E+aygzVmVjcY/4XV4BWk5L+pqhsYQ
	uLy4HMJsHeNWR0MtPog50IdKS/a8c+k7KCSksGo3bpjHsJ9Eh10467ufQ72wfpDoql+8KM
	r8K01ESQjdzE8sb8O+c1BaDj0JLE3Go=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net,
 ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v4 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
In-Reply-To: <pjvwiyrcdrtpkeyro2mvmfljj6a32u7bhli7ry2cndjhn4pi22@6hzanr46cyij>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
 <pjvwiyrcdrtpkeyro2mvmfljj6a32u7bhli7ry2cndjhn4pi22@6hzanr46cyij>
Date: Wed, 17 Sep 2025 20:43:09 +0200
Message-ID: <871po4or7m.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> Looking at the range-diff, this version looks good to me.
>
> Thanks,
> -Justin
>

I also have got nothing to add.

-- 
Cheers,
Toon
