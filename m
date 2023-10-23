Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5C21B260
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KxB9dxvb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HwI03W/E"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B95F10C
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 06:58:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 8B4F25C00B1;
	Mon, 23 Oct 2023 09:58:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 23 Oct 2023 09:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698069518; x=1698155918; bh=wS
	crZe5nupdlC15VrOQ8M5Xx+qE4+2zNeMyAwoMLKYo=; b=KxB9dxvbOV/lnNDaRK
	DQxkYmaY5I/wJJtckruMp/CTcGaPutMLBBVc/HP5FyEOz6tYmm7kQQ62+izga5h9
	D7w/ya1xvlX8FCfMhV/oFptOsgPS1CRd6aEZatTDBI8ARCMgkFmt1xnUJHozoXIX
	0FCzW3sS/u8iRD7yNj6vkrPkr3EwtAas9vInL5+yh003GGHOTJwlv7NxSyyRp9tu
	FRQ0UoSf5b3FwaOhmvX8wrcbIr6CvbSRHy1kLR7M4jHi4Z3dBGeozWpl5KF5+uF1
	I4UIV1rB5N9UyoA4wEc5JKeT16vlSHN49nIJkZnHBECKCmT8DrO8I64rSm5ir1kC
	tiQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698069518; x=1698155918; bh=wScrZe5nupdlC
	15VrOQ8M5Xx+qE4+2zNeMyAwoMLKYo=; b=HwI03W/EQi7twKQFpsD/IC+mTJJ3C
	196+lAON6fsC7NtS+5wpqIzHhf9IyQT7pqPpV28HJ/Ndxg6euBpDSJPO9tSxxm3a
	tr2ltMgap+SK8ttevt0bGRddfutOGn7X3H+vWjeyeMAl0HEHwMCY6Eut1fq6+OMJ
	EfW0P/9Yxetvl9+BFgDtWvdbHOiheKWk9OyBfsHrVE7wplYn3rHuq9CCYl46/Y3Y
	kgVD780NOWMaRJqhYklyAzKIjCrJ3q0Sxbr1xOnuPV5pO7zsU6v1MfuWRDCf8pOm
	uTPjSb563wOpMn5tAaeZsGAZ7nF5cMd/D4DHVMFMsRXbDU0XcAkYc/kOQ==
X-ME-Sender: <xms:Dnw2Zc_23aEWDpNLP4Snnh-bMYcTjIXvSTkZC2-mh5rSPZnaPV4GMQ>
    <xme:Dnw2ZUssCqjp496KSxiok0xC4N7_jHKUrEPvDDsSf482vRvY9sOVmTsldPVNOZ15O
    rMIHYhwvyinBTbJBw>
X-ME-Received: <xmr:Dnw2ZSCWpIY9PqOsVwxDrLHfCh5xtOjUnrYw5qf70mcSfUG9rG51BNBwige5vzi19Dv4d5tdJYSWy0oIlo3718DhrdFli7WDReVrCSPdDbvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Dnw2ZccXWJ360x_FA9S2Z5Z2-YeFTSYzZ0yK30t7T94mgVXHtpcFng>
    <xmx:Dnw2ZROult1Jy16oxohSGqzBHoa7tDR-ZBqk9Z2uziwAQvXtlSVpDA>
    <xmx:Dnw2ZWnM9y1pVJ-t6uVyupk1DigAgK2xBrQiBCzuRCz7S-H1155juA>
    <xmx:Dnw2ZTVXYk_DKszkH8yeGWoRLbePd_sEMqdE5DiWi6e3KPYMMfcL8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 09:58:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af1b9a60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 13:58:34 +0000 (UTC)
Date: Mon, 23 Oct 2023 15:58:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwen@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/11] t4207: delete replace references via
 git-update-ref(1)
Message-ID: <ZTZ8C08IrhpggfiY@tanuki>
References: <cover.1697607222.git.ps@pks.im>
 <c4d09e3e5dbd11221cc4d229b815434d441cdb4d.1697607222.git.ps@pks.im>
 <CAFQ2z_MiOazk8qLvEn5xfHyMwY=5pa6rEJD3vC3+rnHz4AeQ2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z2TJfkEfBw3U5nuf"
Content-Disposition: inline
In-Reply-To: <CAFQ2z_MiOazk8qLvEn5xfHyMwY=5pa6rEJD3vC3+rnHz4AeQ2Q@mail.gmail.com>


--Z2TJfkEfBw3U5nuf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 03:27:11PM +0200, Han-Wen Nienhuys wrote:
> On Wed, Oct 18, 2023 at 7:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> >
> > In t4207 we set up a set of replace objects via git-replace(1). Because
> > these references should not be impacting subsequent tests we also set up
> > some cleanup logic that deletes the replacement references via a call to
> > `rm -rf`. This reaches into the internal implementation details of the
> > reference backend and will thus break when we grow an alternative refdb
> > implementation.
> >
> > Refactor the tests to delete the replacement refs via Git commands so
> > that we become independent of the actual refdb that's in use. As we
> > don't have a nice way to delete all replacements or all references in a
> > certain namespace, we opt for a combination of git-for-each-ref(1) and
> > git-update-ref(1)'s `--stdin` mode.
>=20
> There is a test helper that can directly access the ref database,
> t/helper/test-ref-store.c.
>=20
> If you use that manipulate refs for testing purposes, you make the
> test independent of behavior git-for-each-ref/git-update-ref, which is
> what you want for testing replace-objects?

Is there any specific reason why we shouldn't be using
git-for-each-ref(1) or git-update-ref(1) here? Neither of those commands
are part of the system under test, as we rather care about git-log(1)
here. So as those commands are already being verified in other tests I
think it should be fine to assume that they work as intended here.

Happy to hear differing viewpoints though.

Patrick

--Z2TJfkEfBw3U5nuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2fAoACgkQVbJhu7ck
PpQAXQ//W+5rJMEbtUsImy3hgTHIWG15zIsIsQrgassZiqpZm2rIjJCArt/Ddux4
MoQC7zQ3T1yaZBWOWiD6YtzlpSahfBrnk0A5Ef31kAftDytcHo7cSQllhabPFzA2
jXA56YvL6Nl4jOF/Pq6aNmMiJs36++/o+rcrBSb9csWnPJsdsytSt3DjD96qAiE0
MspSW6W04ERlmj3YsPCMFLxAoXnBHBBAPfM42mxYFSyzMJRBXs+CGHla8UexyoiT
CB+gd3KF9lK8YJYrBNX55ZqDZPGiyEB4Sro7EBHJgtPpYBtisfxkm26Hlm+osdHE
aPZrkxq2lXTxFPs+fYdBQZ/j+dh/VcV+0kXC2A+dN2T7/c1KhefCBubk2NNT+5ts
OU1/w2LFON4xLUbRubb1MuxpwmpMr3pixw1gmpen6GJhEXeEXX3e+nKzIt/Gphhu
BTfhBSIcNmMqS0RGgv3qpjs9Cuyr9UPcnHH3Q+6+bEGVKDvTLfo62YLewcpVQ8II
FXPnExl4m3WiySR3FOKBtLrte3/1JUNW/KfPgMMlAwL1e9PI5WhZ7NgpfAvd92jE
krOQBt3p1Y9hYEy/i8v3kZhkyYQrVOGcWsWorsSUvZODDYyD/3rQhirgUUCZBAJT
I7jaDJaebkOxbIDN4+44O2aC5VRBta7DUcXBXqB8xIPDMBmRu3I=
=1vGO
-----END PGP SIGNATURE-----

--Z2TJfkEfBw3U5nuf--
