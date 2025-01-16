Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F817BD6
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736992403; cv=none; b=VLSZ+QGo1xyy3EcWqlLp6Ubw4N1PHga9HCBe5SEjRfCnyCv93UBAT9IfKRvJyxdFn9uzeI4RoyPKTlixALKLWC1mJ0QYOeKDc+5xgRRL/89pEiU7KrqJ7EjeFMrAE/ZQkLKo59S3HbWnQaRYpUnTYf/dufJQ8hohRqQo3tBQmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736992403; c=relaxed/simple;
	bh=YxN0LBDmx9y9zkBmTpXK0tbgWVcMiCXGCwuBFiRGvVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh7sxQPyPR1lIMecSzBCWbBitdNPTBD467lsjnYwE9LgR13nbJbqR/s9fO4LmaFwatvk29OJZ6m8OPfYpj+KRnkhaoZFU8oVjUG6ZES1EAPjF+JOpd22VfijGDg/M5NSzSysn0JBmV14oOo3I1uct3rG20HF7VM+CBsgokumv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SHeSglQ7; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SHeSglQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736992392;
	bh=YxN0LBDmx9y9zkBmTpXK0tbgWVcMiCXGCwuBFiRGvVY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=SHeSglQ7NAI70JhE5IJengVCG98/YkRJV5s0NaRl4vmwykfDJwIbrWQTev3odpd8O
	 fkpEFsfQPWyAevmIZcf8hQkVRAuXCPJc8itlP/xWEfWMmQs5vtg7AkQgpTPN9cEw3T
	 JX6mVvfRzKAx4oLo1RWbwwLRpJEPvgbBYkVEybgZuzJg6SQ2fcCmlecWoLl/P6ceoD
	 VwCAbwSauVot54brThTAPv4Pjy+9xqvgiLG70z00XTg5nldsJ/kd2Hgqkc0mX8Cf6i
	 epnvGUDBypeHAo32IkZPoprB/NHucPnLu4ocWSmM7o/FHwzkpsapEm8wt5s5gZc97t
	 ysv0vPRAPvLyyUkaws0a0PaiphlZO24DHVfmy0BnTvA6YFIkp077ac5Zg6rGeNszwp
	 E1lXjKNYRnIeYWCsfmnucvFJI0Y28m3yuxvrJ/cyfaule8ez5iEmbefVqrzjRTE0va
	 5RJRSEsU2spf/XGp0fkoFC7S+v0QYVhn5Ah2xMg3ViLwVs6qR4W
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3FC6D20037;
	Thu, 16 Jan 2025 01:53:12 +0000 (UTC)
Date: Thu, 16 Jan 2025 01:53:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ginger Luo =?utf-8?B?572X5rGf?= <jiang.luo@vastaitech.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: large repository clone failure in git for windows
Message-ID: <Z4hmhjOkuhxYy3IZ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ginger Luo =?utf-8?B?572X5rGf?= <jiang.luo@vastaitech.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <NTZPR01MB11138218E5A5F2EB6AD848518419A@NTZPR01MB1113.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FYaFB/1Yj7KggRrr"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB11138218E5A5F2EB6AD848518419A@NTZPR01MB1113.CHNPR01.prod.partner.outlook.cn>
User-Agent: Mutt/2.2.13 (2024-03-09)


--FYaFB/1Yj7KggRrr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-15 at 08:07:30, Ginger Luo =E7=BD=97=E6=B1=9F wrote:
> Hello, GIT gurus
>=20
> I have a large repository which is more than 30GB, when I clone it with g=
it-for-windows (tried 2.47.1 and some old versions), it prompted me with "f=
atal: pack has bad object at offset xxxxx: inflate returned 1", usually die=
d at "receiving objects" stage at about 4GiB.
> Looks like it's same issue in https://github.com/git-for-windows/git/pull=
/2179 ;

I think it's actually a different issue.  That's the limit for
individual large blobs, and pack size would be a different code path.

I feel like, though, that lots of people have large repositories and we
would have heard before if Git for Windows simply could not handle pack
files over 4 GiB.  I've CC'd Dscho, the Git for Windows maintainer, to
verify that there's no known problems cloning large repositories.  He's
very capable and has seen a lot, so hopefully he can provide some good
insight as to what might be going wrong.

Do you have a single file that is larger than 4 GiB?  That is known to
have had some problems on Git for Windows in the past, and could
theoretically be related to this.  However, typically files are
compressed in pack files, so I wouldn't expect a 4 GiB blob to cause a
failure at 4 GiB in the pack file unless it was uncompressible (such as
random data).

Do you have any sort of public repository or test case that can
reproduce this?  That would really help us fix the problem or pin down
what might be going on, since we could inspect it ourselves.  For
instance, on my system, a fresh bare clone of
https://github.com/torvalds/linux.git is larger than 4 GiB, so it would
be good to know if that fails for you as well, or if it works correctly.

Are you using any sort of antivirus or firewall other than the default,
or any sort of proxy, including any TLS man-in-the-middle device or
corporate proxy?  This sounds a lot like some piece of software or
hardware trying to buffer all the data for inspection or tampering with
the data.

If so, can you please try to completely uninstall the software and
reboot, or use a different network that doesn't have such a device on
it?  Note that simply disabling the software often does not fix the
problem.  If that works, then you should report a bug to the vendor of
that software or device.

> Seems like it's a "long" versus "size_t" problem and should be fixed long=
 ago, but why it's still there? I was using 64bit git and 64bit windows ser=
ver;

Git was originally written for Unix systems, which, when 64-bit, are
LP64.  That means that `long`, `long long`, and pointers are 64-bit, and
the appropriate way to write a word-sized integer is `long`.  This has
been the case since the DEC Alpha, which was one of the first 64-bit
machines.

However, Windows decided to use an LLP64 approach, where `long` is
32-bit and `long long` and pointers are 64-bit.  They did have reasons
for doing so, such as compatibility with existing software that
specified `long` as a 32-bit type, but it is incompatible with the rest
of the world, and they knew that and did it anyway.  This is a common
source of portability problems when porting between OSes in both
directions.  Fortunately, newer languages like Rust and Go have avoided
that problem.

Because Windows was not originally a target for Git, there's a lot of
code which still uses `long` in places, and nobody has cared enough to
send patches fixing this.  The required changes to the code can be
pretty invasive, and so patches have to be carefully crafted to be
reasonable in size and avoid conflicts with other series in flight.  Of
course, you (and anyone else) are welcome to contribute and everyone
would be happy if you improved things in this regard, even if only a
little bit.

Note that `size_t` does not have to be 64-bit on 64-bit systems, only
large enough to hold the largest possible allocation, and POSIX only
requires that it be 16 bits in size, so it is not always suitable to
use it when you want a word-sized unsigned integer.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--FYaFB/1Yj7KggRrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ4hmhgAKCRB8DEliiIei
gXGqAP9cr8Dvon/cObrh2AygAjhD3h2GagsXJpjw0oIOOo3gWAD+L7vtpLRTLI1F
ww7p+TuHhRj1iuGstdbUZnSGZkIicwo=
=gl75
-----END PGP SIGNATURE-----

--FYaFB/1Yj7KggRrr--
