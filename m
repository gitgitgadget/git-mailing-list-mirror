Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F39305684
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251602; cv=none; b=cK6XzL8xILgAuJ281LlVcC8j3gvZJ7yNxMzKJuyuqYcHHeAKGNN353tm9buglyDn8hq3SiQKK5v21mi7zd3Yv6lflDNLgE9GOkHajmucrSw+cFM008KF1gJ+MUT6axF8v3iJL/twsCrAw1S+hGaM2CHcD09LPTTkUZl2i6P4CNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251602; c=relaxed/simple;
	bh=tApHJ3ISyI60j89Jl0ZQKQdchZXSxGJ+86u41x3sh20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uL9SyM/LXPBtSVo7qb+Ou12kDCQCYEB3crL8swGijCpE50PBzbOSLMNKh4HEnY2zdN8lzLkYwUY/ldji6lTmXEYqzT8HbfSD7MALlbxM+74giA0+7pvZvSLJ5R3jinSwb2JyMQZtJQMR3VXfhAJ8Bu5bXZ59N+8DlfxmXVsE53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=33dJI1wz; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="33dJI1wz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781251599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/rhIeXBx6OyHoTLCMGONJntUcbdDYDSjiQIv2eqdIQ=;
	b=33dJI1wzSmGtEs0fJKB+4yGEFnzHJ7DkgHoWBFKbts3UGvLlVP8KlHvNHNFHuM6cnZyOma
	ovPHGQNA+LdrL3uRrUFFonV0+4PDS41AZlDTWEeRkFM65yUkqkFOGlfxPp/amj4nTnIjsF
	s3YjHX+wY6j6rgB/ZN88Lr8wpWCvcU0=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] setup: drop global state
In-Reply-To: <airVOrTboNDDGBak@denethor>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
 <airVOrTboNDDGBak@denethor>
Date: Fri, 12 Jun 2026 10:06:35 +0200
Message-ID: <87ldckyygk.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> I find the additional explaination here quite helpful. Thanks.

Yeah, hard to follow series looking at the code only, but commit
messages make more bearable.

> The changes in this version of the series looks good to me.

I've only reviewed v2 and I agree this version looks good.

-- 
Cheers,
Toon
