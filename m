Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8029A1CAB2
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427057; cv=none; b=Tgr0uq3o/gib9TJgTQlIijpReP/tv5Mn5Iug41LDJr+mYHNTV9VS2EzYlcxK/u+XXQ92Fy8PL/nocK55FmvUNGcZUitw+lDU3dZA3RwHJRrgtfZEm9UE7LdNds5tRCMM/fk9DUoqYhPif1gYO9DhGhzl7AGI7niQRGn/pkRu5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427057; c=relaxed/simple;
	bh=oVUnRUCpHXwP4bN4nO3JQwq/FInQLj4ff8XeVJ+w/LE=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport:Content-Transfer-Encoding; b=GF2M9pSakpBK6mppWaZbYcO9rBfF2zUq+UG57DRiMH63AoIYiiUvIBfOPGU4DIHatmWHPQlnV6Tg/e3I/665u31rbFRIS83wn8tpCZI/Nox9soR/gOpAb8oElKBRv/iVVi3r4zq6auqHfA97/w+92cVt8O4GoPxpKskXvoH2REc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=gY97TocR; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="gY97TocR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705427041; x=1706031841; i=tboegi@web.de;
	bh=oVUnRUCpHXwP4bN4nO3JQwq/FInQLj4ff8XeVJ+w/LE=;
	h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
	b=gY97TocRMC+8AihQR3ywCQ+5XUsMA3Y3Oa7Dtfa3LXgZqe5KfOfBKhpyMfWmmrRH
	 yaz10oHwS1k87+zwu6g7zaXC19A6GAfIm/yW3phXkf/IgZLYcdLgjHbZ5RPSSMFSP
	 M8Afbie5o37+WCUIBo0kYnYadoaRXKSO+VIDrZa9z0mnTeie3Fbz6W91+FzfLg9ND
	 4oe2Zyr/ZCod131HOmHOEe1s2iDasqywcLuD0mmawir1PM3qs/dfVEEwMR/+3OrCy
	 GyOgZCM/JznlFVZJX/IPn+5ZowjdnU3wAd1spldtyQxbcDEsBAiZvCTGgN1Lpls0Q
	 iKqdZyNH6FTVnK6UEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElZP-1rNNxy2cRf-00G13t; Tue, 16
 Jan 2024 18:44:01 +0100
Date: Tue, 16 Jan 2024 18:44:00 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Litwak <michael.litwak@nuix.com>,
	Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Suggested clarification for .gitattributes reference
 documentation
Message-ID: <20240116174400.GA2353@tb-raspi4>
References: <SJ0PR10MB569379A093B83BE01A04C789FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <ZaG0EkADl8hQZaqf@tapette.crustytoothpaste.net>
 <SJ0PR10MB56937175632E5D82793CE13EFA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <SJ0PR10MB56932ABBEEEC6F8ADE23995AFA6E2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <20240113074323.GA6819@tb-raspi4>
 <SJ0PR10MB5693A19B0B66F47B2A985739FA732@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <ZaXkt715TjNpuprG@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaXkt715TjNpuprG@tapette.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:T8WxnKcgasFbnImscvevqGr1sE/OUAUmo6eAVtDCitOgNTdMyq/
 s+9nf/taiFm4fp9da8vDU1BT0w7rL4T2qMxpKbN/H9+z+9YVujAG9MiaiBaVkezQOTkTOLp
 XHXoYE6P3uJ6bLu0zzcUr9m6GhioVLmKFkwulP8HlIvxqTUb1FAvAlAOQuU35esxEydIWZv
 V28N4AwKQRrSQKrBjFUMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YnihdeRPLD0=;tEihi3mJcxxK3LoF5AnuKPFNapz
 CVW6ZqgzJhr4vkOMMOaoEOJUnHtx/OcvDAzG7TX9XD+fQQTF47hjl+Pa35L94GIIwtoTu0vDh
 21XYdwLgU5pBXgzS+gwT8EWAGLd9zHoiDXRaqJ/O9m5Y9SI+2hfZ8+0PQKIDgQwjWCRtid7pS
 zoKx+574aZmavGq6n+L7sIP2A1heEuunb/Ozg1OpxLIlnbXwsqIC+FzqwFJMjqvnXyq0xQteE
 p42yinzZA5ZPmol5JzWt5CuO1CgC8v5BaTK40JDPkJnsvBLctwTiUm7gieZJWodTpRyr32CVt
 F7U/8+4rhxJzjw72i9gfuSQr7kBNNayTGy0wrdDSZvtN2w1Ndf93oDtdD1Su2PyewKFIGTLXO
 sqUHPr7DVXw8I4UxZuYdQXFeBIcItX3SxSWoHaVy2blumCNMZO9SBXUPLBztRk9iqiRk1badH
 NrZLWoqjUP+fyCZzjOrUsi4H45zASh+2VMfuma0eHCXJDSt2vItBQWNilWzzrxcJUk4DfrR5a
 oHXvXzIuHr0DOq+e+sct7svSe+CQc+AoPrxEgUguqmMtAwNKV5j55a1QYEdYg1Fh1vZAEWkIy
 36CyA3uiEBPBbBieXIcrmeYW5mEwaGLfx2t476adRXRM+LvGcXkN+EtXG2GIWA4QOGlaDWjmA
 fx90iO5Wq5BzZ6wvsymX6DV7X54YFmMLKbOCkb97r2eYTi7ncKB89x0VqynNj4Ed6UIXGJj0e
 r8RIdstIpTgP15Aj/T6K0aA6VN6bbtBulQJlEhPq/T0hNoOhlH5raQYaISGvgo6yzbpezuQFr
 EF6TGDgGhDTP0ooJLv7yuMlEa9ByBunQUDcMMCHj91ZQlMQU+978eB8i6kW/LxKndDCX47RVR
 mLc7t0gqLot9KDr15FsEBlwf8h4UNEloMukbVGgEz1aTYayIJjrS9tzgMru89Ymp+WuMOeFb2
 QSci0SMwarKyX9qhMvtIIa6V3SI=
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 02:06:47AM +0000, brian m. carlson wrote:
> On 2024-01-16 at 00:19:20, Michael Litwak wrote:
> > As for documentation clarifications for the .gitattributes manpage at
> > https://git-scm.com/docs/gitattributes, I still suggest adding an
> > explicit example for UTF-16LE with BOM, and/or adding a table listing
> > which working-tree-encoding value to use for each of the following
> > UTF-16 text encodings:
> >
> > ENCODING              'working-tree-encoding' VALUE
> > -------------------   -----------------------------
> > UTF-16LE with BOM     UTF-16LE-BOM
>
> I should point out that this encoding, while very common on Windows, is
> also nonstandard.

In general, I agree with everything that is snipped, thanks for the ong wo=
rdings.
[]

> (Apparently Emacs, which is not on my system, may
> permit that, which does not surprise me in the least.)
emacs seems to handle UTF-16LE-BOM just fine.

>
> > UTF-16BE with BOM     UTF-16
>

[]

> I think the addition of this table is too much.  UTF-16LE-BOM is common
> on Windows, and the rest are substantially less common.  It's also very
> difficult to explain in a table what "UTF-16" means in an understandable
> way.  And I also think it's also pretty clear that users should be using
> UTF-8 without BOM where possible.
>
> We do already mention both UTF-16, UTF-16LE, and UTF-16LE-BOM as options
> in the gitattributes manual page, and it's up to the user to know what
> their program wants and supports if that's not UTF-8.

What exactly is missing in the documentation ?
Could you please try to send us a diff (or even better a patch), so
that we can get an idea, of what can be improved ?
=46rom my reading UTF-16LE-BOM is already mentioned.
It would be nice to see (from a user), what is probably missing.


> > Finally, I am not sure how to use git add --renormalize to correct a
> > UTF-16 file that was previously added incorrectly (i.e. with a missing
> > or incorrect working-tree-encoding entry in .gitattributes).  The git
> > add documentation at https://git-scm.com/docs/git-add implies
> > 'renormalize' resets only the end-of-line values; however, I suspect
> > it also re-converts text encoding when a working-tree-encoding
> > property is set.  It would be helpful to know one way or the other.
>
> It does indeed affect the working-tree-encoding.  If you wanted to send
> an inline patch created with git format-patch, it would probably be
> welcome to mention that.  However, because in this project we typically
> scratch our own itch, if you don't send one, it's likely nobody else
> will, either.

For the record: It will even run the "clean" filter, if it has changed,
or being freshly enabled.
So yes, a patch would be appreciated.

Thanks for bringing this up.
