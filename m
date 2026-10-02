Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313135DA64
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969331; cv=none; b=Ort6XE/evhu+eDuIhDWFIPV5AvYSwoeI6+n5yquBiDkbqts3pA/y82PnyaLPzEpDmaWfRXpmc1a6PJq7QKf9hOH0z25GQsfSd+5qyctyjtYT1iZn9ko9i6Yzl3+nXhImCtUIk184s+xkPz6fR0HJ0+Cfpi7hASWKT5xYs1ltcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969331; c=relaxed/simple;
	bh=g/qe2k4nC7AFTdGa+wEGG3NHRQyHN/xJsxIpAW2WhlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhJXh+Z7KIeJi4yt9hni1sJ1EcMrX8xrIwriATrCip0/uNO6rtnErUDsnh4udAGXSIQp2BJW7UCOWeUddxGGuCF8E00xm6OwgOK3twZI+vDrcIkVU5jO7/PNrrsUGxYF93cTvliip5aGd3DlWR3g3yVhznNsrGSDTR8hSWpeUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kcNLPRoT; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kcNLPRoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1790969326;
	bh=g/qe2k4nC7AFTdGa+wEGG3NHRQyHN/xJsxIpAW2WhlE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=kcNLPRoTB6dNTq2+5cpSLXk9LcRY6SzHOq5t1/YvIwIrdFBBRxVsL71YQga4QzEiV
	 A/2f/sfr+uzXxlZoArbNTy/Iohsm0H1afMjHyEnb67XszB7oR6aVGdT0YtkvaK+1gW
	 yMkNEqIrl08eyLfNtb3eP1LMY7kH/wk7J8Gzz7KKSA3CDwXv91II5ILL8DQkkAdI2n
	 XbGJLp9k6zmbK90UUbgv6mML17/pGm1O3sEI5vIBhveuX0GvMP9ORZ4kw2f/atHJh8
	 qKLnV30IWkWhiy4Jg+QasDLnofgId9CDmF94fBFfBotMgAc2B7BFzdxWOw5DD9bWib
	 BBno+QgVS7X9EuGCsRTuuU3GJ9gT6aVB6U/DcJKFyjbF/5d9Oi6DwHYmIuPcowHuCM
	 MEbk0/sm4AS3kI9vS9tvxtn2VeRmRx+/cjwirMMhGbiBiEbwkjSKHK4qP2jaYJWLrf
	 8G5lK/yV2GtREI8E6x9j4ler7tUo652lBkdmjbCNXYZ6LS/1Rgr
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b933:116b:3dd2:3ac4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5D95420075;
	Fri,  2 Oct 2026 19:28:46 +0000 (UTC)
Date: Fri, 2 Oct 2026 19:28:45 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Pierre Bruno <pierrebruno@hotmail.ch>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Windows: ~1 GB RAM per git process, many concurrent
 (2.56.0.windows.1)
Message-ID: <asAF7D_XefgKtgf6@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Pierre Bruno <pierrebruno@hotmail.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <BL0PR05MB5603A8CE8FD78127FB810BE2D8892@BL0PR05MB5603.namprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KVkD5ay31L2YRW4c"
Content-Disposition: inline
In-Reply-To: <BL0PR05MB5603A8CE8FD78127FB810BE2D8892@BL0PR05MB5603.namprd05.prod.outlook.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--KVkD5ay31L2YRW4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-02 at 11:04:00, Pierre Bruno wrote:
> Hi,
>=20
> On Windows, git status-type commands use about 1 GB of RAM per
> process, and dozens run at once when I use coding agents (OpenCode and
> Oh My Pi) in a repository. CPU is near 0%, disk I/O is steady, and the
> total is several GB. Since two unrelated tools cause it, I suspect git
> or my repo.
>=20
> Expected: a few short-lived git processes with far less memory.
>=20
> git version 2.56.0.windows.1 (commit 49d759b698127791a5f3f2759c69b9838467=
11dd,
> fsmonitor--daemon enabled), Windows <version>
> Repo: <N files / GB>, <N> untracked files
> Manual 'git status' with no other tool running: <fast/slow, memory>
> Stable 2.55.0: <same/different>
> Command line seen in Task Manager: <paste>
>=20
> Is ~1 GB per process expected here, and is there a recommended config to
> reduce it? Full 'git bugreport' attached.

I think you omitted the attachment, but in any event, I would say that
this is not normally expected for `git status`.  We'd really need to
know what the command line of those processes is for us to know what
they're for; for instance, you may be triggering maintenance on the
repository, in which case packing a large repository could legitimately
use that much memory.  Similarly, if you're using a file system monitor
process, that could consume a large amount of memory in a large
repository.

I don't personally use Windows, so I'm afraid I can't tell you how to
get that information there.  Once you have it, though, it should be
clearer if that's a reasonable amount of memory to be using given the
size of your repository.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--KVkD5ay31L2YRW4c
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrABewJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZz3SInxmzokHMPCXaCoyJTJA3MqtlFLHdDifRShZteYW
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAO8XAQDUk8FBHrMjuqYf21cG+nM0e8kZ
Xv74X30r0JvZYGL2fgEA+NBl9qrwHGkc50o51rZrxjYrFnBCMtcLVBpbXrwDCg4=
=sPPL
-----END PGP SIGNATURE-----

--KVkD5ay31L2YRW4c--
