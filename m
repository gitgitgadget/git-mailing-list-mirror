Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DC33506D
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769441569; cv=none; b=ShKOsW2uKFVWtk1iWkUy/q+ZFyDbgyJ7mWLskYh0V4+SFWswKn6E72ejGIEalwz4oVRjiD968ffpBNtAF7R4Wx3nemjD8/GjPg+exkhM6QDugkpKaekK8xAWxSU0BJHvwpJXkWUIIeAmPGbKgENF1yA+M8EcZgjsYm2LVziefyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769441569; c=relaxed/simple;
	bh=JX7IkGJrjO5F3bN/ATF/PTauZfWH5hdRh19UVNl+WpU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qU27CA3kSAYNfUJonvP165Iem1ArHURk7Z6D1lqPkTKl52AcvRGgfgmcnAHCmY+2TsJQk5vdtJugVXnk3bh9VJYotv9bgLgyLkIfMjvqFqpzzecCquSA+vIQmiKeFgeOBHUKflkO23Ja3ZNgbeOxZ61XOjVFCHo6A7jWMVpQziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OX3dvCHw; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OX3dvCHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1769441563; x=1769700763;
	bh=JX7IkGJrjO5F3bN/ATF/PTauZfWH5hdRh19UVNl+WpU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OX3dvCHwchOYWjn5IIwLwkcR4PyGuKOFyGTyGhBCjzifYL4/+oDg9pub+5fj9ZEBf
	 Yl5rxHYTLjs1V3VlOOtXfBFRCNvp82sz9lbmWHjkThKlG21qz2juxV+i4cug2/Jfhm
	 2Hrt9N/2vo/Zss+6kyDw4L+pbR0GGt37fmU+KcGrL2Gw9eoInsfAcfw1ywuJ4lGd0N
	 AYy9EmNEt8O4YpeR7Fxy/Q/TOdR9QGkRH7yEVGnQe1FIyrVWlmaFrfPTuEl3wdNbkg
	 Q5B26eI1jB0yVyLHwIcb5DObzqiPxPwkZm11qA77YLdsb8Bo2FomUUmxx55buAcSP7
	 gfAnLXvfO4N8Q==
Date: Mon, 26 Jan 2026 15:32:41 +0000
To: Johannes Sixt <j6t@kdbg.org>
From: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: git@vger.kernel.org, Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] diff.tcl: fixed alignment of tabs in git-gui diff by using spaces
Message-ID: <fOsJj5fE2gNmoO568x1CpXIsgppqEoG3Olvz7Ze7SMjaaephgqUdNARafGPNwDSAFSxRFNMMlRvDrD_dOW7ARFLxiJpgXd84ezzOwnKZBdM=@proton.me>
In-Reply-To: <5ab10a31-8ee5-48f9-a5fd-63c6d7f4adcf@kdbg.org>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com> <01d0faaf-99fb-42a4-befd-bb7f359809bc@kdbg.org> <Lj9kojJwK1ZAtvE5nj6rTq5EXf1-QhsRlmBDM9YntbYeWb3J07mlbM-njNco2XT1pSPXsNVbo9Uc5kJOHihb11odjthYN4YtuhVdNwxSIqk=@proton.me> <07014d88-67ed-498a-8cc1-423c77972fd7@kdbg.org> <sYbEiapPid30QZ89paQ6hF_v4BjKnAqUTOt_ImBEfFYBlMVU9uoGwZbKqSkk7aZVxGPrqVXbb58Ogppnw0gQEbH1gwRfBmx3HC2AECWjGkY=@proton.me> <5ab10a31-8ee5-48f9-a5fd-63c6d7f4adcf@kdbg.org>
Feedback-ID: 177675452:user:proton
X-Pm-Message-ID: 5a9943b2c2066789090116379042334893f30314
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It appears inserting "apply_tab_size 1" fixes the issue. But I don't know i=
f I'm inserting it in the right place.

-- Chris


