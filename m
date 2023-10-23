Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04441A72D
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jcYLbP6N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFvZrwB1"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F59100
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 06:58:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7671E5C0346;
	Mon, 23 Oct 2023 09:58:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 23 Oct 2023 09:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698069501; x=1698155901; bh=LZ
	6/tYrz43awCG98Yd57/1klGi2wmmXQtMvkUgDNUfI=; b=jcYLbP6NshMKoSPUxW
	vx8b3oanFNXffw/3OSBsxyKEC4zI47QJ5+ujj0x3olUWLwQgFeT0xDkWQ6Y2DX6n
	WSt1etGviKLgUWUALPHtkBHnWSB18SULAulM+gralNTAYksyofF855RtxJjq97a7
	nc+gJjH/uTN5sDkBkyIIh8GxQYtOEPrImdtYSUmQUbXtRIcCj+AaWQL/Q022yYuK
	082v2p7GDq2qW5PagxdiLzrUjjCQCLgraA8yJ1fubKQbxXFE0KJvxWPanMgWh3cM
	ZJ7DI9U0jaSXB3b/Fi6/xb8fpcNfFEVi2s46m8XTCCI+uxXLsEULTm2rF9lvzc2X
	EQyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698069501; x=1698155901; bh=LZ6/tYrz43awC
	G98Yd57/1klGi2wmmXQtMvkUgDNUfI=; b=XFvZrwB1ZecJgelz0t5OlA7OMgRZR
	nwxx1XmrGYoJbdE3UtyHrwwYvhxh8uRdTPwgCfMSN2oleV8qYYthGlxHgrDT2/j2
	1L/fSbm7DcFEtypjHQ6V80lIvKda8kLO5wGB/bpyU8qYkpO+siqHJeuPzZ5vq9GF
	yiePqDiGw266aTB5XlEse47c3mTAMjJFm+BP7siu74ZN3o/qt3B9XBwsox7kHVqG
	Mj8DrQSdb7Sll0z3foQfkKSE9KFQg27pfcYoc4xbM1X3/JqFH2PYXLBi0Dnuvr4d
	lK3cRyEqsOKdO7B4pnnf1Wha89j268sOxh9iXkYh1xBE5pjGGGBbudFTQ==
X-ME-Sender: <xms:_Xs2ZRpcmZZ6ioayvsIZYfU8HQ4JvG4tfWFA11TdqWTatYRNXSgvwQ>
    <xme:_Xs2ZTqv-aN0dji1JayDl9IBivIHqzeZRgWUatQixh-1UX5lanoSmuSvYbTDRmYt3
    opLMh6XkY-wU3_0Pw>
X-ME-Received: <xmr:_Xs2ZeMPlvHnPUhgbdTlYv0pLv4Mt6GRKlnWoZNRRAZsPCcTv_RN3Y5GymzcjcEsnB7fYU29h1l1d--fqmUXK9hKKbRTkkqn3OpoL9rDjj-C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:_Xs2Zc4hUnPuPcUYBQVfTyvg5j0xE6O-BgNtEv3S3fcX6q494Yi32A>
    <xmx:_Xs2ZQ49g-5DghPPkS4R5WDCFOufpniwWpQovKHZr5iTnqydJ2hpKw>
    <xmx:_Xs2ZUgvimRNrnE9rXsZWuc-avcT8JgvvGDOzPgilfX8hJhE18gmDg>
    <xmx:_Xs2ZeRYstBTBB_Sbk50h_rpwFv22aIjGDRwIPZuinMhel_vQrBjww>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 09:58:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5f6bce86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 13:58:17 +0000 (UTC)
Date: Mon, 23 Oct 2023 15:58:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 02/11] t: allow skipping expected object ID in `ref-store
 update-ref`
Message-ID: <ZTZ7-oMqek8kQqhJ@tanuki>
References: <cover.1697607222.git.ps@pks.im>
 <1f615d62f99e9ab47d37500f05b29615bafffba2.1697607222.git.ps@pks.im>
 <xmqqil73ud5j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kl4YOdCLD6sdzOlF"
Content-Disposition: inline
In-Reply-To: <xmqqil73ud5j.fsf@gitster.g>


--kl4YOdCLD6sdzOlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 09:08:08AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We require the caller to pass both the old and new expected object ID to
> > our `test-tool ref-store update-ref` helper. When trying to update a
> > symbolic reference though it's impossible to specify the expected object
> > ID, which means that the test would instead have to force-update the
> > reference. This is currently impossible though.
> >
> > Update the helper to optionally skip verification of the old object ID
> > in case the test passes in an empty old object ID as input.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/helper/test-ref-store.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> Good.
>=20
> Even better would be to make the old one optional, though.

I was also a bit torn when writing this. We could of course make the
behaviour conditional on whether `argc` is 4 or 5. But I wasn't quite
sure how important it is to provide a nice UI for this test helper, and
we don't have `argc` readily available. It's not hard to count them
manually, but until now I was under the impression that the test helpers
only need to be "good enough".

Patrick

> > diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> > index 7400f560ab6..7dc83137584 100644
> > --- a/t/helper/test-ref-store.c
> > +++ b/t/helper/test-ref-store.c
> > @@ -322,16 +322,19 @@ static int cmd_update_ref(struct ref_store *refs,=
 const char **argv)
> >  	const char *new_sha1_buf =3D notnull(*argv++, "new-sha1");
> >  	const char *old_sha1_buf =3D notnull(*argv++, "old-sha1");
> >  	unsigned int flags =3D arg_flags(*argv++, "flags", transaction_flags);
> > -	struct object_id old_oid;
> > +	struct object_id old_oid, *old_oid_ptr =3D NULL;
> >  	struct object_id new_oid;
> > =20
> > -	if (get_oid_hex(old_sha1_buf, &old_oid))
> > -		die("cannot parse %s as %s", old_sha1_buf, the_hash_algo->name);
> > +	if (*old_sha1_buf) {
> > +		if (get_oid_hex(old_sha1_buf, &old_oid))
> > +			die("cannot parse %s as %s", old_sha1_buf, the_hash_algo->name);
> > +		old_oid_ptr =3D &old_oid;
> > +	}
> >  	if (get_oid_hex(new_sha1_buf, &new_oid))
> >  		die("cannot parse %s as %s", new_sha1_buf, the_hash_algo->name);
> > =20
> >  	return refs_update_ref(refs, msg, refname,
> > -			       &new_oid, &old_oid,
> > +			       &new_oid, old_oid_ptr,
> >  			       flags, UPDATE_REFS_DIE_ON_ERR);
> >  }
>=20

--kl4YOdCLD6sdzOlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2e/kACgkQVbJhu7ck
PpTAnA//dEXvCGa5D5jhDgdChK7de8iodZ79+diZvW89APUcwMgbiPDcU8TQcDoI
kv/BvwkRL8vPSdVfF1uiPIewXmVt0dLDPSAqUw3qoqK50K9KvZwJ5UleKNbj9oaK
urD/h/TwoT97e57Db6omxSRSGAkg9WCam2wjdZ/S3rpwob0Qpay/Wqau/fyW6Amo
3c39+tI1NNmDdbloeSB1L/KALATTJlqOI4OAAbw1MYgxmsl7hQu/ZxIt38yTpGvH
nX9QjMXJcKwOzuCqlVfiQIybULKqaPlDAEX9k8IvxkoSkLd5MVvDausz9KcbPbJn
58yyDpEz3zQZcffiqpoK38T8C7ZoEY91G2l6B9qT+IZJsVyPJ/lQhw7JdifsuVrF
j3oDkkpKnLFyFZUtlq9bAULaMcD/cOyNx2GqiWezrrflt/0hK1vJ+LkxZJEQ7voY
qFe4kXj2uvxlr7Z00WT5ShwUmlRRGOeQrrpuAtIm//8VxfUwyUR+FwAtgfjLfWAU
70XQ5GS0iueXNkCt2oJhTi69MHyxlodjLrxSYiSTTIRyw24BHc9HeyHoJEeOQmNB
3u7iv9qzo705If+9HYiurBfesU96MEM+9fxo78Z5o2bus1pkT67Obph8uw6wnHy+
irYhSVeP7G8xB83yMknnjuerS/g7FORr5CNi5Yq7ye8Efiu27hY=
=z2fN
-----END PGP SIGNATURE-----

--kl4YOdCLD6sdzOlF--
