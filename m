Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6C37AA81
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891751; cv=none; b=XNFJ1P3yMp59dKx0wPnf3OWmphJ0gYWkqUM+Dk6omUQUAtExzcElXgSBlBAVtEtEGzc64V6cZ0iK4Fk1EbkfxQttZwbUCebJY5fBD7V5Nn1LrVknywVGGwQdL4jTkddlfK6wMUoxtzKfmraMYWR0DYAWKCKC+PpJbThKB195HAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891751; c=relaxed/simple;
	bh=QUSbLghp2ywhVJxrDvsnB+EpD4VhTGyVC+pJLEmr4nw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sjmVB/BnKpSstpEmaImqd9WgjxqvdNpVTt/YyPzEKOqhVkhwbXmfbx7xWtN1Byii4b7/42UmyDvA+63ajch7R5+DHjGxzlpeDlkKuy8xgQv5a7cWuseMEJLXInKKjHAhlyPWpf+JhI7ujNnuHkH6RN46oJdb7T73Dy+E6rgcSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=T3Qv9Hfs; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="T3Qv9Hfs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782891747; x=1783496547;
	i=johannes.schindelin@gmx.de;
	bh=QUSbLghp2ywhVJxrDvsnB+EpD4VhTGyVC+pJLEmr4nw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=T3Qv9HfsJ/5K3XCZu5HzewGs7/R5Bh0UkteR1ntuDUHi3HYJIa+vX/5Sr+ba6LbM
	 AJ0i+9wKJ0jrGGWKKRbVvcGuNpLOVfEY2InQe+hmXr7DC9E1lz9dSMF1gKk800KrA
	 PjotamuYJaHKj/C7SKRXvU2U4G7H5FitoXFRQJ0QWS3AoFv/OW3QUMlyE2KrUr1jM
	 lxqWCAmwdbLHAOe+ws9aQtqLNTy4+Wkva9lqHzWIXJQJ8swe45Bg/oYTjJeUPfe+D
	 77BDd0YqHX+0M/jWBP20qrB1Jpl5ONAZ/IvCGzrijSTEAzI6oly6NL9h/vvj5y3S1
	 n0eWDmzWZ2T64lEYpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1wnOA00ssx-0032IL; Wed, 01
 Jul 2026 09:42:27 +0200
Date: Wed, 1 Jul 2026 09:42:24 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "2484937193@qq.co" <2484637193@qq.com>
cc: git <git@vger.kernel.org>
Subject: Re: After installing Git version 2.55.0.windows.1 on Windows, it is
 impossible to pull or push code using the domain account password
In-Reply-To: <tencent_7021B02790D4CB40EA0EF7A9E93DE4D48009@qq.com>
Message-ID: <4adfec22-a08d-bb4c-9384-c2b4b8f47d2f@gmx.de>
References: <tencent_7021B02790D4CB40EA0EF7A9E93DE4D48009@qq.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:CePNI979DCCy3FR8/jJVXwqL8h+NZ+4J8bCeVGz7ZYyx0tvNwJ8
 NZfkqyp1+gRNc89f87eOWzn5pMeAEpyEN9QdNt46JgiClek2jUGAD3clJvSF6kER20zCft3
 AbHKP8iUUgHRStROPk76emt2TVcfS62/z8DC2Ii/T5KTJUvoaxPe31brdsBOpHxhf0mWOCs
 W/xVUyjB/vaLvYiyI4bjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4MoZocCjvvU=;N8IvSyDuuZtU2U3vhq4eWuF/fo6
 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

Hi,

I understand that you're distressed, but asking here and at
https://github.com/git-for-windows/git/discussions/6307 and at
https://github.com/git-for-windows/git/issues/6308 is actually _less_
likely for people to want to help you.

Let's continue this discussion over at
https://github.com/git-for-windows/git/issues/6308 (because there is at
least one person on this list who prefers to keep Windows stuff out of
this list).

Ciao,
Johannes

On Wed, 1 Jul 2026, 2484937193@qq.co wrote:

> URGENT! After installing git version 2.53.0.windows.2 on Windows, it was impossible to pull and push code using domain account passwords. Searching online, I found that configuring git config --global http."xxx".allowNTLMAuth true would make it work normally. However, after upgrading git to version 2.55.0.windows.1, even after configuring git config --global http."xx".allowNTLMAuth true, it still reported authentication failure.
> We are eagerly awaiting your reply.
