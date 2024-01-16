Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1038C
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 02:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DD5o1H55"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B39945A3C4;
	Tue, 16 Jan 2024 02:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1705370810;
	bh=9IeMbib/kaiuKqYVspp3SDTMgnepOY5moNTY+lAj3vU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DD5o1H55Wt5abV4kllyM9SrCbsA4IHwWXuiuLLvLZqdz/WKvcTcAN1kGg3xFgFHVo
	 SBGNiCUgYIU9A7NUZwr3Efek4OMrNMQAYxg9EfQX+yAOhtmFxJvUm9hEHE2aHMciBe
	 2LP1SqsHyFkGZZWgDphBO/I1/pCSa0lmdkux6oIVRhQNpLECEm5kcrPe7+iMBWazpF
	 qwgrsYeutIwZ6ow1LO98IqPqtESkaMwgXVcCLfUu+UARJ1okX3xWerfjpxb2p+WK1h
	 T2HrTKsEosoAZvx2WRYe5inCorBebbid3pULRJLm4oQ0/r3bY0k8uRnYPO1iXBi9V3
	 I6PbWCIOvpVh4rFGeEnCqhGrBniHt55pdvqgK+b7UfomV6gnQjf/2YlzaZm2mjUgs8
	 REfC0EdoO6zDTpV99oifijOAvfkt6KMmx3iazrGafRk1qxKMm44YkBJGOD43yiTHRg
	 Mk12gzIb/A7bChOqq/LNQvts/+0ZCiAbkkKNlFssBbczioIV5fu
Date: Tue, 16 Jan 2024 02:06:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Michael Litwak <michael.litwak@nuix.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Suggested clarification for .gitattributes reference
 documentation
Message-ID: <ZaXkt715TjNpuprG@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Litwak <michael.litwak@nuix.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SJ0PR10MB569379A093B83BE01A04C789FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <ZaG0EkADl8hQZaqf@tapette.crustytoothpaste.net>
 <SJ0PR10MB56937175632E5D82793CE13EFA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <SJ0PR10MB56932ABBEEEC6F8ADE23995AFA6E2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <20240113074323.GA6819@tb-raspi4>
 <SJ0PR10MB5693A19B0B66F47B2A985739FA732@SJ0PR10MB5693.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bVYFgFSQZMWtfXh7"
Content-Disposition: inline
In-Reply-To: <SJ0PR10MB5693A19B0B66F47B2A985739FA732@SJ0PR10MB5693.namprd10.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--bVYFgFSQZMWtfXh7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-16 at 00:19:20, Michael Litwak wrote:
> As for documentation clarifications for the .gitattributes manpage at
> https://git-scm.com/docs/gitattributes, I still suggest adding an
> explicit example for UTF-16LE with BOM, and/or adding a table listing
> which working-tree-encoding value to use for each of the following
> UTF-16 text encodings:
>=20
> ENCODING              'working-tree-encoding' VALUE
> -------------------   -----------------------------
> UTF-16LE with BOM     UTF-16LE-BOM

I should point out that this encoding, while very common on Windows, is
also nonstandard.  The standard says that UTF-16LE and UTF-16BE don't
include a BOM and are always the respective endianness.  UTF-16 can have
a BOM or not, and if it doesn't, it's big-endian.

There is no standard-conforming way to force the use of little-endian
with a BOM.  The problem is that many Windows programs insist on the
BOM, but also refuse to read big-endian data in violation of the
standard[0].  That's why this nonstandard variant exists in Git.

I'll also note that this particular nonstandard variant is essentially
impossible to encode reliably on Unix outside of Git because it's
nonstandard, so it's an extremely unportable choice.  In fact, I'm not
aware of _any_ tool on my Debian system other than Git that will
guarantee a UTF-16 little-endian stream with BOM.  My editor (Neovim)
certainly doesn't.  (Apparently Emacs, which is not on my system, may
permit that, which does not surprise me in the least.)

> UTF-16BE with BOM     UTF-16

It's a little more complicated than that.  "UTF-16" would allow UTF-16
big-endian with BOM, UTF-16 little-endian with BOM, or UTF-16 big-endian
without BOM.  In other words, UTF-16 is big-endian by default and
otherwise requires a BOM, which may be included even if not required.

A reader must handle every variant of this, and must honour the BOM if
set and default to big-endian if not.  A writer may write whichever
variant pleases it most as long as it's consistent within the same
message.

> UTF-16LE no BOM       UTF-16LE
> UTF-16BE no BOM       UTF-16BE

I think the addition of this table is too much.  UTF-16LE-BOM is common
on Windows, and the rest are substantially less common.  It's also very
difficult to explain in a table what "UTF-16" means in an understandable
way.  And I also think it's also pretty clear that users should be using
UTF-8 without BOM where possible.

We do already mention both UTF-16, UTF-16LE, and UTF-16LE-BOM as options
in the gitattributes manual page, and it's up to the user to know what
their program wants and supports if that's not UTF-8.  (I would say that
the user wants a new program that _does_ support UTF-8, but perhaps I'm
being unrealistically harsh.)  I agree it's difficult because the
documentation usually doesn't indicate what's supported and all the
variants are hard to understand, but that's a huge part of the reason
that we recommend UTF-8.

I'll also add that in general, when you do have Unix systems that read
or write data in UTF-16, they handle every variant correctly.  Thus, the
practical choice if you steadfastly refuse to use UTF-8 is either
UTF-16LE-BOM (if your Windows program has the bug I mentioned above) or
UTF-16, both of which we mention already in the manual page.

I'm explicitly ignoring non-file contexts here, where one may use
UTF-16LE or UTF-16BE, but those are substantially less common in actual
files, which is what this feature describes.

> Why bother clarifying the documentation?  Because These UTF-16
> encodings are commonly found on Windows systems.  Notepad supports the
> first two, and many Visual Studio project wizards add various files
> using these encodings as well.  Older versions of PowerShell saved new
> .ps1 scripts using UTF-16BE with BOM as the default encoding.

True, but Notepad also supports UTF-8 and has for quite a while.
According to the Powershell documentation[1], there is no portable
character set option for non-ASCII characters, so in general it's
impossible to know.  I suspect that a simple "UTF-16" will be fine here,
though, since it clearly doesn't have the bug mentioned above.

> Also, the current .gitattributes documentation makes frequent
> reference to "UTF-16" as an encoding but fails to be clear that the
> working-tree-encoding value "UTF-16" is now only for UTF-16BE with
> BOM.  It would be easy to assume that the working-tree-encoding value
> "UTF-16" meant any UTF-16 file with a BOM (either LE or BE), which was
> the original meaning of this value before UTF-16LE-BOM was added to
> Git.

As I said, your statement isn't correct.  That's what libiconv does on
Windows. On Linux, glibc uses a little-endian variant with BOM on
little-endian machines.  musl, if memory serves me, always uses
big-endian without a BOM.  All of those are valid encodings, and a
UTF-16 reader must handle all of them.

> Finally, I am not sure how to use git add --renormalize to correct a
> UTF-16 file that was previously added incorrectly (i.e. with a missing
> or incorrect working-tree-encoding entry in .gitattributes).  The git
> add documentation at https://git-scm.com/docs/git-add implies
> 'renormalize' resets only the end-of-line values; however, I suspect
> it also re-converts text encoding when a working-tree-encoding
> property is set.  It would be helpful to know one way or the other.

It does indeed affect the working-tree-encoding.  If you wanted to send
an inline patch created with git format-patch, it would probably be
welcome to mention that.  However, because in this project we typically
scratch our own itch, if you don't send one, it's likely nobody else
will, either.

[0] https://datatracker.ietf.org/doc/html/rfc2781 =C2=A7 4.1: =E2=80=9CAll
    applications that process text with the "UTF-16" charset label
    MUST be able to interpret both big- endian and little-endian text.=E2=
=80=9D
[1] https://learn.microsoft.com/en-us/powershell/module/microsoft.powershel=
l.core/about/about_character_encoding?view=3Dpowershell-7.4
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--bVYFgFSQZMWtfXh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZaXktwAKCRB8DEliiIei
geQ4AQClGBbbJVtMIGWAujd4A1geY7gz4q0EJxp2jDf5CEjCtwEAqMtkVxOUANvb
GSiIGBUuSB+GF1Ie9cnx+hcFvJhaIAE=
=E34N
-----END PGP SIGNATURE-----

--bVYFgFSQZMWtfXh7--
