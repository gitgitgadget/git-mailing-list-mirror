Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CFB288DA
	for <git@vger.kernel.org>; Thu,  1 May 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746090200; cv=none; b=I1lRXYfCaWnkSVxce4PYKRyh3DkrJ35Gvhg7t8opgx2fzCTNQHONGq5QQzUHpPQO5K1OufELkxGtVhotqTQ+7ZYdIefgIbfRDPVsZ+L0XUv7qXixO4+KLVzLpFDkuOyw9Pk4jHuiO9y+xiK9wJp1lN8/xU0HVGEy1LFsQg3hIIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746090200; c=relaxed/simple;
	bh=EpbFgIa2wmjs0UrAnrC+iqpM75JCyW3GI30gJAoi6H8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fxfQLFlRX7/y6nypu/C90Ej33oBszqmM9IRzSP4D71kS4tYgzAN5/00rROS+qVciYpYqpv+MRt39ot9oV0g6JzHEkacYzBTKqsd1ppLPkWrzj7caq38HQZlScPSNUFEF8fhWTCDUuK6kr5mMr/0LSCMsojVWIv6norjFi8TgSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OMXjXV4a; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OMXjXV4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=izn3bmhffnfblbxtr55lui3ef4.protonmail; t=1746090193; x=1746349393;
	bh=EpbFgIa2wmjs0UrAnrC+iqpM75JCyW3GI30gJAoi6H8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=OMXjXV4a4FVkRgqZVpq4Hs/zKtPuaCc8sCTuwPJST9sFs8SwmEVDvRJl9dgFox8cP
	 fmVMUlkDlEzApEOpuI4FWQsa7IZS8pMdR99BMIlVuyQmT3nBoK3lQgE0OriPOJAO3P
	 5tYuxq0romRZp6vA6pkX66XOgVGyUOgBhnxjDbza2twbPfWia0MNKVQKXJdePJRRtm
	 IEz9meMs5GdPeVEuKeMAnM9uokVLsAvIw9iIWWVZZGjohU1eHajOGVkvRY22ibDgrU
	 IiynI7chHyDRdE6DOg0FYueWjqg98SbwhYDU9RRjOXzzAuf8vJDOeXEIrvYnya/rCc
	 GKAsOxbsd3oqw==
Date: Thu, 01 May 2025 09:03:07 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Jason Cho <jason11choca@proton.me>
Cc: "aclopte@gmail.com" <aclopte@gmail.com>, "gitster@pobox.com" <gitster@pobox.com>, "rhodges@cisco.com" <rhodges@cisco.com>, "rphodges@gmail.com" <rphodges@gmail.com>
Subject: RE: [PATCH v3] apply: --intent-to-add should imply --index
Message-ID: <93yuUC_Wn9lQIDzJuvAWbCQ35kz1YxeNhsLLX67x9VzoPtRugVLNaHC_p1sWBzMxWy_VVRRl8av3Dx5PHw4_Cch0gmWs40DDrZRaezLVkGk=@proton.me>
Feedback-ID: 126703824:user:proton
X-Pm-Message-ID: 795d673ace670df7f4c0e8c36325d38ffd725ea4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'm following up on the bug reported by Ryan Hodges on October 26, 2021,
regarding the `git apply --intent-to-add` command incorrectly marking all=
=20
other tracked files as deleted from the index.

Johannes Altmanninger submitted patch v3 titled "apply: --intent-to-add=20
should imply --index" to fix this issue.=20

Is this fix merged? If so, which Git version includes this fix.


