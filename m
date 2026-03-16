Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B323D0926
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681293; cv=pass; b=MLlxK7Qt4DA/fh0vf3JBlN9Z8XcEik/VXW54yNQiwjf3U5UUdPogQJzf9UosnDHwq03fNo48RabJspuQXFI+RLu5H76ealkMULD+54foDZvVohnU9JYG4bH8hPTKjwKq4CyNjckwqAXMOFhJFRDnbV51fk1HM+P8/FolrNveoGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681293; c=relaxed/simple;
	bh=iuvARXatamstrWVQctsLcM2NgcNR+mTtKTKz2gLrnrE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=kiwbY3h1sNvCrgz/pfNc/j7CyviGj+kNvr75802Mx8BmDCzkla0fy0O5KH1o33KqIu+XokltQ938FUUJonusIiOoIAI9QijzAPJv0rEzCmiULaR2IylEReV7OZCgyniVfFZMDiTH98AsituExW4n5CGHdoSFEDGr6TWimok6pKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b=lFobpVjl; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b="lFobpVjl"
ARC-Seal: i=1; a=rsa-sha256; t=1773681285; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TSAGYq6tBjjXjsHoabGnrZ32CRd6CipivEp1voywLIck4jNOqViqX2kCrPItYtW3xG/+7Y6lQSSdquyDT6UfvcFXGjBQHgt6jFGDkW7ziSRkRVrJNdqauo8gQKG728ISjsmQweMbwbkMinWw5nQe7WR+7yX3R5KkFJRF4UW8hOc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773681285; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iuvARXatamstrWVQctsLcM2NgcNR+mTtKTKz2gLrnrE=; 
	b=MuFw8D2leqQKg0DdhjTxFxu0TuFnfzVLuL70mFNjpzR9E0rt1AA18avj1bD5SpOeC6a47AcWCSfj5ITipbEKyX7h0dAMFHD1BA3cNzuxuPHfPHqLhCnl5rWwCJf5doP6AqSJ7UWIw1cXSLXVtuvcY1zvC1D1PulFyjranfx5A3E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ritovision.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773681285;
	s=zmail; d=ritovision.com; i=rito@ritovision.com;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:From:From:To:To:Subject:Subject:References:In-Reply-To:Reply-To;
	bh=iuvARXatamstrWVQctsLcM2NgcNR+mTtKTKz2gLrnrE=;
	b=lFobpVjlB+VJn2N/MzpqM5jZqBBdEHSPC5Ijboh8JtFnBrwfOv20qYqikegDwldA
	CPsI8cKVSpG42ciTKvW2GRkSCMrshxgmU9RmFxOO5MmkJvQJClJp+u8ywMZG0AZncer
	Lg/T8q1yiWaX//aVA4kTZAETvseKGaolx/nsgOq8=
Received: by mx.zohomail.com with SMTPS id 1773681282614210.49128761251745;
	Mon, 16 Mar 2026 10:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 13:14:39 -0400
Message-Id: <DH4DJF6XZZKI.15LZYBZ6MLWP5@ritovision.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Johannes Schindelin"
 <Johannes.Schindelin@gmx.de>, <git@vger.kernel.org>
From: "Rito Rhymes" <rito@ritovision.com>
To: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>, "Rito Rhymes"
 <rito@ritovision.com>
Subject: Re: GitGitGadget's website is responsive, how about kernel.org?
X-Mailer: aerc 0.21.0
References: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>
 <20260313-loose-whale-of-speed-ccdbe2@lemur>
 <DH1OK0NDO2D5.1BKGX8J7KWW52@ritovision.com>
 <20260313-adventurous-lemon-unicorn-278ccc@lemur>
 <xmqqtsuj7mcf.fsf@gitster.g> <DH2ADSKXNCXG.2DM7T0NF5NH59@ritovision.com>
 <xmqqv7eywe4t.fsf@gitster.g> <DH2QEESY177X.15A2VGNLZ6EIC@ritovision.com>
 <20260316-abiding-cuckoo-of-chemistry-ff2eeb@lemur>
In-Reply-To: <20260316-abiding-cuckoo-of-chemistry-ff2eeb@lemur>
X-ZohoMailClient: External

Okay cool. Will do.

Thank you!

Rito
