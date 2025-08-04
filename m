Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D8D8F58
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316341; cv=none; b=HW9G80ZcaIFNZtMz2p9yIRuHje2mjfjqAZ6+/QikGmDX1oah8Pb/410xvXRXjLGsorg3XB5sTl8q5wF6kPGrgsWFL/OML4el81RHYatOdE/EkbBBllznM+Qkgwt+qiS4mCVsIkUiO/1KqqQwZNCGrvRiZz73fG+FfFVk7yYvHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316341; c=relaxed/simple;
	bh=q4lb6vlf6razT+yXWZIJUYdzUlshpDaOHkla4mRg8po=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpiaW6FNDPaHNOfDCfg8foSxaohSNF2jQyxHG91nyJtq5ijpCjbZpXrWsCBMw+eDhZ7rDMQHW5M1mmzdk1REmUPEid/TU723hnyPAhVjlS3Py2Yg4p7XiVWgHDPNGWzPcsNHEu2FTm7zyniv051w9+so1/GaGH2NDWa/HST6FeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fmorschel.dev; spf=pass smtp.mailfrom=fmorschel.dev; dkim=pass (2048-bit key) header.d=fmorschel.dev header.i=@fmorschel.dev header.b=I8orMhbK; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fmorschel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fmorschel.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fmorschel.dev header.i=@fmorschel.dev header.b="I8orMhbK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmorschel.dev;
	s=protonmail2; t=1754316334; x=1754575534;
	bh=q4lb6vlf6razT+yXWZIJUYdzUlshpDaOHkla4mRg8po=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=I8orMhbKs2r2AK/sZkh92B3nM3DDe/l5h+8omx9iX7Ce88y112NUJtqoKslkoZlK7
	 nuEdmJ51sDlH9ytZP/xkhmMRY6tcFKn5mEm4aQsn9I/Kvc5GsQ1GTY9h17oXLVkmcg
	 UVJIvT2YD5m5R9Gw4NFfkRDjaEXaodUiJrL3zaLzthDi6ZceAq0uAjrIebqaUAB0xg
	 ueXER8DMKF9zLEQk8qPpPi28ibfte2PFXmK2o4tObg2c8hHv7bXfYMOGlWB1PC2/gj
	 zvJJIHPcKnPBYsL+dYMzREDjKjO5CEzCearBb9v34lZ/BFo1iqriFrKf6Z9Y80/wTo
	 fNuNK8f0k02pw==
Date: Mon, 04 Aug 2025 14:05:32 +0000
To: git@vger.kernel.org
From: FMorschel <git@fmorschel.dev>
Subject: Feature Request: git mv --after (new flag)
Message-ID: <2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev>
In-Reply-To: <0afc01b2-11a2-4f77-a858-7a444e8bb1d4@fmorschel.dev>
References: <1fa7a8d8-3ae5-4913-b3b5-21d8f67e567d@fmorschel.dev> <0afc01b2-11a2-4f77-a858-7a444e8bb1d4@fmorschel.dev>
Feedback-ID: 127627349:user:proton
X-Pm-Message-ID: 9817d62f1bc9b49fe738d38468249ee84c3d43a9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is a request to add an =E2=80=93after mode to git mv command to explic=
itly=20
mark a filesystem rename after it has occurred (analogous to mercurial=20
=3D> hg mv =E2=80=93after).

This would allow IDE/Language refactor renames/moves and would make sure=20
git still detects the moves correctly for keeping the correct commit=20
history.

If this has already been requested and I missed, please reply this with=20
the original request and consider this closed.

If anything else is required please let me know since this is my first=20
interaction with this tracker. Thank you for this incredible tool!

&#8203;

