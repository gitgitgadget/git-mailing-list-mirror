Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6C42A781
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234164; cv=none; b=lWsgagE0c9HE2KZ8rn4u6Xw3HZCj+d0z1ddrGbWA0WW4iGLX5FSaXddQltwOC7ipZ9gRYyT+Icn+vzsGfFS12jX7EIoEIOI1Lj8jL7f1a92Uifjc0L40Ulvq7griXhD3lgwySSX9/TL49s+R6DOlFwek7mYJwDyC6bzzGbFeG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234164; c=relaxed/simple;
	bh=uWKHYZE9r6kkbMEU7ljseve3LMW3Swo5zflQyV9CjOw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tInaihftEfHjR0j1gRf6Av/YV7DXYMqL05xQOt+XTZNy99lJzBEbNsicljPlDIkW1B120OUMfkP991HHe2m/EO4fcAM64ytTmRK/h+rNICNQSPVjMmbJGwN/YFK0CA2Z+h0fAK2bMgK+OghaP3O068c1lQxY0YyOISrEQl7BJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=mrx2S4WN; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="mrx2S4WN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785234159; x=1785838959;
	i=johannes.schindelin@gmx.de;
	bh=uWKHYZE9r6kkbMEU7ljseve3LMW3Swo5zflQyV9CjOw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mrx2S4WNfewiGvhKcYN2DQeGdFhxuEXDUOkSaQwkNQF1QPatIfJFqk3zAOrDOlQy
	 0e7pLHtjtYstS2Tc1SR8cfD29RCkNSQY1zySfWZ4+5+LbfzyHR4hMbr7rWrIzRNBF
	 /N+nr5cVd1rpJ6OZZCCKRvcEl06TG0KErYnQaJG49Cvi8wMbYHOpNG9uUchciiqLk
	 178DMSLj9LpDudFpfWZC2/wGnXkUx+CYwbRKYpoe9Gv3OqDNOODlllXcskxc8oks4
	 22qo8n6Pmg7M/SR/U3dLDgEyoaw0tiaIrNT40OLUlLz7Rpd/qh+NElswC2Ns2ZDxN
	 hAKP3gyw+s23jchwzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UZ6-1wpCv71TVK-00ELhf; Tue, 28
 Jul 2026 12:22:39 +0200
Date: Tue, 28 Jul 2026 12:22:38 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Moksh Goyal <mokshgoyal616@gmail.com>
cc: git@vger.kernel.org
Subject: Re: Vagrant + GitBash Issues
In-Reply-To: <CAPpxU0jSK52Z+dtK94Ca85j4B6mKWfqypVthaVUVMT4+ur944A@mail.gmail.com>
Message-ID: <10584b07-143e-f612-f6d1-6787441a333d@gmx.de>
References: <CAPpxU0jSK52Z+dtK94Ca85j4B6mKWfqypVthaVUVMT4+ur944A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:evxNhxUZ4XlNGGOr3e/F30v0tI4qvMggqXvGAxrZAcCD/3IpXXV
 79ZJcAQLMr2lgc+2JRrM3HF60buu4w83GhsCLgQxJUCkpyG/IxONI2p4m/xOAbN3PZ6IM/r
 ZhWp62UZ82WfYn/BEaABnlernF05z4/uGM+sn7q4hPsfQ4RFbDDnhIc+4/nzhC7NbhpUXR4
 Oo6q4j6NbK+FJdFSYjzMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dnsz22mA0SU=;7nPi1fWE8yBplPDWVk8uHfBz5ZM
 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
 QVBuwS8xc=
Content-Transfer-Encoding: quoted-printable

Hi Moksh,

On Thu, 16 Jul 2026, Moksh Goyal wrote:

> Hi Team,
>=20
> I am currently using Vagrant and logging into my virtual machine via SSH=
. I
> have encountered an issue where pressing Ctrl+C terminates my SSH sessio=
n
> entirely instead of just force-stopping the active command.
>=20
> This setup works correctly when using PowerShell, but the issue
> consistently occurs when using Git Bash.
>=20
> Do you have any suggestions on how to resolve this?

That sounds like https://github.com/git-for-windows/git/issues/3716. Are
you maybe on a very old version of Git for Windows?

Ciao,
Johannes
