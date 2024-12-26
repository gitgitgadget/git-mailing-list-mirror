Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E57145A11
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735233051; cv=none; b=nUH/ENQlLP50GhlVbSWRZ5eA3qqHSIPvb1JzcrFXAxHE3gFYD3hf0+/Can33H2vWGTZV7LjXbHdW+AjzEOD2CNGNY4DwITKfjDCBklTgC5i6BKxuDSJTJtZ9Kl+GiPWyC08oEAzOIjhCBhyNMRk155PT/VTHNPltr9vdHq8cU70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735233051; c=relaxed/simple;
	bh=XIlGiWJ+iaBmH4iFvNpSVjBgms+2zbsliu+ruoTGFS4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tusRuq+0PE59ztBl3GuhpedUnx3JxyNVGg3mYJNrFtMQhUaTzq5Ncx6JDz14AZ17938rDEAYl/ZKLBlPDW+tpebfOQ66v43JwAMajwQfwO9WE8znaChm2Io8Psx48tsWtQqVDRqvsXhhPfDLOg0/tKPTsnnRfN7rP8L5edAHy0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYplAXBS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYplAXBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53EBC4CED1
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735233051;
	bh=XIlGiWJ+iaBmH4iFvNpSVjBgms+2zbsliu+ruoTGFS4=;
	h=Date:From:To:Subject:From;
	b=GYplAXBSepsuikWDi/LBvnFtAPk9sL+q7XmRxmlCAEE3qWMqlwhI/Fok4OsPD+4l3
	 SHqeseINnRy362eMMNPTbw/BsgrKZMITe66de0V7+vgWvLL3a/Om6JT/gCsCgHxvVs
	 R6GkgUpAECkKIboUvktOcG6wHhXfhGoJSwRMStPiBr3CpVcAxjiaYh8z4uJ+1pf0Xo
	 F+f8s0QxrmEntGYQWnTjR2JuK7uhJeviCu6ONKJyKT9CI2fy3Mb2hrMlSLxB8rIQNJ
	 bRJSp4I8tRBYgpQQS22R304f19k6pvGw5YyKRrcbdN14fwcAeuwD/sWN3Z3djGai6v
	 NofTSl9sXbewA==
Date: Thu, 26 Dec 2024 18:10:48 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: /etc/git/
Message-ID: <lwjb3p4mqv6h3mewyh4b5gm4gs6omfapmbd34roexs7yujnswv@xwn6oriqdt62>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7lt4tbgx6jr55bps"
Content-Disposition: inline


--7lt4tbgx6jr55bps
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: /etc/git/
MIME-Version: 1.0

Hi!

I'd like to have all system-wide configuration under a single directory.
What do you think of adding /etc/git/, and reading a 'config', 'ignore',
and 'attributes' files from there?  /etc/gitconfig and
/etc/gitattributes isn't very clean.

Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--7lt4tbgx6jr55bps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdtjhgACgkQnowa+77/
2zLx/RAAjJLw2PXGop1coRky9beRZg1nTFeLsJB+s6Hl0/2CnEt33z+F9pyC9qGp
1EqaJH4wzw2+bzeRpn99uQiyXJnH6mWLXFZxbzhtbwQaPTt2ixPweUz+diqBVxKp
NKbJJHmixrOB8tQFjtOpj6avCm0z3A9evecwhgKvKoRl+SBWjxwJJsBw7rTAiDZF
M984J57CdblCdWhkmD84yjE3rSDD4/OIIIVynWF/hm4/7QXWcOxwBU6RiSL/VKG1
ho5OIC2gZl2UseJvX+9YLRzcVH6/9Ux47dBXlY6f528wC15Pi1Eb5QFNDJ/ZBihF
ry4xafiQ3pwBPbCNmV/jyfazgISSBE3+IeNs82X6+gDwqmpEQGWIL3oVL8KGdWXI
5ahGcLB47Toio40ctcu9gpa89DIkQPtSP7X3S2b2TaHrZPAR+GoxLw5ud+XNaauK
tBSRkIzkmA2GEvk9hruaiNj8jRIE/0+2GBPaX06gvva6iB+tgTGFNkZczoJkq7Vw
fsWZ+L1FLooA0OBlXWhsBRGARgmufmgS2UsuV1B6lAOsdRXxb75d4eJRIXw4s6lx
RCSqI5vlf0odFs7MbcX01+h/MpJSExwH/DO+7JsFlu/TKA00ykAQMhzPT9nAf7Ay
hG+iFwUX8heUD1UowH4/lnEP+0n26Gl07zm5j8FQAhC8ZNSC4uA=
=sYVT
-----END PGP SIGNATURE-----

--7lt4tbgx6jr55bps--
