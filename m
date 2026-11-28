Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795851524;
	b=vGVTlwBKijeO0NYbXMunCBkse57/iUYdV4yko3VytbTRBG9utlXZpQ1GNhhclK1K6q00
	 dl2GTuhjruDK4FhoE6qDKmi6YRIjd8ejV1rdWf94TqxzWfyrS6C90NGc1cxMsivX7r7SD
	 dUFr1V6srXrhheWX30BrmxPVyiNACsChcdTNS36APUS95SMu2tTOvRhRp0m7TlcLeMRGL
	 PDaLezMpYQONUDIuotj12i3LuLglfyczCL/xy27VGgvrpg2asDIZnTCb/6/ecBaFmDeXk
	 0aiy9+mAY6vrt+wDbduUxCDKdPHWVvfKcZFHoJ3TmYNCZV++BFzim6lnt3hV8JmgWNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795851524;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:User-Agent:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=j3K6r4vJKeowTOsxZUV8/RLXJkjzySJ4z2UqbrB+nrM=;
	b=JF++8mg869kiFz8RhGCY8QrCUmfdQk2AeLa+EgiuIpaybwO1nl8ZWXkw0uGTCuJ02qdH
	 qZHgu27yyZbZijukZ7pFdvL3Uz2HD5GwG/cFG2avt0/RBjYP0OVsJBwMF3XCqNc0ukpXi
	 D2hYKgZm160CP7KT8toVqVDvUMYpvrIz2vY926BJYkcsir5iaMdfxuK2xXmKAj/IBfKWB
	 KXiZjJ1L1jJVt/EFXwLkm8VkEzDBz/sOoHIOqGIpjgkbhhDimIQlltZDtng1POG5QzGzZ
	 VNvSQ1gX0Iik+brogqpz8492wfyJLx2uibAl0BHGszMOxJsqicD/GBLhd9uIywFy+Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=MEYlUEU4;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76270606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 07:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76270606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=MEYlUEU4
DKIM2-Signature:  i=1; m=1; t=1795851521;
 mf=PHRib2VnaUB3ZWIuZGU+;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:RYzVNgjozOZBeYudXhb08otsgHny
   4veo7xcYkhrHg7ETETZSUSRYMdBZGq9B8PJSrAyY1aDtuGnlyvUFA6LGmzIJQJYE0DRf5RjI47N
   +v/TK8/m4OFRlLo5JomiL+CAg9lcN9uN80vwjHVyXRbfuYrZcJRGboavOAxps4Vip73Gb9rgPWv
   afNv2KDFpk6K2ayvivCSX/ylqezRG4+t319r3/Azv8b5bTOPlt+HKKaoMUQnfGX+LzgqETEJ8WD
   YaN52kcOaHUIpRXa3blbhKw7NdbIn0+dzXqwb2hTSPlWfHh6oVPUEJ8vQUNCrBSWjlXMkJ16QXz
   ny/3cR4RMHfuvQ==;
Message-Instance:  m=1;
 h=sha256:
   0lctxPb6Oy75bT4csiowGqllEpt+Vky2C8NbCfyuLYs=:
   WEySpcqqjV8i/EHvoW4y/KrSoJlVD83SWnnc1LxLeiw=,
  sha512:
   OylYmULXCjiPkc6YfacfOGn2AWoDt/dY/UctvqooKaVK+FRFB4CTXZPeWXq6WJSJA5RmpUEcYU6p6TV9HJHH5w==:
   ebEnoDwJ8lKfCJmdd1AxRQK46WsBjsRVYProks1DpHByht0K8q+YJb8ZWf9x2387QfbpEedFSyax+lBo4ZmyqQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795851521; x=1796456321; i=tboegi@web.de;
	bh=j3K6r4vJKeowTOsxZUV8/RLXJkjzySJ4z2UqbrB+nrM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MEYlUEU4Yld/n83iV0u6Yd0J3DmHTeUM2KCfrFazk/BjLfPCW77wop0hfHrdTrT/
	 MiPyDCneS9FRksoDILTcveSnU4eNMR4W8v+4l4ys15Fd5dNfvolecS1wgGItYj0tL
	 QDNz9w1ygale6bxd5Lkm5GsaLyFWxR+EdhcFCgTSFb1NaWc1ba1tmDgaeDMV5AR8P
	 qmsMq/vmkQaIHPRM2fQzZlOeCwo5e433YnZy/ivXVT4n2ozMxGmkZ6dQObW/FmucU
	 RIHaQl6/90CT+GnelGjshfOgsCOvai/NYmpmjGzJDPwTAzI5ywUUtHrBN1yllyx4J
	 a2DCesA+El2c7tqy1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWz8v-1y0D6m0vZR-00UCXY; Sat, 28
 Nov 2026 08:38:41 +0100
Date: Sat, 28 Nov 2026 08:38:40 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, curtis.allen.smith@gmail.com
Subject: Re: [PATCH/RESEND v6 1/2] read-cache: do not trust a size change
 when conversion is active
Message-ID: <20261128073840.GA23645@tb-raspi4>
References: <xmqqwm1no29m.fsf@gitster.g>
 <20261127194241.10085-1-tboegi@web.de>
 <xmqq8q2dzlae.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqq8q2dzlae.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:ShusiODFXxakRJI6LvLXb1uo275KkXg7iE81fdGg1Nl54NkC27H
 l4sc7j2hZTrWBIMOGmdUsINccKOYhWCTBnuaAdeYNa/nbQSaDgT2SBGJ8IYUrsfHQT3OJzl
 6mfIeDwZkmzVjL/a6Em7JAdRch/sw4mM9Rk6aVKLLrS5vgsTgwgitxwuW6xa08Qe/ra8+LN
 L6VZgAgPCd0m2cHQ9s74A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rg/4fyNiI5c=;nRBCwqrDbeVFO0F/UC6a7w0Gvpd
 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
 4cNhr4iLbg==

On Fri, Nov 27, 2026 at 07:28:57PM -0800, Junio C Hamano wrote:
> tboegi@web.de writes:
>=20
> > Helped-by: Torsten B=F6gershausen <tboegi@web.de>
> > Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
> > ---
>=20
> I would have pretended that the patch was relayed directly from the list
> message by omitting my sign-off from the list if I were you, but I
> presume that the above accurately records the chain of custody by
> stating that you did not pick up Curtis's message from the list but
> picked up the copy I queued to my tree (and later got timed out).  What
> we see above is not wrong, but I do not know if the distinction matters.
>=20

As a side note: There was no LLM involved, just an overloaded
HI (Human Inteligence).
I think that I digged into the code, but the outcome was not ideal.

It looks as I will take over the patch series - as discussed earlier.
Having said that,
A single patch combining the current 2 changes makes much more sense.

While probably the resulting code is in a good shape,
I take the challange to come up with a good commit message.

Thanks for the review, Junio.




