Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.82.102.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430054;
	b=AQLzvmthDqnYvIbY6/Qx7yWTqajrHIi9pOjn1Q7YHgIhEeoFnCD/nFmUNpMHMDNAb1zO
	 LyArRCw/hcYAEqK2gixhkOqNPXrYf11JZL2S2GH3Nm6u4nrWVheYXn0Bbb65hjv31OF+m
	 UkozZHKRl7MsMA4QUMCZY6s7dMAUOGREQh9k0Dslc0Qf5cuxD/XpZiLJQvBtOwktWtK+Q
	 5WJbcDu9NXqBD6A7F/2V2fV6mD3dnmy/1CtFs0CfsdRzgUv52fl2iskuYo6l5QyK3620O
	 4hBHg0AQTyh2eqt5ByVRJn1hiHVLh28+lCNxQzw3anFbnDTp91bxS0F2a6h5+2wGySA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430054;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=BOyxX8uCaIUIciwV+RWPizCuM/+l0WGbDquBieN/8XI=;
	b=DFrS2AGiI0zbsslCkdl53qeqqY2ICImcNcbe+1Yk5Q0w3Su+v7yVDurI+2H2eoaAjDxB
	 4snT8NKadc2TExYwlk9lcNBxnmsWLhK6HSlrWENB/SQDOx6M2IcPpt+2lktrecpA5Y8BQ
	 3XUwM1bK2V4wgA2JoxfEoXpklE7cc0EjpzaIPmIwo6aRq5zYisSNmwlwfkzcUBndJsLu8
	 aWK8WvT9mOqtQEVbbnaeOF4y1jWGuQzWbC+zzHhi+sdZfoDc4Qqq3cq4L+iqAOe1No69c
	 a10hEwjH196+7yEJ6u5ZUTwSeMCmcgf9+PnATmfy2mIzx3pCs8AbvQ8ITDjO32S1srA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suozzo.co;
	spf=pass smtp.mailfrom=suozzo.co;
	dkim=pass header.d=suozzo.co header.i=@suozzo.co header.a=rsa-sha256 header.s=default header.b="b1p5/6V4";
	arc=none smtp.remote-ip=35.82.102.206
Received: from hognose1.porkbun.com (hognose1.porkbun.com [35.82.102.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C629606A31A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 17:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C629606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suozzo.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suozzo.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suozzo.co header.i=@suozzo.co header.a=rsa-sha256 header.s=default header.b=b1p5/6V4
Received: from snappymail.porkbun.com (unknown [52.88.61.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: m@suozzo.co)
	by hognose1.porkbun.com (Postfix) with ESMTPSA id 3F67C421CF2;
	Mon, 19 Oct 2026 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suozzo.co;
	s=default; t=1792430048;
	bh=BOyxX8uCaIUIciwV+RWPizCuM/+l0WGbDquBieN/8XI=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References;
	b=b1p5/6V4EJwpMSsRgJDS/ukz315/c/ZyRPU07XOLr4gL6Yp1BnwmMvTnpUN4RegTO
	 1nXHLj/6EVn5F5nY2KUVrfbi9xBTR65k85RHzj6ogX+tFqLxG+jx/IobrNgTIv4HLF
	 zlMeHd3ujRySkjTNMVUIFU2cuVkkd6dun6MQpd/k=
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 17:14:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: m@suozzo.co
Message-ID: <41edbeff828fcb4a2f3bc903802b14e3aa66f46b@suozzo.co>
TLS-Required: No
Subject: Re: [PATCH] reftable/record: bound an object record's offset count
 by its length
To: "Patrick Steinhardt" <ps@pks.im>, "Matthew Suozzo via GitGitGadget"
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <atXK0ska_v2rFn8W@pks.im>
References: <pull.2255.git.1791989883899.gitgitgadget@gmail.com>
 <atXK0ska_v2rFn8W@pks.im>

October 19, 2026 at 3:46 AM, "Patrick Steinhardt" <ps@pks.im mailto:ps@pk=
s.im?to=3D%22Patrick%20Steinhardt%22%20%3Cps%40pks.im%3E > wrote:


>=20
>=20On Wed, Oct 14, 2026 at 02:58:03PM +0000, Matthew Suozzo via GitGitGa=
dget wrote:
>=20
>=20>=20
>=20> From: Matthew Suozzo <m@suozzo.co>
> >=20=20
>=20>  An object record's count of offsets is a 64-bit varint from the ta=
ble,
> >  and reftable_obj_record_decode() allocates the offsets array from it
> >  through REFTABLE_ALLOC_ARRAY(), which takes a size_t. Where size_t i=
s
> >  32 bits, a count of 2^32 + 1 allocates room for one offset, and the
> >  loop, which runs to the full count, writes an offset from the table
> >  for each varint left in the block past the end of the array. Where
> >  size_t is 64 bits, a large count only makes a large allocation that
> >  the decode then fails to fill.
> >=20=20
>=20>  Nothing in Git reaches this decoder from a repository: a block of =
a
> >  type other than the one wanted is refused before its records are
> >  decoded, and the object index, the only reader of object blocks, is
> >  used only by the unit tests. The decoder is still wrong.
> >=20=20
>=20>  Each offset takes at least a byte, so refuse a count larger than w=
hat
> >  is left of the record.
> >=20
>=20Sorry, but this whole commit message reads very AI-generated to me, a=
s
> it is both overly verbose and hard to parse. I would welcome it if you
> could maybe touch up the message for normal human beings.

yeah it was AI generated and i copy-edited it. it didn't feel too excessi=
ve since i wanted to be precise about the issue's mechanism, scope (32-bi=
t only), severity (not really reachable), and describe the fix.

any pointers on how you'd reword? remove the exposition?

>=20
>=20>=20
>=20> diff --git a/Makefile b/Makefile
> >  index a96be506b5..66b7270fc0 100644
> >  --- a/Makefile
> >  +++ b/Makefile
> >  @@ -1551,6 +1551,7 @@ CLAR_TEST_SUITES +=3D u-reftable-block
> >  CLAR_TEST_SUITES +=3D u-reftable-merged
> >  CLAR_TEST_SUITES +=3D u-reftable-pq
> >  CLAR_TEST_SUITES +=3D u-reftable-readwrite
> >  +CLAR_TEST_SUITES +=3D u-reftable-record
> >  CLAR_TEST_SUITES +=3D u-reftable-stack
> >  CLAR_TEST_SUITES +=3D u-reftable-table
> >  CLAR_TEST_SUITES +=3D u-reftable-tree
> >=20
>=20Makes sense, even though this should probably have been in its own
> patch.

happy to move it to a separate patch.

>=20
>=20>=20
>=20> diff --git a/reftable/record.c b/reftable/record.c
> >  index 1fce441930..96eceddca7 100644
> >  --- a/reftable/record.c
> >  +++ b/reftable/record.c
> >  @@ -589,6 +589,10 @@ static int reftable_obj_record_decode(void *rec=
, struct reftable_buf key,
> >  if (count =3D=3D 0)
> >  return start.len - in.len;
> >=20=20
>=20>  + /* each offset takes at least a byte */
> >  + if (count > in.len)
> >  + return REFTABLE_FORMAT_ERROR;
> >=20
>=20This check doesn't really seem to match what you're describing. What =
you
> describe is an integer overflow, but you only check for a very specific
> edge ecase here. I would have expected for example that...
>=20
>=20>=20
>=20> REFTABLE_ALLOC_ARRAY(r->offsets, count);
> >=20
>=20... this line already detects the overflow and then refuses the
> operation. Because `REFTABLE_ALLOC_ARRAY()` itself already tries to
> check for overflows.
>=20
>=20That being said, if you take a look at `reftable_alloc_size()` you ca=
n
> see that the input is both of type `size_t`. And _that_ is indeed broke=
n
> on platforms where `size_t` is 32 bits, as we'd potentially wrap. But
> that fact is not even mentioned as part of the commit message at all.

isn't that "REFTABLE_ALLOC_ARRAY(), which takes a size_t" in the original=
 message?

>=20
>=20So overall I'm not convinced that this fix makes sense, we should rat=
her
> fix the source of the problem, which is `reftable_alloc_size()`.

that felt like a pretty disruptive change i was hesitant to put up as my =
first patch but i'd be happy to make the change.

>=20
>=20Thanks!
>=20
>=20Patrick
>
