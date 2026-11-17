Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935858;
	b=fztP3985mHJa0QW0pMg27I56H2vgxZe361XINy7hznPDNt4SpLuvzsBrWAsC6+M0xZQB
	 tCJSD73lWRm8DSaJ69qnFT1+bGc/qu0TYo77mGvDMUMohDAOWSxVWlf2iplusv5dB4SqE
	 +F+NSu/8ZxkCByMVTXEe/c3/oJLrt8G5Ww4x6kHanZNRRAf7tSrrE4xO3VGmlQWYonWfz
	 MnLkjcqKgbCySpaSdi1DieokwXDaQSpHhPFWj54vbe6YJEMJVHn0MC/noA0IrjIp1Z12u
	 WCJ0ZmBTEAH5UsKw8JU7qab2NoCBfFNCGBvmiQrhnVMiPEuJtka7fPfGww9lcKcxHZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935858;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=I61cvHF/0Vr0DkKHVvgnPlGRAKYMcZJZQFhk80CLMDM=;
	b=WkHqwMGp8elbd8SuLdyjbWrJmTCMHCrQmuYJiQBKq2v/HLc4dBvoU3XBFJ7/oRDmZmjK
	 Nhi7p3ukUT+jO5lm5jThDmzkVyGjrUq+Y0oqipVBYW7KLclYQtD5uo1UMo7mFVc7h0iSH
	 mzgnMxgMSPw0XzB8kTG6GifLjKn3omrCRuqx0G2qualf+vr/UwMv+lat2g48yXLRpbrsM
	 lB/wbrOwpLm1qPf338dCPiaim+x8MNmoXsKeeANbA3YEj8jtS+gphTqOGzT/HYbqvH6G5
	 sBZknl2luKK2WrXLgNOUl2BOSQHlAk11XvpPgnmyHSVmjul+AGg1NraqWDGmyxcxNyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlMpRa+X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CECA606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlMpRa+X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0131F000C5;
	Tue, 17 Nov 2026 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794935858;
	bh=I61cvHF/0Vr0DkKHVvgnPlGRAKYMcZJZQFhk80CLMDM=;
	h=Date:From:To:Cc:Subject;
	b=mlMpRa+X562ywgniCxy0IgclLH4Kog1HcI9lKx9E1diyudl7RBbJt5S+7ix//iAvJ
	 h64Y5d1b9ZYpHBOuQ7XPwQQY9UQg/KdeGwoT+HnGcP/tWa7PRQECWtglOuleiLVCMF
	 bF/WQb1b0HOHna9yx/HcEDTg5QtEhcksl27v59MVWhY2ph70HvHjVF4Chnivvv88Cj
	 Hdr5me/JAMEkLpbKd4Bqj7dXTRYBwT1C/+T1bT8Ci3nY2BEA1yiDlPxuHZ1PgbQN65
	 6xnoxCc/b2APqBEB5Ue4TrEa/Kzc6Mg5FDqjk6/5iVl6ApFCIQ1dmzYNNZmzYZPboj
	 UwSb96bewdIhw==
Date: Tue, 17 Nov 2026 18:17:32 +0100
From: Alejandro Colomar <alx+git@kernel.org>
To: git@vger.kernel.org
Cc: Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Multi-line git-grep(1): -M
Message-ID: <avyInNCE9QlbcV5e@devuan>
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
	protocol="application/pgp-signature"; boundary="r2qljlfwmz2fslvw"
Content-Disposition: inline


--r2qljlfwmz2fslvw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+git@kernel.org>
To: git@vger.kernel.org
Cc: Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Multi-line git-grep(1): -M
Message-ID: <avyInNCE9QlbcV5e@devuan>
MIME-Version: 1.0

Hi!

pcre2grep(1) is mostly similar to `grep -P`, except that it has a -M
flag for multi-line searches.  It'd be nice to see such a flag in
git-grep(1).

Use case:

grepc(1) allows one to search for C code.  A couple of examples in the
Linux kernel repository:

	$ grepc ARRAY_END include/
	include/linux/array_size.h:#define ARRAY_END(arr)  (&(arr)[ARRAY_SIZE(arr)=
])

	$ grepc -tfld open fs/
	fs/open.c:SYSCALL_DEFINE3(open, const char __user *, filename, int, flags,=
 umode_t, mode)
	{
		if (force_o_largefile())
			flags |=3D O_LARGEFILE;
		return do_sys_open(AT_FDCWD, filename, flags, mode);
	}
	fs/open.c:COMPAT_SYSCALL_DEFINE3(open, const char __user *, filename, int,=
 flags, umode_t, mode)
	{
		return do_sys_open(AT_FDCWD, filename, flags, mode);
	}

grepc(1) uses a helper program to produce the regexes: grepc_c(1).
Here are the regexes used internally for the above:

	$ grepc_c ARRAY_END
	(?s)^(?:[\w[](?:[\w\s\(,\)[\]*]|::)*[\w\s\)*\]]\s+)?\b(?:enum)\b[\w \t[\]:=
]*(?<!\w)(?!\w)[ \t]*\n*(?<space>[ \t]*){(?:(?!^\k<space>?}).)*^[ \t]*ARRAY=
_END\b\s*[=3D,].*?^\k<space>}[^;]*;
	(?s)^[\w[](?:[\w\s\(,\)[\]*]|::)+[\w\s\)*\]]\s+\**\(?ARRAY_END\)?\s*(?<par=
ams>\((?:[\w\s,;[\]*\?:+-]|(?&params))*(?:\.\.\.)?\))(?:[\w\s\(,\)[\]]|::)*;
	(?s)^[\w[](?:[\w\s\(,\)[\]*]|::)+[\w\s\)*\]]\s+\**\(?ARRAY_END\)?\s*(?<par=
ams>\((?:[\w\s,;[\]*\?:+-]|(?&params))*(?:\.\.\.)?\))[ \t]*\n*(?<space>[ \t=
]*){.*?^\k<space>}
	(?s)^[\w[](?:[\w\s\(,\)[\]*]|::)+[\w\s\)*\]]\s+\**\(?(?:compat_)?sys_ARRAY=
_END\)?\s*(?<params>\((?:[\w\s,;[\]*\?:+-]|(?&params))*(?:\.\.\.)?\))(?:[\w=
\s\(,\)[\]]|::)*;
	(?s)^(?:COMPAT_)?SYSCALL_DEFINE.\(ARRAY_END\b[\w\s,;[\]*\?:+-]*\)[ \t]*\n*=
(?<space>[ \t]*){.*?^\k<space>}
	(?s)^[\w[](?:[\w\s\(,\)[\]*]|::)+[\w\s\)*\]]\s+\**\(?_IO_ARRAY_END\)?\s*(?=
<params>\((?:[\w\s,;[\]*\?:+-]|(?&params))*(?:\.\.\.)?\))(?:[\w\s\(,\)[\]]|=
::)*;
	(?s)^[\w[](?:[\w\s\(,\)[\]*]|::)+[\w\s\)*\]]\s+\**\(?M_DECL_FUNC \(__ARRAY=
_END\)\)?\s*(?<params>\((?:[\w\s,;[\]*\?:+-]|(?&params))*(?:\.\.\.)?\))[ \t=
]*\n*(?<space>[ \t]*){.*?^\k<space>}
	(?s)^[\w[](?:[\w\s\(,\)[\]*]|::)+[\w\s\)*\]]\s+\**\(?_IO_ARRAY_END\)?\s*(?=
<params>\((?:[\w\s,;[\]*\?:+-]|(?&params))*(?:\.\.\.)?\))[ \t]*\n*(?<space>=
[ \t]*){.*?^\k<space>}
	(?s)^[ \t]*#\s*define\s[\s\\]*ARRAY_END\b\([^\(]*\)(?:(?![^\\]$).)*.*?(?<!=
\\)$
	(?s)^[ \t]*#\s*define\s[\s\\]*ARRAY_END\b(?!\()(?:(?![^\\]$).)*.*?(?<!\\)$
	(?s)^(?:[\w[](?:[\w\s\(,\)[\]*]|::)*[\w\s\)*\]]\s+)?\b(?:struct|union|enum=
)\b[\w \t[\]:]*(?<!\w)ARRAY_END(?!\w)[ \t]*\n*(?<space>[ \t]*){.*?^\k<space=
>}[^;]*;
	(?s)^[ \t]*typedef\s+[^{};]+\bARRAY_END;
	(?s)^[ \t]*typedef\s+(?:struct|union|enum)\b[\w \t[\]:]*[ \t]*\n*(?<space>=
[ \t]*){.*?^\k<space>}\s*ARRAY_END(?:\[[\w\(,\)]\])*;
	(?s)^[ \t]*typedef\s+[^{};]+\(\**ARRAY_END\)\s*\([^{};]+;

	$ grepc_c -tfld open
	(?s)^(?:COMPAT_)?SYSCALL_DEFINE.\(open\b[\w\s,;[\]*\?:+-]*\)[ \t]*\n*(?<sp=
ace>[ \t]*){.*?^\k<space>}

And those regexes can actually be used by git-grep(1) with -P (and -f):

	$ grepc_c -tm ARRAY_END
	(?s)^[ \t]*#\s*define\s[\s\\]*ARRAY_END\b\([^\(]*\)(?:(?![^\\]$).)*.*?(?<!=
\\)$
	(?s)^[ \t]*#\s*define\s[\s\\]*ARRAY_END\b(?!\()(?:(?![^\\]$).)*.*?(?<!\\)$
	$ git grep -P -f <(grepc_c -tm ARRAY_END)
	include/linux/array_size.h:#define ARRAY_END(arr)  (&(arr)[ARRAY_SIZE(arr)=
])

This is interesting to be able to search for code definitions in the
past:

	$ git grep -P -f <(grepc_c -tm ARRAY_SIZE) v4.0 -- include/
	v4.0:include/linux/kernel.h:#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(=
(arr)[0]) + __must_be_array(arr))
	$ git grep -P -f <(grepc_c -tm ARRAY_SIZE) v7.0 -- include/
	v7.0:include/linux/array_size.h:#define ARRAY_SIZE(arr) (sizeof(arr) / siz=
eof((arr)[0]) + __must_be_array(arr))

But it only works for single-line matches.  It'd be great to be able to
use these multi-line patterns for searching.

BTW, one can already search in the past, but one needs to know the file
in which to search (which is possible, if you know the file in the
present, and use git-blame(1) to investigate the history of it).

	$ git show v6.0:include/linux/overflow.h | grepc -tm struct_size
	(standard input):#define struct_size(p, member, count)				\
		__builtin_choose_expr(__is_constexpr(count),			\
			sizeof(*(p)) + flex_array_size(p, member, count),	\
			size_add(sizeof(*(p)), flex_array_size(p, member, count)))

Does this feature make sense to you?


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--r2qljlfwmz2fslvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr8jCcACgkQ64mZXMKQ
wqlStA/7Bz+Bg3ebQRkDhmY2wYfcUX+fVy9wrPjO0+vAk1Xa+7qz1cvPSROLD4iS
1+TNkCdSHIuBaOU1Sa7guRy9D1YcFuKXFaTb0Cp4IY7PQ2ljCFmQEf9QsFjuJ+yO
Z3ML6sAaun6CnE2PvrOT/DN6krj0eRKEQNFLDXqjS9gxwS9y2v13jVTGCJTwZA9h
BzysDKcp6LUlhRuh1iKG6Eu4QthN3fhyL8DiLCPAWKDU4d6wnYFxftSko6HY4bco
JtsiRrfSySZlTIQQ03Oo89RqwfCsL0gNEnaXhbP7G230yW2bj1q4FrnTcFKF0qJo
mTxodrTHXrKlEtxM1l7JEv3t9RcS6oEkNuanXVjIcrYe14uiShiM9dUHPRgzq7ZY
x/NZ4e6CehZubj1EOgxigg2XRiMOHksZA+3EAZ2rd/nDcXWa9/nsmgfM0pK1tz6l
bSrAbpznxRYEq/XLEGge9G2QspfTmZ7LGGTDTvFknGB0rtW2hl8XE/wNljaS7Fth
2vctIE7DKbTyzCw/vIk2PqvJOgq2HWrHCRkl0T4oJFSgA9GAzi/odi0eBkDyP83a
SXO9j1YsxtnbOlQBUokL0ZLLJcd6R6Sra+MZzP7oYpIg8Rj3webbkWGskDnp4y94
22Q3tnQh4oJLnsc+35R4CQztzCe2xCmJ+O/tASRHPf/dRXfbOVs=
=iOyH
-----END PGP SIGNATURE-----

--r2qljlfwmz2fslvw--
