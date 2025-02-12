Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466D20F089
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369259; cv=none; b=TujEBlBLeupFRn0wcqfW+uUeJF1WiD3bc4LwrG+j6jUkJ9t7k8ct6NlcVY3COud8yq2f7JS2uEfFuLQR960D04Em0fW1zJbfS+PHkKFSL6O1Vt4W13ziiC78lJ3PMi0sKy7w8cQk6Sc3lM4bXbUlwU0bQuIX+OrA4Po5viClEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369259; c=relaxed/simple;
	bh=pFPTUpAu7HDkogStwXqNUjSBYCD7zqJeZe5auY5s1cw=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=ax2ihzDQATt6ZuLlq80lgP6nOrm3DidQPMqIaCN+W0Tb9i25jrb5GVTctHC0Caagg0BF/aC5u9xQFhkNShr2vaiDMxpRd8oqyPN2omtms82m04aVq1e2vNEnwAIlIF7Q/zsVlYpnTnrJF7vOHIm8+wvIG1hy1us7bPUOQ5IY0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hC5iGQfK; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hC5iGQfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1739369247; x=1739628447;
	bh=pFPTUpAu7HDkogStwXqNUjSBYCD7zqJeZe5auY5s1cw=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=hC5iGQfKdQkSpCVkgNOY6XWWRBrpWa58RIbkRwx9jP5PhjuwbyLKrd+PylKr+YRa3
	 eWMBbTz7z7rM8dYHIsVXcSZFQMwTg/2QeIpuwde/iQPstPbye/PCj+MdQAQjkcuIrn
	 Hy/hTWvj/67CiKgS8LbM7ObPDlgRLWC0RlZR2gpHo642/iapd/x3c+R5/mrtucLBCp
	 YZdl1QNKzPpckMVirtVPd48SzxDJXOiCwW75Nh2W4AplrJ+bsn2QFceLG3FHoXCEUa
	 ac38h0MGPkGs2YQ35pVhnRh91pDP2UHrERIQlHwUhS1FSak6oBeO9UUwQuI97BBhBF
	 YY/8XZLACtX9A==
Date: Wed, 12 Feb 2025 14:07:21 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: blg666 <blg666.exp@proton.me>
Subject: (No Subject)
Message-ID: <fe9Iwrv_23AEDcZTwgLtxcI9kwmrvo4UDUDaERgLLQ5ctg63zsRYyu3Y4waNOIDtdPZqAvc0gl4dABq1nRtvrAXdwYFDrXxUNnYNI2HnyFs=@proton.me>
Feedback-ID: 131415852:user:proton
X-Pm-Message-ID: e18b0c430abfb014af2f5f936d07574efc34bf8f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------93162653d62347a0115a1e11b89c5009f938f35b977b007bfc10f17a2901b24d"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------93162653d62347a0115a1e11b89c5009f938f35b977b007bfc10f17a2901b24d
Content-Type: multipart/mixed; boundary=-------------------8207003364d959df1dc0a4a419d844a8

---------------------8207003364d959df1dc0a4a419d844a8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

=0A=0ADikirim dari Proton Mail Android
---------------------8207003364d959df1dc0a4a419d844a8
Content-Transfer-Encoding: base64
Content-Type: application/pgp-keys; filename="=?UTF-8?B?cHVibGlja2V5IC0gYmx
 nNjY2LmV4cEBwcm90b24ubWUgLSAweEVBNUQxRUFGLmFzYw==?="; name="=?UTF-8?B?cHVi
 bGlja2V5IC0gYmxnNjY2LmV4cEBwcm90b24ubWUgLSAweEVBNUQxRUFGLmFzYw==?="
Content-Disposition: attachment; filename="=?UTF-8?B?cHVibGlja2V5IC0gYmxnNj
 Y2LmV4cEBwcm90b24ubWUgLSAweEVBNUQxRUFGLmFzYw==?="; name="=?UTF-8?B?cHVibGl
 ja2V5IC0gYmxnNjY2LmV4cEBwcm90b24ubWUgLSAweEVBNUQxRUFGLmFzYw==?="

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdvcGVuUEdQIDI
 uOC4wCkNvbW1lbnQ6IGh0dHBzOi8vZ29wZW5wZ3Aub3JnCgp4ak1FWjRsS0J4WUpLd1lCQkFIY
 VJ3OEJBUWRBWElCVzFmaGFFQ0szVXR1OXNrWjVRdEhDVmo4Q0xmMnJwSFY1CjdadjBwOVROSzJ
 Kc1p6WTJOaTVsZUhCQWNISnZkRzl1TG0xbElEeGliR2MyTmpZdVpYaHdRSEJ5YjNSdmJpNXQKW
 lQ3Q3dCRUVFeFlLQUlNRmdtZUpTZ2NEQ3drSENaQi9RSXE0L2kvN2tFVVVBQUFBQUFBY0FDQnp
 ZV3gwUUc1dgpkR0YwYVc5dWN5NXZjR1Z1Y0dkd2FuTXViM0pueEt3ekdKZ0tzeEVZTGZpRW5zM
 FhtMzVDREEwV1VSTnJTSnpQCmcyaW9ncGtERlFvSUJCWUFBZ0VDR1FFQ213TUNIZ0VXSVFUcVh
 SNnZpWlRPOEN4eFJTbC9RSXE0L2kvN2tBQUEKK2ZvQS9SNzhTTGZQdlJ3M1p3emI4RWMvbkVWR
 W0rZm9CekxuOFNRUXBkcWQwOUczQVFDek8zVFc1TlB2OUJLQgpoQmFIcCt4Sk9JU25renBXRDE
 1Z0h6NEhNbE5BQU00NEJHZUpTZ2NTQ2lzR0FRUUJsMVVCQlFFQkIwREJ2TnNxCkwzc1ZKSEhaT
 EFBV2dFK2Vxai9pc3VMVkx0d3FEWE1lSHFGZURBTUJDQWZDdmdRWUZnb0FjQVdDWjRsS0J3bVE
 KZjBDS3VQNHYrNUJGRkFBQUFBQUFIQUFnYzJGc2RFQnViM1JoZEdsdmJuTXViM0JsYm5CbmNHc
 HpMbTl5WjVDNgpLTy8vZEZ5WVF4TVFHRnBOa0NNYS8wdzRSVXMxcHZHOE5QcW5VYWgvQXBzTUZ
 pRUU2bDBlcjRtVXp2QXNjVVVwCmYwQ0t1UDR2KzVBQUFIbktBUDljV3RFUENhRjF0aTV4UXh5Z
 zdJK1JRbVNpUTBJcmxSOEZmTzJnS3pNZWNRRC8KWG5sREZSNGRUb28wbDlDcFBoTzR5VDR4RUh
 4WUg3cGVsalZScmFpM3BBND0KPWFaMXYKLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stL
 S0tLQ==
---------------------8207003364d959df1dc0a4a419d844a8--
--------93162653d62347a0115a1e11b89c5009f938f35b977b007bfc10f17a2901b24d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmesqxgJkH9Airj+L/uQNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmf/cAXSRwa5R5ehdVEspyIhFiEE6l0er4mUzvAs
cUUpf0CKuP4v+5AAAKg/AQDKUyKtl//d6d5GIY66LkDBtgToGhxxk9B4xN0h
79RtOwEA3YT2QnUykS00i3oAJuOHbZJfi+Mt8LXN1/hRvb9CzQU=
=0vxp
-----END PGP SIGNATURE-----


--------93162653d62347a0115a1e11b89c5009f938f35b977b007bfc10f17a2901b24d--

