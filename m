Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1677543AAB
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192967; cv=none; b=K3fQrSbYtYzAcdoMFvmlR90579botsr84T9vOQ5Vp5DrixNkE0aJeY4/trAJZ7t7elOy/DysK0wagg/EfHHMljkMFLWvxHkC1KtlFZLrOcueWvKOSaoVq2PTAiORwlE3KZoTYTL4lbLKqlaAdtEYxO4jBpiMmnMtSCCfhDrhUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192967; c=relaxed/simple;
	bh=xWsWDpFdPQF9PG8JeZvhsLe2VGbkioh9o1Q1ElPHwn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rfp1E347XXIEWZgigTvoc5SAc5lF+TKuVt/RsQcoQ2NnrNHaFaq4FmqvLq4p3ldbq3mxC/oDfqZCSAketrtEN87LCOWF7w55ZcWZvrFB51puyWRT55D8jdsWgIamQIEg/3ip7BYa7UexqkC7YI9hZMmcbink7iHWg44lQ5dbDYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yokpMZm+; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yokpMZm+"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DA9475B3D3;
	Mon, 11 Mar 2024 21:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1710192957;
	bh=xWsWDpFdPQF9PG8JeZvhsLe2VGbkioh9o1Q1ElPHwn8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yokpMZm+Y24HcYxe4n9JyZe2D4V5BCTwXahfFbpMcAW4RphlNjdY/tT+1EIoMY0dZ
	 MKpARF7X9KWmHGl5RhfgUCmhru++oiAQ9STAqdEgFZVUUDoaTzX7h5Iei6nCglZjOQ
	 GJfjhICM/rh9boLDO6jRP4M47sOUDgZDijaQRJl5QY1rpbKSueyEbszofsTVeIVdd7
	 Lw/zHkM4/gS4bJzu9dd0cc2Gka4HNS4S00oP1Guvo3v9nW7yXdyTQZif/TUt7iDxdl
	 Vhu1Xn9MLAm4uWF5qS7Bj+9TCK29jFUpadEpmwixXOUjMyjSIsOB0YYdYgojv7M3pQ
	 XElWDA1X1likJEhTLB3Erm74xm04TNV6avq1Qm843MtalH+kMwFK4X1p2G76Ig7aKB
	 s8KSjrRBea/3DkHxSkfApJ3tjPFxJ2Rttk1YfidDvSWoGJMHFRS+Y0vh+UO4Wo6FJx
	 QrQruA4sttT7q2s5SqXQ6O/S4v4vkdIo3pJ22pQanYshURRhkhj
Date: Mon, 11 Mar 2024 21:35:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Philemon GIRAUD <philemon.giraud@metrologic.group>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git bug report CDPATH completion
Message-ID: <Ze95PCbwn9IE99Kb@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Philemon GIRAUD <philemon.giraud@metrologic.group>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <AM6PR10MB28087CFD43779194563F558492242@AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r6mTRG/ha1OY6ORt"
Content-Disposition: inline
In-Reply-To: <AM6PR10MB28087CFD43779194563F558492242@AM6PR10MB2808.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.12 (2023-09-09)


--r6mTRG/ha1OY6ORt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-11 at 14:24:24, Philemon GIRAUD wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.

Hey,

> What did you do before the bug happened? (Steps to reproduce your issue)
> This bug is about the "git bash" that comes with git for windows
> I added "export CDPATH=3D.:/c/some/path" to my .bashrc
>=20
> What did you expect to happen? (Expected behavior)
> Given that the folder "/c/some/path/myfolder" exists,
> I expected to type (from any directory) "cd myf<TAB>" add that the autoco=
mplete would complete to "cd myfolder"

This mailing list is for the Git project, which deals only with source
distributions of Git and doesn't distribute any associated software
(outside of contrib), such as bash.  You're reporting a problem with Git
for Windows, which should be reported to
https://github.com/git-for-windows/git/issues/.  Do be sure to search
first in case this has already been reported.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--r6mTRG/ha1OY6ORt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZe95OwAKCRB8DEliiIei
gZHXAP93rh8d3PmiTEZp5CYaOjlGrz5v2tHGjTqDPN+4Zr9Z3wEA3UfNu8LWqbf+
TsZMaLa/C3XXxKSuClg3LkYiINv4iQ4=
=QDDp
-----END PGP SIGNATURE-----

--r6mTRG/ha1OY6ORt--
