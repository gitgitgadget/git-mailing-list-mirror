Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59EF3DB626
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637958; cv=none; b=fBrp0flApAIthpUxV+tp8O0U4g2jfccCcHjKrK/qN8OLkUkeUPlxYP3q6vJS0QFR7urgnazvw1wh0+tz2hreZTZFYa7QbzTfQI7rQilh8E9T9+b/4WMEvf4JnjoaQf0KsQM2BpwIzU7MbB9Z6C8w4vk56rBg8mkn5jF0Ud7MinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637958; c=relaxed/simple;
	bh=Goro8hWs2ABpO97g2fDu+7YL/t4C2HBjwEqetpyXhFU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ka3GvVQ0wZSPqbv6Loz9QSshCU7Jux1FEABLwZ1rQ4IJD9+QmGZeThd7CxkB8xs/3W6g0WPKXNuSxGAa0TF+O7A9ET8Fgr5FiLiCFiYxvKNai+gvWN6HFQZ2X4c/xlZAlh9NmVghUNVjbvCxqvVFyx2ey2koy2sj9rmM3QbunGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=marius.spix@web.de header.b=n15MExbA; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=marius.spix@web.de header.b="n15MExbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781637954; x=1782242754; i=marius.spix@web.de;
	bh=Goro8hWs2ABpO97g2fDu+7YL/t4C2HBjwEqetpyXhFU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n15MExbA36r/nG9603HaVi6GCAWo6mv/8WqWCT5Hn+nSe7GpY4l87Krx6BZ+OCN/
	 KahCxl/aSMODHCKcVk67q6Qm/ToteoS5NmnzMkyBpyYOQB5wd7Ar1zzEDrLIBsdl7
	 kO4vu7XDIR2ZUu4IJKj04JMkoe2HOQg9+tJqXwD5e1CzTZX9mrHsjjej1nOG3Mfk2
	 MtcGr0m2qblflRCbnUYz5M84eVkmLLxXoYL+rdu1muOv4hDmq7WPfKbBpMgC+PGYu
	 Ah/+FDoDrA2LUqIqiKQS+5rfbb0UJ2rVMZDwSjj19CvC6OWl7ebhJMUtInwr553k7
	 2lJaMTT6ZLSj4L1ypA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX1L-1x0cqd2oKL-00iHLh for
 <git@vger.kernel.org>; Tue, 16 Jun 2026 21:25:54 +0200
Date: Tue, 16 Jun 2026 21:25:53 +0200
From: Marius Spix <marius.spix@web.de>
To: git@vger.kernel.org
Subject: Assisted-by tag
Message-ID: <20260616212553.31ddea83@rockhopper>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Y5FdDZG7J8eW4fZ5eRhRPwMmpGsGIdrgf4AzVOEoXQukuLN1UgT
 QqtnddfWvmazrOmV3gnRWA8YnkNOq8D/ccLRtIA/QM5Gc81yfiJCmXhPUmHCWjP6W25tXhx
 m43/4ggfN6+MSxZn1YKddgKjIWbdKU/2j7Au1ArcaXGwnt4SEvCXghGIEFJUPi30lcMhGaM
 PvafNGsaqnpYhr7OGNxWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Lr3QSetMW0=;rPMIhjWWtwMdIuYLwzmYWzxOT5q
 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
 p1

Hi there,

as the Linux kernel requires the new Assisted-by tag for AI-assisted
commits, I was researching how git handles such tags. Thereby I
observed the following behaviour:

git commit --signoff
* adds an empty line before the Signed-off-by tag
* ignores the Signed-off-by tag by checking for an empty commit message

git commit --trailer "\nAssisted-by: OpenAI"
* does not add an empty line (the "\n" is not converted to a newline)
* does not ignore the tag by checking for empty commit message

Since there will be more and more AI-assisted commits in projects like
the Linux kernel in the future, this should be taken in account.

When merging or squashing commits, that tag should also be
automatically applied to the new commit message to make it clear that
the commit is tainted by AI.

Your opinion?

Best regards

Marius
