Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341D14AD20
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908641; cv=none; b=jkSud9prp0OHnqc1+UIcEnR5P41RlxsrxyZZNICiYLNHk8lBGqVHD0stK4yyVfuT7UcbypHKajIXrOZLz7kt1ALp3I4YKUIiNNlgOzhwt7xDulQt2YiYsr1MwAIZ282MhB6V6i1CpJuFncvpL3bp0otVw3Blnoem6GQjxsHoyaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908641; c=relaxed/simple;
	bh=qbrU9ymw0mjOJMFgzueqI6rd13lN0brD5bKVUelaQb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA/Y006hEWhkbtBMOuw2o8XzJJgbQ+bPqSJx2TBIlWWORB4N3YtYKZX7Of7NkeT2gtO3l4QcvJCpV5GXFKSknHsosvPZRjRFt8tE8FC2T9o6BOWaklhPGOi4fuj+uZt9DIDWLfn7h6ng159ZVl2M5ncBUHUpuusg1RnLqGOQE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0yy5sEBI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0yy5sEBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1741908632;
	bh=qbrU9ymw0mjOJMFgzueqI6rd13lN0brD5bKVUelaQb4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0yy5sEBI0h/yPasr0ypF1dW/JkuzsxaxjgTTVs2MnAr+/zhcC/THRcUzGgq/0iwmG
	 QTZUeaUuHCQ7/JYVHqlx8OcixmDTP6PasRb8PjUp1sW+u5icRkC3XwZsIPAImKafE5
	 WOltzg/9eGk2JwZcTlNh6/ab2XiiaJbuJuu/JZ9F6JpS+Vdj1c5SZ6kXsJkgn5Wu1I
	 xO7tFArFcwP7BbFU97d5DHpnWHAQF3jqUxpqS5JEmzn5CRdAlQPjo7bpuFG2PF3a08
	 5kpvGDNjwpv22/bSruuRyE1V0VIEYlzgcpQm+PzngVnAmiglKFbvTAKb8Gd3CRQkUn
	 plFMx+cU3NDV4YktCDv10lLmUZDeCyCb1kosTH5OQfggMUEU2zhrJOv57SPFc+rbU8
	 flubl9eBVlSEctoGLcvRh72GolGc9G9xfErIhY4pBT+tmp6weUVYw7aDwsMUPxKIl7
	 Zx/GCP/DMaA+no4ZsMuriHk9VV9lYLP/2lLzSqv/8UFoKIe4vTN
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 658B9200B7;
	Thu, 13 Mar 2025 23:30:32 +0000 (UTC)
Date: Thu, 13 Mar 2025 23:30:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Haifang Wang (Centific Technologies Inc)" <v-haiwang@microsoft.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Windows Application Issue | Git | REF # 56282410
Message-ID: <Z9Nql1ZnoD6dzoO-@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Haifang Wang (Centific Technologies Inc)" <v-haiwang@microsoft.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <CH2PR00MB0812B85F95651EC133D38264D255A@CH2PR00MB0812.namprd00.prod.outlook.com>
 <BYAPR02MB49983AE922A5690EB86BFD2DA155A@BYAPR02MB4998.namprd02.prod.outlook.com>
 <CY8PR00MB1459EF0E020DABD52F63460AD20BA@CY8PR00MB1459.namprd00.prod.outlook.com>
 <BL1PR21MB320858BAF11193AB06109B2DE50BA@BL1PR21MB3208.namprd21.prod.outlook.com>
 <DM8PR02MB80213198F9A71571EB92D989CD08A@DM8PR02MB8021.namprd02.prod.outlook.com>
 <PH7PR21MB3263AB0D6C1DE7D56E9613AEE5F12@PH7PR21MB3263.namprd21.prod.outlook.com>
 <DM8PR02MB802134089B95821DF4174A14CDF22@DM8PR02MB8021.namprd02.prod.outlook.com>
 <DM6PR21MB12917960F9D9D488A03FCF19E5D02@DM6PR21MB1291.namprd21.prod.outlook.com>
 <DM6PR21MB129188369F4FE0C0DF306B80E5D02@DM6PR21MB1291.namprd21.prod.outlook.com>
 <DM6PR21MB129127285D6FDFF80A1AE87CE5D02@DM6PR21MB1291.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6+EFaaPszqpcvX/e"
Content-Disposition: inline
In-Reply-To: <DM6PR21MB129127285D6FDFF80A1AE87CE5D02@DM6PR21MB1291.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--6+EFaaPszqpcvX/e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-12 at 20:44:21, Haifang Wang (Centific Technologies Inc) wrote:
> Hi Team

Hi,

> Environment: Desktop
> OS: Windows 11
> App Version: 2.48.1
>=20
> Repro Steps:
> 1. Deploy latest OS
> 2. Perform Windows and Store updates
> 3. Download the application from vendor(https://git-scm.com/downloads/win=
).
> 4. Install the application by Default Next Steps.
> 5. Launch Git Gui and Create a new Repository.
> 6. Click on help and click on Online Documentation .
> 7. Observe=C2=A0
> =C2=A0
> Observations:=C2=A0=C2=A0=C2=A0
> Encountered an error prompt observed in foreground when clicking on Help =
Documentation.
>=20
> Expected Results:
> No Error prompt should be observed while redirecting to edge

While the Git project does distribute Git GUI, we don't distribute any
binaries, including for Windows.  I did try your example on my Debian
unstable system, and I got a link to
https://www.kernel.org/pub/software/scm/git/docs/ in my preferred web
browser.

My guess is that this is just an ordinary packaging bug, and as such
should be sent to the Git for Windows project, which distributes the
Windows binaries, at their issue tracker:
https://github.com/git-for-windows/git/issues.  I'd suggest that you
reach out there after searching first to see if it's already been
reported.  I will warn you that the maintainer is busy, as is usual with
open source projects, so it may take some time to get fixed.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--6+EFaaPszqpcvX/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ9NqlgAKCRB8DEliiIei
gdnMAQCLm8V2DvNkgTr2ulyPdrywbB+VtriyETsNC3j29+2buwD/R9V2E427s57w
ZZizcQM/xDIrEa+5ici2ubfCBgGkwgo=
=SBIS
-----END PGP SIGNATURE-----

--6+EFaaPszqpcvX/e--
