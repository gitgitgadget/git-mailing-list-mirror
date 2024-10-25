Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76418C928
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842617; cv=none; b=ibEq8I7lFu0YCAVauQO9pDuWfTBQxrZW9oXsx4E/uT+hS7RM4PllNPJHFGS7SYQMwFmJypRvpRLeMiWZT6qJdAZny2wtyUkyFMKur9yenjp5/fK4sEZRe8/arMPTLTjqgYHx3vbcq+YJM/S4SZiqOtANGejp/23cidVjsfQj2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842617; c=relaxed/simple;
	bh=BqrsX/78BriQAdU2v+WzO7dBH0KrTT+rtoTsvzm0Qys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eEH/u1RLpuH+qfGJezwrmlauzPV1WZ9alvQGKPAedOaUl2DYBciCC5EcGOSFdnscjp5Sr607+Oz/eZXE38zoV6+KmBHxvEvGULMlpWGjnfiaNu6gZMUgNZTv0w86y6a51cEUN1j6TbLyQNq0JS1LC0nRBVcuzh7iYGHyBs3Lne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=cB4rYVUv; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="cB4rYVUv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1729842607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqrsX/78BriQAdU2v+WzO7dBH0KrTT+rtoTsvzm0Qys=;
	b=cB4rYVUvp1NtBRCPwU7WXQIj11iY3y3mfXANuruPOYnMhOogB4Tclrp1L/mLWg3RAv/sOE
	2qyDxsi3ZGtr+el/oJkhbClq46VXSTuyjh3cClUZ2S//N77nefVIiP9FL6TArXdRfJimEw
	1cMXTlHXFRoSE+iu3paBAYRhYFjKmqs=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.9)
In-Reply-To: <ZxYuo2ISSGRI8_J5@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <c1d3d038-4d5d-4904-b2c1-47b98d20a2df@app.fastmail.com>
 <ZxYuo2ISSGRI8_J5@pks.im>
Date: Fri, 25 Oct 2024 09:49:47 +0200
Message-ID: <87plnobp0k.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Thanks! I've queued all fixes locally, but will wait a bit before
> sending them out so that other reviewers have a chance to chime in
> first.

I've got nothing more to add.

--
Toon
