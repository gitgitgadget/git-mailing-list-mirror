Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB27BA4A
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730265223; cv=none; b=kHT5Zu2XzMgf0YNtUbvIfULo3kg+uPNw/OW46gQre6nue+vZeL8BDGKkCBPGq+QSJoxuxXE+LwVccKNU8LoFkB/Dp5zpNm2XCi2+yBT5Ql/lGFsCwPIeHkDF3IDOiuZZhk2P0NOAS8iRl3mQirwaedH5uhzGUU+QfNlNFvkwleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730265223; c=relaxed/simple;
	bh=VvlfRoBjOCZSSTI5sHuEHN+0q0ZMq1PPjZzbtG5LFh8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0iHF/qHleBUmriwOMTNKxCzo8y9xatlz67sM639tgFfoUl2UkNQBoFdBuSwtIPI4eKAnYRvAu0qzNSkZp5FyotPcKLaUduVpEi4/C9AfsjRBoa4hx6gag/jgfDxkLd8h3AiBcLm/BgfdA0UhYYHML5/bFrrPU6KD/q60C/gv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=EGXGf5bQ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="EGXGf5bQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730265219; x=1730524419;
	bh=VvlfRoBjOCZSSTI5sHuEHN+0q0ZMq1PPjZzbtG5LFh8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EGXGf5bQ6m9tJ7T37lu8E6u5I45g+bsLTwCvGNbemr3nlazR4XbihR7NXyW7BpPB+
	 V46oAcd35XYbk6r3O6f9UZlLU36p5Op6brWiszLTlumRJhHUynXjtzV11FKAZJxNAd
	 Yu14O8QhjyY3c1f7UnbWL4s8dHRuD2si7SMaqKZdPF+qJ6nUUjeeqL/g18y7GXPojc
	 HLBOkF1/JZ4UH6xqW+3KKq57hQ3f/1VysCFC2OB/WIYS49ncAw7p4f/DtESs3bghY4
	 nzz8YcpScIOgAyaBNRkjwUVPUElZA5hVToXaVr3da4WWYKC0vPd8mLSf5wd2KztwI9
	 65uot8g0pOh2A==
Date: Wed, 30 Oct 2024 05:13:35 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/5] Allow relative worktree linking to be configured by the user
Message-ID: <D58VTT1HI35K.P2AJ7CC0FK@pm.me>
In-Reply-To: <2ce3998f-ea16-4fd4-9756-c5849d834b1e@gmail.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me> <2ce3998f-ea16-4fd4-9756-c5849d834b1e@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: df66fb3cf54ca960fc5f6f0fda636a7de9a12f41
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Oct 29, 2024 at 9:55 AM CDT, Phillip Wood wrote:
> Hi Caleb
>
> Thanks for working on this. I've left so high-level comments on the
> first three patches. As I said in my comments on patch 1 I think it
> would be helpful to re-order the changes so that the extension is
> implementation first and then adjust the implementation to support both
> relative and absolute paths before adding "--no-relative-paths" to "git
> worktree add/move/repair". I'd also like to avoid adding a new global
> variable

Thanks for your review! I appreciate it :).

I'll address your comments on the first three patches and get back to
you with a revised series.

Best,
Caleb

