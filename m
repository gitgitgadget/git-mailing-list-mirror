Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092295474F
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384742; cv=none; b=VaIP2C90QQUuRfAc6lEknHYXCd6Tmbd/NOc+Hv7B7zP+uCfr3W0db7PBhq9DWKXMA5iGizSFIsqEVq17GmW7m5dRhA9enaDi1R/+dGrR94ax0sFrv6K7ZTg0mM/VDiJoHS2y5l2acKa1ocDeThdj5U2THoyFYpKvxE4SIwa9KRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384742; c=relaxed/simple;
	bh=idh/mYQh4iMqiZER9/fb3w/i3NY/7jzDsZPGIABdwdg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=E2Cz/b+dE7iSm2Deu5yrRj6GNImC0igK1cBs1RchwE8NGHLMOGoIuJhjEfCVFBpgEkdJWOt2wd28yqWQ3GYWB/IOqGOQzHT5QtHUWE+IlwQ2BPx7ZTZqRp96EDx40M4uUR/N1Y6UwMg7I97FVfBe2Gx80PpZtLu4FttqgCA9s2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=t+PNDcmP; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="t+PNDcmP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773384735; x=1773989535;
	i=johannes.schindelin@gmx.de;
	bh=idh/mYQh4iMqiZER9/fb3w/i3NY/7jzDsZPGIABdwdg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=t+PNDcmPde9oK7BkGyViTRqCDG+KybNzBNkKz2bnGESqTBCSHiOZKKbALcBhNcZN
	 XcQPT+WyW0TyAiGEZysBIU7Yb/zqb4VrJJGbQIVBarTjB779oDU76/a3MJC17618R
	 juTA2zB4WPk+82/FfJuFfzD4E3OgCzTkM4QTJZaKLLadVYXIjnFql/mzDtB84A6Eb
	 /XstVORFrMLOOLSgBfLSNG5+Dq+e/9iMY0iBv39wXgOpRgz4cR7RVBVbheYAIp1T9
	 b72EJfQgfyS0FvSG2UoPKNsu6f0e+jjQbsiy6YzdFibiphe97iJIhm4liFZgJZP5N
	 cReKnffGfeGk0wcJag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1vfg8B3xjR-00xeVc; Fri, 13
 Mar 2026 07:52:15 +0100
Date: Fri, 13 Mar 2026 07:52:13 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
cc: Rito Rhymes <rito@ritovision.com>, git@vger.kernel.org
Subject: GitGitGadget's website is responsive, how about kernel.org?
Message-ID: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DRmeTqoy03ztHeqgrVYD1cuVQCy6CP3HNmGUkJ7RGBvxJsHHENT
 LZVv3owlp5/uxRvw80q7S5qZkS9nzkUBrOJ0VMasZkDkIqMGks4yZwrjw2ABNLfvuWGFfbm
 M7lvJhXn5wj+w1/fcjJGACcyuLL1glvzJU/uErB/r1rbjesBfymazHbv3EZvbnHsPYrzuXi
 WiByHdAs94cJbC5CZ+Fvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H+D5cvQO5yw=;TEhICoqGoUEhJDsu/TbdZK0bo2j
 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
 /lSMCESoSX9gEl+Qb+N4

Hi Konstantin (and Git mailing list, for transparency),

the website of GitGitGadget was made responsive recently
(https://github.com/gitgitgadget/gitgitgadget.github.io/pull/26) meaning
that it will look good not only on a desktop, but also on a cell phone.

The same contributor (Rito, Cc:ed) told me that he would be interested to
help kernel.org's site become responsive, too. He even has a live demo at
https://kernel.ritovision.com/. Interested?

Ciao,
Johannes
