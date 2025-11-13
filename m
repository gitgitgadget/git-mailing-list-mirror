Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075262DCF46
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763067817; cv=none; b=oGWgiQSL0bHUBbLmwvErsIXin9HFJUjcNgw1C1sZjTJgzk9xg1bclTbzKuhSbQw18NqoIV1/Rtcp9XhacodK1yQ69fEwe1V0kDa2/uGcXUO9aypH2Wi5yAVePdw5fx3+10JSTruaIhdHkYU5G3s4XFyyQaqgKa7Ce3ui4kH39nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763067817; c=relaxed/simple;
	bh=VD8LsI7tvqJrHxpf+EJXHjiwv7iBbHRUCKchNZnPwxc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s5R7ZkB9Wz4vN/S8ve9twceonCVk9rBSbToAdHrMoV8veyyNZ7GLlrhOKMdkNXH/m5FyxsQ3ezDDpP3m6Ld8l2OEDwHXi/vaBOuizZq/7Ii5SXxBQE5Hrt04pMMGQTkb+VGbdxaaz567QFFTblFa++eSurkZ7TgIlc5LoZkwa/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=edi@gmx.de header.b=SxcAk83b; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=edi@gmx.de header.b="SxcAk83b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763067813; x=1763672613; i=edi@gmx.de;
	bh=VD8LsI7tvqJrHxpf+EJXHjiwv7iBbHRUCKchNZnPwxc=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SxcAk83b1gIHbXUBP8P/nCaAWhMqe0j0oX5JGHEE7fWhgAjHM3zA2rYpuZA13+SQ
	 iueJVdlBO/Mbosz4OQyOp4j4nSFGf3hMEjSHiQcExIrdAuaifJDDUOWUuy4wM6RAZ
	 6CITbmHZvAfP/U9p7yfowC5pl8cyavQ0gbtysmW3ku5md7kpCQE95336wb9qgoudx
	 gpuONAvzuICmNx60E2lYiib5qXVft0yqjZROzsPKYK4I20bx+0LNmg1bzZcdFeBxW
	 w7roCCaG2Y6wHsaRSOioXJBVE+2Li9LtBgYG0pDZtTYH9294izhUHfj0mhOEVYEbu
	 y7RAjgKxT0GPEBVHUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from zombie.inka.de ([95.222.25.79]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1vYSLP0CsM-00W27e for
 <git@vger.kernel.org>; Thu, 13 Nov 2025 22:03:33 +0100
Received: from ed by zombie.inka.de with local (Exim 4.98.2)
	(envelope-from <edi@gmx.de>)
	id 1vJeTc-00000008nLj-1y2c
	for git@vger.kernel.org;
	Thu, 13 Nov 2025 22:03:32 +0100
Date: Thu, 13 Nov 2025 22:03:32 +0100
From: Eduard Bloch <edi@gmx.de>
To: git@vger.kernel.org
Subject: I still use whatchanged
Message-ID: <aRZHpI7uvNeHTD63@rotes76.wohnheim.uni-kl.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:3jhmvZoAT75A0odV0se/HWJK+kl6dbLPIDY+V06FAExqvp4GE0T
 KtfbetIaQ8CcIgov2TJ1zmNqKPmLbGBeOHYswM+jHdYaTWjhfF6a9aZLZy/SgZv5V4mtwyO
 rLwaM74rWqd8nN1eJ7OZYz7VgB2NUsE6+1KDBVYoVhT0hv0Zf3uC1HDc+RjFMgbGsYQipeZ
 s8J9FYJzQeI8TqJtHdsww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wgsiwMjRXNo=;lupCtJKvM47rtcKMPfCuu1GSm9S
 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
 XqvImdJIXCgJLg==
Content-Transfer-Encoding: quoted-printable

Yes, guys,

that may sound totally ridiculous but I want my normal "git whatchanged"
command back.

Because calling it means typing "git wh<tab>". Just 6 keystrokes!

And what is the replacement call? Jeez, this dumb message about
"--i-still-use-this" should have mentioned that detail! Now I had to
google it which was not great UX in the first place.

Okay, the replacement is apparently "git log --ra<tab>", at least 12
keystrokes. That is a clear downgrade. So, please bring "whatchanged"
shortcut back. You may print scary warnings about eating my dogs for
breakfast or similar, I don't care.

BR, Eduard.

=2D-=20
Every great idea is worthless without someone to do the work. --Neil Willi=
ams
