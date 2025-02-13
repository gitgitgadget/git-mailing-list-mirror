Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653928A2BF
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485911; cv=none; b=HjOjFbRubDaPc61ncsqNd/oSCMdsxNlf1qZygvjUQKy93vroS7xBcq+yOG/E5v8E9UOs/ZkU3VoWp3y8KzhTtXYxfvWm6nSDUAtl9HEg4tU5UeAkG7NWyGu1qeOwE8EVkbVlNaiN6MjerHQpxF9oL/gOD5AOp4W0AxujBqBe3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485911; c=relaxed/simple;
	bh=Dtn7iJOB43/0rCSmasx/SCNJPX6NR+uLMEKXkY+X8P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kysfIUyL8hCTmIh+SNw1mOGBcGqwLjzwC9RjJofc9f8jOHVovlIVNtgFuqjLOSh2Giyq2VBdO8U/6f3YbQfKmO5VOOQxjb1ikunrMqWjTIiTfRXf91qIVJXG3HMyO2j/LWkHkOtGBjmMVJ3h37H81Mskr8nKXj6KnvyRhllGSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=X0HH8C1s; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="X0HH8C1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739485907;
	bh=Dtn7iJOB43/0rCSmasx/SCNJPX6NR+uLMEKXkY+X8P8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=X0HH8C1sj/dXps8k0UUXBUnRYk4kYcO4b8A9hYx5LX9LSVhmOaSdbSvO7O8cA0no3
	 /E7WOR2hhVgBM5Q5f/pPoSJda/QGTHWoakV+WbKU4c/wuiGWCZ4kd1s4jF7XWUsPiA
	 3K4ij1Q06kj+rJgLs6jT3GFArFfkRwdIxyxjRWbT+pVOms14NftQv5fIv5oyATvAPR
	 IaTtf2MpPSnyPqSqw07MAXt1/BrEyh7aboDpfJcr+ZnHIeOqAMScUophrtkwktDChU
	 MRHP2H2uw8Ghq2Kd2FX6/PJR5nU0IiPHiRToFeyEMaR9VQsEmkTJpQCGA3BpWRaks+
	 1dqVoAOYoz4WQkDXNwYIANAijEePJiwvSFHoD7DNjKzZkjxF4+yYp7q0qyP0NgfRzw
	 rI21Htb8Np42pSfWJfVRct4vb+iD5sjKCVGHyv3KsjV4xgZQ5GMd3uI5lzGTOqhc0O
	 emQITGVW8iJumMKu9oC9M55TBGxnaKF/9R7QMSM101qoAmSCsA2
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DFF5820078;
	Thu, 13 Feb 2025 22:31:47 +0000 (UTC)
Date: Thu, 13 Feb 2025 22:31:45 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Brian Celenza <brian@inertial.dev>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question: Git protocol with bundle-uri advertisement
Message-ID: <Z65y0R1VvHFcW3GK@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Brian Celenza <brian@inertial.dev>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <BN8PR20MB2273206F4E3691B12AEEF072D5FD2@BN8PR20MB2273.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ue6lXxXKX73Rm38V"
Content-Disposition: inline
In-Reply-To: <BN8PR20MB2273206F4E3691B12AEEF072D5FD2@BN8PR20MB2273.namprd20.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Ue6lXxXKX73Rm38V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-11 at 22:38:36, Brian Celenza wrote:
> Hey all,
>=20
> I=E2=80=99m working on a project that uses git bundles and the bundle-uri=
 server capability and had a question about how this works with the git pro=
tocol.
>=20
> The goal: advertise a specific bundle-url depending on the type of clone =
(e.g., full or filtered) requested by the client.
>=20
> Context: When the client attempts to clone from a server that advertises =
bundle-uris, there is currently a strict ordering of the operations that oc=
curs, namely:
> Capability advertisements from the server (including `bundle-uri`) and cl=
ient
> `ls-refs` command sent by the client
> `bundle-uri` command sent by the client (if enabled)
> `fetch` command sent by the client with options (e.g. `filter blob:none`)
>=20
> Overall, the command ordering makes sense: to know what to `fetch` from t=
he origin server, the client needs to download and extract the bundle first=
=2E However, if the server wants to send the bundle that best fits the clie=
nt's intent, it must guess what that intent will be, which may result in th=
e client receiving more in the bundle than was intended.
>=20
> Because the fetch command occurs after the bundle-uri command by the clie=
nt, the server does not have the opportunity to provide the client with a b=
undle-uri that=E2=80=99s a best match for the filter options it will eventu=
ally tell the server about in the follow-up `fetch` command.
>=20
> The question: am I missing something, or is this just the current behavio=
r of the git protocol? If the latter, is there any similar prior art for ho=
w a client could provide the server with some form of hint about its intent=
 (e.g., =E2=80=9CI intend to fetch with this filter or depth=E2=80=9D) ahea=
d of the `bundle-uri` command?

I've just read the protocol, and I think it's pretty clear that it
doesn't take any options, so we'd probably need to add a capability
extension to support that.  The syntax of the command is in theory
capable of supporting parameters, it just doesn't have any now.

My guess is that it's because this functionality doesn't see a huge
amount of use.  However, I don't think it should be a problem to add
support for this in the future if someone wanted to.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Ue6lXxXKX73Rm38V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ65y0QAKCRB8DEliiIei
gX3YAQCRkkLMylnqRQmb0LqEbWIXB0LW14evCORwwTNuR9b+gQEA1b6/hnXdlzl+
HMScsC5LnF9bBK9nGU5c/gy5bTMOoQY=
=dbZL
-----END PGP SIGNATURE-----

--Ue6lXxXKX73Rm38V--
