Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF3176AA1
	for <git@vger.kernel.org>; Sat, 23 Nov 2024 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732340723; cv=none; b=e4Yu7tFz9QHA/rY8HJxgvFhH/QAM+W/Cp1B5w7KtSM8o/R+wOPojmeW+EcSuRXoNokyA8rx/bDDQfFPDbvKYOIfcQm3RVZ/L9cbPDbJEgjnr4mPblxMMaTIYt4HBav1Qg0gVXJE5doV7IJQJEFSOpvrMjc/6EGitTksHyxHbutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732340723; c=relaxed/simple;
	bh=2GEb+eWYPlr6OvZC4Tx9UfFUyRPEH+F5HYC6RJBgyCQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcyePleUt7G6z1sXUuSTBA1M7v5FPvr5dMOP4k2vXt8vYtnttf7sf182ivf9lJVg/WVxTskE5wYDQ9raFtOpVK1ygITCdVhy4fYVb128dV0c6JTX6i3PkGQ6wRsgTtiWSazap/1QozQfSeJWjXduBYFlnE0QmB8vRIaUsBcf0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qhExDg57; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qhExDg57"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732340706; x=1732599906;
	bh=2GEb+eWYPlr6OvZC4Tx9UfFUyRPEH+F5HYC6RJBgyCQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=qhExDg57FXjtmR2dAc9TVavLKAZDSuPM2/HCkeDejk3j9woEvtoYm3yQ4AmQOz/gK
	 mBsf0x4OnAomYtJArBFwC6zhl4ImZofKOrMwtIS5y1WoXFkqh7YxswRD1+tlj6eTpz
	 e15VGoLsLAKb4Fg6ACS1FtadvSunI6MLi3aqweSEayOzw3Lo84HxCgGOouZDbNuvjt
	 ndV1UCK+ukAo0eW2yYmaNLGBJYgAOY9J2R3QMqzbempRn+DioTYs+mC6hzBogHiJ/C
	 a/fzbbb+K7xDiVP+LnLGcIdfznSCYplIyaOGrAsIFqiJPXtnyYm1wAdVXXUc71eg3a
	 q401xtOgCQ4gA==
Date: Sat, 23 Nov 2024 05:45:00 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/8] Allow relative worktree linking to be configured by the user
Message-ID: <D5TBIXHUMTGL.16V33H0O4GTWT@pm.me>
In-Reply-To: <db700d82-c775-4e0d-a171-9caf6489a3d8@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <db700d82-c775-4e0d-a171-9caf6489a3d8@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: b597e47c79f963a0b67731b2bff1e49abb71bee0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 22, 2024 at 9:57 AM CST, Phillip Wood wrote:
> Thanks for working on this, I've left a few comments on the tests and in
> the last couple of patches there is some distracting re-factoring of how
> which strbufs be use but fundamentally this series looks sound to me. We
> should certainly try and get this merged before the next release.

Thank you sir! I appreciate the feedback and your time---I will re-roll soo=
n.

Best,

Caleb

