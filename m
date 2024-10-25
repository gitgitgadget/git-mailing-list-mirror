Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311B1B78F3
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889989; cv=none; b=WudDERO/TtHyDSDHE8iog6w8ND+A6vVfGTCxvCWOJ/h6ZBd213717euhhCC/jUJ8gW2zd66YQaiXtr5U9t2uLb668WtIaygkNVmIJaoHNuUSzTxA3rBVx164jNdxD+JWt34jPB9d8gQbWQeOffNkytyAo297IiyI7oUJQB6DAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889989; c=relaxed/simple;
	bh=hDZokUt9wK8BbRmZCjIPURe+K61p1nade6Y2D/jZi98=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+s9JG8/K6fIg2w2nGlg6QMXx5PQlwAa81Z2JgZVHu5tI2Zw+N9kfly55y5WNl64636fokZx64+sk4xSD3FaV3RRPpPLMUw64+DOc5Tzw5fnZqUGRSL8Iwn8GDwJ7AeGDmPSZ6gcrHMy4g3+gvZPHVIR7jAuivaQaYl4Cb0TR/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=VVwBPJrs; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VVwBPJrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729889984; x=1730149184;
	bh=hDZokUt9wK8BbRmZCjIPURe+K61p1nade6Y2D/jZi98=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VVwBPJrsE0jQoFFte4DuKHlIUhdPpOF8Q9X60T6Auq5dOA+uuUS41ZG/TcG1jXe4N
	 947bNx+5jZry+A2KGXuNIgtvU3OFzO0Gsb5NF28MWvZS7szTv0Z4kqGadh59WCHN1h
	 nszR5vvtNWCqCEDdHsEGxEGJMA9kfopaAuF7eXNTGRZ38Z4meW888DEi7+XACfdEaO
	 UmMw8NcT67F/Nt8XxOMNaWmpV5jOwB8fcWcisGM0ydYHm6pPdZXwL8g4+crk0DxepK
	 bzG6ck6TJM2g9dbe+4XPSFnJe0w3/zqLsip6jqAsRTlLFU3f7BMR6cT4ktU4qcOEUk
	 nMLYni468qDQg==
Date: Fri, 25 Oct 2024 20:59:40 +0000
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/5] Optionally link worktrees with relative paths
Message-ID: <D556TFZ8X35O.20C1EQYRMY3Q4@pm.me>
In-Reply-To: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
References: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: e875c124b0f3718426c97aa008615ab7a42aa660
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

My apologies, this should have said v4 instead of v3.

