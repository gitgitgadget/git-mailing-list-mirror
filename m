Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F61946AA
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349473; cv=none; b=nCYZjMGdVifei6JuzPyZn2GhcGLSny+QNOmBsIyFIfLs4bg/uvl4DJxq81KD5M2wIpSDtcqYPTgEcF2FjK1zBV2do/w2m1NtP1lskEhwAlYIxjxwIiVDYN/yOSx3Bgj99wZTK52qxr2cp/vtTAe7cIB0XNkR98AzgF9b5/I7Blc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349473; c=relaxed/simple;
	bh=U4g7ey9BLoc8QTHqBSigMVFiwCWCfRIQBwtdtvUixWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQa6lvnaX8HpJmr+t+jMQJdbhA0RhzsNf4i1ZqMpjQtoguZju7MPZGiHRPocv9YyYwdvPO463HlxZvd+5P+rCKZwCkKvbYVYAu/mkP2TVq/3gsyqYCnxFXQ3X8Cx4pxAI681WyVJbNHg6nl5x8ay0B8loqorA268b+7XKkgpSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=TJ0rENoH; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="TJ0rENoH"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760349469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4g7ey9BLoc8QTHqBSigMVFiwCWCfRIQBwtdtvUixWc=;
	b=TJ0rENoHnEKc/aZ49epBaB1ojZHgqQWFlM3idhsDvcBIAo7m8OsRlMvz9s/J2i4cxPA6Aw
	YC6AFd/ZUMtjSIvr1fGd3rxWqb3Wv6S4ETsJBaVbu3iv8Jei3tWAsbGN+5ND8XNnYw9qdm
	oSjepa99G8V2K7Ce0O6XB10+R/6S95yDkEJ8/aCIsBx5hklZCYnoAihl4EBXSoqgD4Bbor
	X1FxtXAozxkpX0re4mtps1RELyNBpohMt6VAtdhzapaleWl7jtvJ2ISDicYAT7di/GSYLL
	SeDncoGcwZLRsnANbXbLXQoXVeS/HlKFMoD8L2kVfw5+lcisxY9J0QEngZehMw==
To: peff@peff.net
Cc: git@lohmann.sh,
	git@vger.kernel.org
Subject: Submitted patches for "assume unsafe"
Date: Mon, 13 Oct 2025 11:57:37 +0200
Message-ID: <20251013095737.24203-1-git@lohmann.sh>
In-Reply-To: <20251009052422.GA1614343@coredump.intra.peff.net>
References: <20251009052422.GA1614343@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!
As a first step, here are the patches for "--assume-unsafe" /
"GIT_ASSUME_UNSAFE" / "safe.assumeUnsafe":

 https://lore.kernel.org/git/20251013094152.23597-1-git@lohmann.sh/

-Michael
