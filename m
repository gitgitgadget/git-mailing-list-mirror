Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFECA3208
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751814474; cv=none; b=e3UlPjy0zqWsduE0JLA1Gw++qhqJRJXIOXnMuOvj7sa44lsfz6wc3TdnY5E1X62b4l34tEeN0TlNE7STA6r6SLCsFc+btTIJEKfn+qtdBelv4gGaYN3eGLt2mRm5xU1WYkp2rRZ8Y9Nyf1P65UoAhbl6waVsqA/vU+svijsJ6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751814474; c=relaxed/simple;
	bh=2rUUjTYy/G/tAal8+gKykAMzRYiNFuiDQcQ01dIE1xE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctq6VgRdWPVTWqlB+kGRbplI4SCqr/Q5oGmDhDfe3IiUWqedbwW8BqWMXyGYSouFioH1UhiFtehQAIvXZ5TMkIXo8RExNzgG3FKzn5D/VNcroPA+j9/LKZT+oZzpSh667mZY7BDQ7wM8/wVnlT09reYC9y/SfR3lUsbq8DLc43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=BE96Rm7I; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="BE96Rm7I"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:13:fc41:fd1a:ba1])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id AD243B00576;
	Sun,  6 Jul 2025 17:07:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1751814463;
	bh=2rUUjTYy/G/tAal8+gKykAMzRYiNFuiDQcQ01dIE1xE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BE96Rm7IjKl0xkmpbgA1PGiukG1bpKZKlruupBWiZ1sYXTwocO4X4Ulhe0p17aKva
	 xYXyVxDOwir2OIMkB1CgS+UBXP/YA8XC7uUCojCVuwC8CH58pI39rHhSqyhoXQepex
	 581DIpOcmExXmp8nF6TwpkwG9wU3IjeSjtEqaP8/iHzXT3IXuvDT69Zi7Tieew+JMz
	 4XUMPGIYhGyJZdOKy/EYHXgStZMiPJLBexAgA5qrpw8Xso7iyaIyUKPKaDhCA+xBeQ
	 rLUP1s7uJIPPCCXdERSwqkSRt7VKMxjTVRTjisYmPb1zZnMhEeTE5oQmdSV3qW5Ixg
	 pyoH4CalXHgjQ==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject:
 Re: [PATCH 7/9] doc: git-log: convert pretty formats to new doc format
Date: Sun, 06 Jul 2025 17:07:41 +0200
Message-ID: <13797374.uLZWGnKmhe@cayenne>
In-Reply-To: <bbaabac0-7832-40f3-b661-e9681cfdfa82@app.fastmail.com>
References:
 <pull.1933.git.1749373787.gitgitgadget@gmail.com>
 <bc18712a-8f72-4827-b47f-afac69ea6fa0@app.fastmail.com>
 <bbaabac0-7832-40f3-b661-e9681cfdfa82@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 4 July 2025 23:39:31 CEST Kristoffer Haugsbakk wrote:
> On Fri, Jul 4, 2025, at 22:43, Kristoffer Haugsbakk wrote:
> > Has using `=E2=90=A3` to denote SP in verbatim code blocks been conside=
red
> > by anyone?
>=20
> Bad example to associate with ` -> ` (=E2=90=A3->=E2=90=A3). But it could=
 work for some
> things like `:=E2=90=A3` in git-interpret-trailers(1).

That's one issue when doing the conversion to the new format, mainly becaus=
e=20
sometimes back-quoting the commands does not enclose them in a frame that=20
would preserve the spaces in the manpage format, what was done at git-scm.c=
om.

However, using  `=E2=90=A3` everywhere might be a bit overweight. It would =
be reserved=20
to places where spotting the space character is difficult

Thanks

JN



