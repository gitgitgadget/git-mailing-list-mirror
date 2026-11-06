Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972106;
	b=o2bo+H0Nvhp2QwQjxx54xlgCOxeY0hriaGcSCRizw7TlbKAIi8QCnC4sgIZOVhU4jO/T
	 mAT+kEiKmiQrekd6ZqN+lk2J8gJSqBsAAufdbQtb+zRkRdWCSXXEPnQdGwnxB/ZY7y+Ct
	 Ee3YadcjHLRs5UUm3RwcpUZ1uDvJQ1U34ARiQVODT/s5yLem8RUMV/Dmhj2JHY/oBhTOn
	 LXjj1otWvfX/84Bt6OR32C24Q8lk4FgQb5EExX83f3BHMww9z60ikO3gDOokDSpzRBtsn
	 R8Q72mk+69aogYC0M0pfUtEb9BcLZyXnBI9kPmXaHAMa5zA1IdPY/NLUY0nzKsC59Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972106;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=PimiOtQN6Zq1SKEJyM58IsHsPBtVdaagUqPWuAWNFv4=;
	b=I6UvuQTMLjdlf2GrncocKhJLxTXgKa4CkKaklRP7eEGU3XDZ9FvpKjgC0blyN7Oj550I
	 i/Q0jtqUrDvmYOeyqrqQeLT6jnjGYiwTZCLlbp0I0uxS22fBaU6/TiAqCFqZbzt2DatCK
	 0TRPjVcQc5w5TrSOg3K91LQpkpqNVc/ch3O/4dZJZZIJWAoGUa1l+kgWhoTpcGH0ZvS/D
	 Zpd1MAu7q+XmVXp7DMjav2Ft50ruaGkWIkM3mQLZwZzJABRFQOuu0ESJ2h07lFtUB6vsH
	 1XRMWba84upJX7cxJPYNDqDqKyWaq88SmtdE4L0yxNZOKTXwXI3EvDa+/n8af14KZww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k95qwiGL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32472606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k95qwiGL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD8E1F0089F;
	Fri,  6 Nov 2026 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972105;
	bh=PimiOtQN6Zq1SKEJyM58IsHsPBtVdaagUqPWuAWNFv4=;
	h=Date:From:To:Cc:Subject;
	b=k95qwiGL8S3h1Nm+ldESGyiWgMKubkSCNCID/26zkHnf698ZwHQctpt2qsLlNyD4K
	 xOf2EZEMLru+vSQLZTcCHBtG5WICX0FDqebKmAN74FfN3hdyXpPmKS5eM3p08uQiHj
	 op8aq/9kL1yJv4caPeyhlKMKHVIJBVbZw91uAwgBE14f6fbkQ2OnLQTx5fnkxj5alY
	 HX+20p0PQSU8WP9S+6HQA3dFC7iJT77RddNn7KsJPTiyQMGNrVT278evWqPgUi/oWT
	 AF3VftHbXVwZuTSO4ZTLIFoGosAbJ9cKxY/QzI28hFyvKJY/JvVY3uZfIJmKXLXMB/
	 OvT5JALUOrnWg==
Date: Fri, 6 Nov 2026 14:35:01 +0100
From: Alejandro Colomar <alx+git@kernel.org>
To: git@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: git-ls-files(1) avoiding symlinks
Message-ID: <au3Tyaz_LoYDuskn@devuan>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7via6c44zxtslhjm"
Content-Disposition: inline


--7via6c44zxtslhjm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+git@kernel.org>
To: git@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: git-ls-files(1) avoiding symlinks
Message-ID: <au3Tyaz_LoYDuskn@devuan>
MIME-Version: 1.0

Hi!

Yesterday, we were discussing alternative methods for grepping source
code.  Here's a list of similar alternatives:

	$ find . -type f | xargs grep ARRAY_END;
	$ git ls-files | xargs grep ARRAY_END;
	$ git grep ARRAY_END;

The version using find(1) has some problems: it is slow, especially
after having built a kernel, when the directory is full of temporary
objects.

The version using git-grep(1) without IPC is the fastest, and doesn't
have any problems, but it is limited to just grep(1).  If we want to use
sed(1), or any other programs, we're out of luck.

A common program I want to use is grepc(1), which searches source code.
See for example this code for finding the creat(2) system call:

	$ git ls-files | grep '\.[ch]$' | xargs grepc creat;
	fs/open.c:SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, m=
ode)
	{
		int flags =3D O_CREAT | O_WRONLY | O_TRUNC;

		if (force_o_largefile())
			flags |=3D O_LARGEFILE;
		return do_sys_open(AT_FDCWD, pathname, flags, mode);
	}
	include/linux/syscalls.h:asmlinkage long sys_creat(const char __user *path=
name, umode_t mode);
	tools/include/nolibc/fcntl.h:static __attribute__((unused))
	int creat(const char *path, mode_t mode)
	{
		return open(path, O_CREAT | O_WRONLY | O_TRUNC, mode);
	}

A problem with git-ls-files(1) is that it doesn't have a way to filter
files by type.  That is, it will list symlinks, which will affect the
search.  With find(1), I can control that with '-type f', which makes
sure I only search in regular files.  I'd like to have some feature in
git-ls-files(1) that allows me to print files of the specified type.
Since git(1) knows the type of the files, this should be doable without
much overhead, right?


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--7via6c44zxtslhjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrt134ACgkQ64mZXMKQ
wqmJhRAAulEzINHRrIWpLPk3xnynEzvWEEtsSH+Tyr9+B5sDT3NyAeNFG+R8KYHn
pOMWu21EGooZN3UTUTAem7XHP8n6Pye9CeHxQLVCe7aYoLgArOsW884jtvKSzV7/
HwAY4tVFku+piVbQDKWy9F0BM8davweH69AWsHqjHy2HGtliK9G++hZfMejiXnPl
lUtExjbQ8O+v5NTYnDUzI7zY/riOVXOFFnAjfCluAvZueih4mfnFaedTTTBefR0/
LPsrGDFQJRwlkBLH41OaF7UguqCIJctcY7U9zqs+5Yw3aXX7VHilVBKJm1LBMgah
wkcuBXTptqBLK9jz4xHofq0QDhBXeubPsBNRu6HllK9lxePDPKOfsEBp+EebyPa3
MbOqQb1hhWRjyE7kRSmLrCa3yLzULg7BUfERjLmA3VQQ+H2Pg7NHCKsbVZmFxQPb
qntfLFVBp5I0h7sBUkD1afqT/Wax7eVCrh6ZMHcabYabMed9Ev60eeg4VJPguCsP
1Ra0WqVZOwMhcI/tVVksF8ENplyl35+2UC5PKpHi4qXEuva2PkcNOvvlIp5HWwju
/74PjclsfkcI/uFqAm+F05qihCMwaQJMyQKfYQ75bYC/TrqIF21cRI5LYTu4ptGr
0Z+bZHEMUWIJlNTFPvW1JshORig6sQLlz25HKI1ugfiG2kvDY48=
=Dq8C
-----END PGP SIGNATURE-----

--7via6c44zxtslhjm--
