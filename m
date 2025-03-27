Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234613C8EA
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743067107; cv=none; b=FbkISU9r34AEsgQ4tSGb+QjZJpftu6zYOypHuDq+JHd6tvIgrGz6frHMet6dK61GRXmvT2hJvZ65ZO71y/ialrxTFM6kofhN7wtfSu+r2r7wv9GfjYQFlF7bTw8T/Ol7XeMm94Ndmszayt8KtqoxQkWbLlskHtbjALWWNZ9Ccn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743067107; c=relaxed/simple;
	bh=W23qI2bshC/NT8FYB2KGPGkTSd/p8efFeArAvwclVGk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JpTfi6gCYhfOr4+lOcOai0QUWDuhlAdAc+n1z1F5W84H2c6SNkFKSRDBL3icYMXxF/BRUS8JqOslplYNNgvmg3ecKG1iA6AgmIU4P365cD4o9wxP4B+RazlYk7Km05VLp4Ks4wgw0UMAI+JJKp2gA0AU654/dq6a3IYjTlVZzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NL2JvzNg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NL2JvzNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743067100; x=1743671900;
	i=johannes.schindelin@gmx.de;
	bh=PD07rZDjxJD7SF4lC6KYne9Vhnv/Lb0VNdrcJWm8Woo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NL2JvzNgWVNwglNxgUf/ForS5a2sZLzJ54t7EtUspc7qkEiZPDSZqY0XCKFdNDyj
	 dyRyQedIsGviu1MTTCg9fx9apLwwYBgSzw7RwButTlKSxM+I7RZEUbD+ck8+8cOQR
	 jRD6pr6RThiXm22FJR8r3pn5wZdlo2kgVkx3y5u4WjZCnlvzYLcdbjQm/xfzfDJ0H
	 B0uR5tTVY4tksLv8jqKUqUuejAaqZY4RKRXkd8H3QEATJDcSkpSfIZLfrIt8iCXhi
	 3iAl12kKFhyBc8ueTSP0PYzevuBEPBgDpAhna3YmGxIURst7pRjBp5gY+afe6jgn0
	 FcMLFPlSF+gBUdT0ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1ti8If1Inh-00YMkQ; Thu, 27
 Mar 2025 10:18:20 +0100
Date: Thu, 27 Mar 2025 10:18:19 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: Possible venues for Git Merge 2025
In-Reply-To: <Z-Knm2WGeMI9a7zt@pks.im>
Message-ID: <82e04bc5-363d-9534-2d33-bd6cc1782e10@gmx.de>
References: <Z9vuiCnKcMRRXHOR@pks.im> <Z9ySGbE4sq0JfgKs@tapette.crustytoothpaste.net> <Z-Knm2WGeMI9a7zt@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gDFdWNiMAQMHGqtECfwBRlLy99XORoFBOAo2MZWYk4dM3smpZPo
 /UR9OiueBcTbUVkWuR4tSiuKEuG5IT6/TWn/ttKDMmYY1FD7pNemXM26gVm9zpn1Wfi+c/z
 Klc4fG39Nj7a+qwZC/T8Eog7rUUC/9GaKnKY7yQ53ymtR97rbdH0G8iaoMV2mSA6oAhCml7
 cvFM2xp+uTZ17P8nMPQVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X41ZCMMZX0U=;jyYGg5Ayjupv1+xsZfW4nFq2oN2
 +YqtgpBZuP7YAyXgirSxJwq2ERb1VLK1UHAFYQ+p3rjaaAVZIfvuubBg6kagkl9BGBoOhW3Gq
 POPhqFq60rm7uk2t6xzzrW8GXKa4Lu324N1PTY/ph31q97/K0rExhvG96JnuGiPk0alBD3qTU
 3xMUAH2jztvY14pByvxjHDD1S/IX9iT7/r0ay7QjMO+K7ylE1pqVCrE+E62K7olsq1eF7SS7Q
 WSvvnk9i5zJMnt3DDtgzTXHec5qG6Hugmtav6CgFgTgFaq9LFIYG4m/DautiysfXGEEjAoMfh
 LuIxJOjjAmHtIl9g7TbZkv4ma7ppd5Z2iBlMQGKw5QYgD+OwCrvDaX4tUDFWWj+QofVBIFpSP
 CYaqCAQNCctt4YzhDjKZwWw3puw+3RaruyeAk3WcuSHOSGrkS1Sp7DezKU7Zvkr9gYrMNK9eV
 1hn5DZF6PtDD10e/XfJXNf5+NUNs4WGGJ2jg6lBcGh/ftHRl+FaLrGNF+nMB0t3Izwv69CAg9
 qzdKiWVYh3b92Y4mOdelhgP2VrpVhvBBjDQDe2KTwHGqyxx3kBi//B4OXJNn5ALNaUZpLG5SN
 VFa5jdagCEgFb0r71XUaRTp9z0ES74ZsF24TSmKx/WdBEIefDcAobvMbWCZIrynCUJfN+rcdo
 NQPx+1ffteskfZ/AWrivof6ySLM71EdJD94LHQR4KhaCQ9sC//HFqAysN0/EicSYrcxsiy1bP
 RKWZejlmIBG+ZiPomYLm8ms11ryGBDQ92JmEqWS0TxdU2W35fIq0nVKBwKguytQ6Kbk0HaLVb
 tJTO5/32hWSO/9V/WU5nwUB6qmd/d7l7HITdTIFpibZR2Z/zgByzmOG/+Yz+m0PbF7tWmHEQV
 Q8FqnapbM0oxtVs9M/6VRQYjBB0rKpfJ3C9MTMCnHo3pHbSPSsoTsBj9mrhz063FYs+uNzSfJ
 CMo0aSiH9I3vGenpczVHDvKSh/GFOUbZjJBcoe1fhwIapFsOhYnr1N/uKtS7eiXKqdEsT0Nzu
 k1GrgpP5R4EaE3jDwYoh8ZUCCn2YCqrzxovG9IF51JPwTvdxc1eJj3dmbdYP6ZOi9RWgKrr5t
 2dMt2sCQqpc5Jc4IHw2Zj/w8tj7VCdKgDlubm/9TkwWT3oL9oD8rVsmWOy4D7gIYwjFSOD5Ej
 ilSmayXi4R6hyt1jNSwkjHulOIv/7XCi0exnp2LMkjUd7jLbEZmBLPIZK0NiwZdHUK87A45eL
 FM47usuQuh91qn68sniAD6sv/LspxapQHhrwXr8uCUIxE7YDqsltY3jt8rUH2znPKGAlPFoRE
 0EPDpH3CKAqLWFD34IVIn9rUDpZda0IeLSWDrMft2WXoE62yhWIYwEMKoaPZFiv3uI394hgzd
 Js+Q5fhSurwgaOOakjh+iwteF+HOgjmRnsPrjkICbTEA5FGolaVmNBJLG0l80QkH6Zt4XAnfj
 9SXq5CeCrzToPhBi6pNXeIjsTTn6zqTXjf1PMHhqbWp/UjEYo
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 25 Mar 2025, Patrick Steinhardt wrote:

> On Thu, Mar 20, 2025 at 10:09:29PM +0000, brian m. carlson wrote:
> > On 2025-03-20 at 10:31:36, Patrick Steinhardt wrote:
> > > given that this year is the 20th anniversary of the Git project it w=
ould
> > > be great to host another Git Merge so that the wider community can c=
ome
> > > together and celebrate. Taylor and I have been chatting about this
> > > opportunity a bit to figure out what we're going to do this year.
> > >
> > > We have been discussing two different options:
> > >
> > >   - Hosting in the US in San Francisco at the GitHub HQ.
> > >
> > >   - Hosting in the EU in Amsterdam colocated with the Open Source
> > >     Summit Europe.
> > >
> > > Typically, the location is alternating on a yearly basis between the=
 US
> > > and the EU. So given that last year it was hosted in Berlin it would=
 be
> > > the US' turn. But given the recent political climate in the US I'm
> > > afraid that many people would not feel comfortable traveling there r=
ight
> > > now. So in the spirit of being inclusive I think we should at least
> > > consider whether we may want to break the typical alternating cycle =
and
> > > host in the EU again.
> >
> > Yes, I do think that given current circumstances the U.S. is not a goo=
d
> > place to host events.  Perhaps that will change in the future, but I
> > don't think that would be a prudent choice right now.  I've talked to
> > several people who are uncomfortable traveling there, so we'd probably
> > get better attendance hosting elsewhere.
> >
> > I would be fine with Amsterdam, and I might also suggest a major
> > Canadian city (such as Toronto, Montreal, or Vancouver) if we preferre=
d
> > to do this in North America (since we've traditionally alternated
> > continents).  I can imagine other locations outside of the U.S. that
> > might be fine as well, so I'm willing to keep an open mind if a good
> > opportunity comes up.
>
> The only reasons why I proposed Amsterdam are the Open Source Summit and
> that I have some ways to help out with organizing the event over there.

Is there still a chance to have a Git thing alongside the Open Source
Summit in Amsterdam? If so, I would be interested in going, as I -- like
so many others already shared -- will not travel to the States this year.

Ciao,
Johannes
