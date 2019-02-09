Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB281F453
	for <e@80x24.org>; Sat,  9 Feb 2019 00:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBIAZI (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 19:25:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33962 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbfBIAZI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 19:25:08 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d42:63e7:5548:1ee8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2E92960737;
        Sat,  9 Feb 2019 00:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549671904;
        bh=XbcYJ8DKo9rGEGG2WiDAB0iU/a3TB9BNfSNjJ6pNEDY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JN1VSxOgKdw/k7lj1uoit8Flqj6FbP6IdRru7TUdHGOxipt1r031aNCtjwSZ1WcJt
         t/jMbiO0drKTQiqKgWN+EcKmO+I6Ec2VmFd/6DiqWeGu3m4PSHtTPpmmpe9zioOA6r
         0oYjzJVTOvsPP0unr4mQk8/nu3g0V5PX0PDQ5ooBMoCWZk9LYPdypnF7GY1KcvUa8p
         XF1lPlWEyfIysUUs+k7pvuI/GkA0/+lpg2G2Cc83FGNEPNVlEyEG4JrtzUxq1CnNOr
         erBLdTFbnMzakd4lSooMcU14FoJgIzMeHNWciq6kMTe6agiK0SpxbGJl7g9haQcpsf
         Z3dj+74+EDUkGjaF0Txgby5dK0NnbnnchqXX+MYGPO86g0I3f7Y7qn+C0hAJ6GBrx3
         ppgDP4J2k5dLS8guGBlYDiUFXuV3qRyQwiaP9jTyBTavETLGqWi+CLNDNcA5q+oVFe
         jN3Eoad7ZID0NrS1xH9CrwCyimtkunaAdmK01O6lruvS5kz+zE4
Date:   Sat, 9 Feb 2019 00:24:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rich Felker <dalias@libc.org>, git@vger.kernel.org,
        larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems
 (Alpine Linux)
Message-ID: <20190209002458.GJ11927@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Rich Felker <dalias@libc.org>,
        git@vger.kernel.org, larsxschneider@gmail.com
References: <20190207215935.GA31515@alpha>
 <20190208001705.GC11927@genre.crustytoothpaste.net>
 <20190208060403.GA29788@brightrain.aerifal.cx>
 <20190208114502.GD11927@genre.crustytoothpaste.net>
 <20190208115511.GA30779@alpha>
 <20190208135137.GE11927@genre.crustytoothpaste.net>
 <xmqqr2cikw4w.fsf@gitster-ct.c.googlers.com>
 <20190208202336.GA5284@alpha>
 <20190208204219.GF11927@genre.crustytoothpaste.net>
 <xmqqd0o1kh7t.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P6YfpwaDcfcOCJkJ"
Content-Disposition: inline
In-Reply-To: <xmqqd0o1kh7t.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--P6YfpwaDcfcOCJkJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 03:12:22PM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +test_lazy_prereq NO_BOM '
> > +	printf abc | iconv -f UTF-8 -t UTF-16 &&
> > +	test $(wc -c) =3D 6
> > +'
>=20
> This must be "just for illustration of idea" patch?  The pipeline
> goes to the standard output, and nobody feeds "wc".

Well, as I said, I have no way to test this. This code path works fine
on glibc because of course we would never exercise the prerequisite.

But I do appreciate you pointing it out. I'll fix it and send another
test patch.

> But I think I got the idea.
>=20
> In the real implementation, it probably is a good idea to allow
> NO_BOM16 and NO_BOM32 be orthogonal.

Sure.

> > +
> > +write_utf16 () {
> > +	test_have_prereq NO_BOM && printf '\xfe\xff'
> > +	iconv -f UTF-8 -t UTF-16
>=20
> This assumes "iconv -t UTF-16" on the platform gives little endian
> (with or without BOM), which may not be a good assumption.
>=20
> If you are forcing the world to be where UTF-16 (no other
> specificaiton) means LE with BOM, then perhaps doing
>=20
> 	printf '\xfe\xff'; iconv -f UTF-8 -t UTF-16LE
>=20
> without any lazy prereq may be more explicit and in line with what
> you did in utf8.c::reencode_string_len() below.

No, I believe it assumes big-endian (BOM is U+FEFF). The only
justifiable argument for endianness that doesn't include a BOM is
big-endian, because that's the only one supported by the RFC and the
Unicode standard.

I can't actually write it without the prerequisite because I don't plan
to trigger the code I wrote below unless required. The endianness we
pick in the code and the tests has to be the same. If we're on glibc,
the code will use the glibc implementation, which is little-endian, and
therefore will need the tests to be little-endian as well.

I will explain this thoroughly in the commit message, because it is
indeed quite subtle.

> > diff --git a/utf8.c b/utf8.c
> > index 83824dc2f4..4aa69cd65b 100644
> > --- a/utf8.c
> > +++ b/utf8.c
> > @@ -568,6 +568,10 @@ char *reencode_string_len(const char *in, size_t i=
nsz,
> >  		bom_str =3D utf16_be_bom;
> >  		bom_len =3D sizeof(utf16_be_bom);
> >  		out_encoding =3D "UTF-16BE";
> > +	} else if (same_utf_encoding("UTF-16", out_encoding)) {
> > +		bom_str =3D utf16_le_bom;
> > +		bom_len =3D sizeof(utf16_le_bom);
> > +		out_encoding =3D "UTF-16LE";
> >  	}
>=20
> I am not sure what is going on here.  When the caller asks for
> "UTF-16", we do not let the platform implementation of iconv() to
> pick one of the allowed ones (i.e. BE with BOM, LE with BOM, or BE
> without BOM) but instead force LE with BOM?

This is more of a test scenario to see how it works for musl. My
proposal is that if this is sufficient to fix problems for musl, then we
wrap it inside a #define (and Makefile) knob, and let users with an
iconv that doesn't write the BOM turn it on. Now that I'm thinking about
it, it will probably need to be big-endian for compatibility with the
tests.

I plan to treat this as a platform-specific wart much like
FREAD_READS_DIRECTORIES. Inspecting the stream would be complicated and
not performant, and I'm not aware of any other iconv implementations
that have this behavior (because it causes unhappiness with Windows,
which is the primary consumer of UTF-16), so I think a compile-time
option is the way to go.

I'll try to reroll with a formal test patch this evening or tomorrow.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--P6YfpwaDcfcOCJkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxeHdoACgkQv1NdgR9S
9ouRJhAAjZIC8/ZLoKVkIWwRq+i7qD0b7y2uS4C0PYZsVqvxvsX1dzLGaoffRVo2
oFj92n38fD8oQpqrsZgANirKZB+UFNsCaoOnpJGy33L0wDQO5fcoDHVmi3Xrceg6
V4jStrr3QgSs/4wBY1S5Cam/U92cSO2iJ68Wy37YoIiXejmlZRCxjOuhmGcEnFRU
8EKazx/LXf7DC5OH3p8a3lLyJaPcLDNKsm9+xJzKYc2zKyoOq2VgNL925oqJG+Vf
LqWzB5dFQ/IAatCp9nT8CEgxCDTrVoP7PVPhQ+VHir0yo2NM5JgfV6SvK10bb2K3
uC0zWdGR59PxWfcPjjveYWambnMjl4nbIE+cVMmZf7t+ufkZHN+pU4Nr2dfaJ8Ec
YWnTYrVKL59EDlBxPNhWj2b4llD69LZHia3JiVPB0VFl2ZLUemKh+XvV/HOOINYf
Qilobw1ygJ91zKCeYe5AAS7wDsxEJ16sraIMUUoPEeU3kD+qgpiQ2eG/Q1VpFtFy
rPBsvyBSdHRsTlf8wKJHd3iur3f2wgss3rNpFe2H6kc2OhuF64MRvxFsex4m23ke
2funFBgcwSKK8m7FqlM4t1+6wtM4ZD6ISlVb7+wje7E3766hhridx8nIGC54WNCD
EbuTlfAPtyUDSQcG99ZpdmdvIwfXv+dk+qu/sK7q7m97DwbZbfE=
=1qUj
-----END PGP SIGNATURE-----

--P6YfpwaDcfcOCJkJ--
