Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890371FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 00:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbcFYAwo (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 20:52:44 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52718 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751446AbcFYAwn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 20:52:43 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E5FD42809F;
	Sat, 25 Jun 2016 00:52:39 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466815960;
	bh=VgsWbMdFwvNXKSVsA2mzZ2JRVhqDjEZy7CWfqK0ysG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isgItpANJSFzt43tm1Kw/UVISHT1yfnOPqMbH+3de/ZHco+2445cn+OItxGLZO/Yx
	 GICnRGCTALYbz0qCWLMvgs0G+FAG2lVlcHRJWwiEsAWHaovWEeryTMrP738xJ+oqJK
	 7A33XESObJZcJJr2HIJFWaHxSYfvfchCoxse6+VLKAL3/h526nW4JZ3J9BgG5eLZGX
	 CxHPJiRzFiWMfOXuwZFQ0q+e+Qv0ITrpQvdn+oSveH+KrNwGGyzdQKblxK/g20d6Ga
	 CFUmksMDsuLwm6nieyj3JmbLQdIHku6KxrKrpdFuN2phhdYHCKT2YetEQVu35xY8Dw
	 eI0RQGFruy/QUx3hfwOWgHWfniJox7AnaFk9w3Fs4AU/q0Cu6ADTit85+vU7/XG7Ik
	 F1xmb6RyxVbpEN8Feq8mvUHFTaxpSdewFBijbzgjaYM+wSTHVSJ2Ty9yI1XsCN5Dm2
	 dNsw6IzJdWo0lGUrQGXAdL1HTcW498NuGLpZJeEQUyn3ujuiNta
Date:	Sat, 25 Jun 2016 00:52:35 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 06/11] diff: rename struct diff_filespec's sha1_valid
 member
Message-ID: <20160625005235.GB7035@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
References: <20160624230929.82222-1-sandals@crustytoothpaste.net>
 <20160624230929.82222-7-sandals@crustytoothpaste.net>
 <xmqqfus2dsbl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <xmqqfus2dsbl.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.6.0-1-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 24, 2016 at 05:29:18PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
>=20
> > @@
> > struct diff_filespec o;
> > @@
> > - o.sha1_valid
> > + o.oid_valid
> >
> > @@
> > struct diff_filespec *p;
> > @@
> > - p->sha1_valid
> > + p->oid_valid
>=20
> Totally offtopic (from Git's point of view), but why does Coccinelle
> need both of these?  I recall that between v1 and v2 there were some
> confusing discussions about the order of these equivalent conversions
> mattering and the tool producing an incorrect conversion in v1.

As I understand it, Coccinelle doesn't transform . into ->.  Granted,
the latter is a special case of the former, but it might break workflows
where you're trying to convert an inline struct to a pointer to struct
or such.  It errs on the side of you being more explicit to allow more
flexibility in usage.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXbdXSAAoJEL9TXYEfUvaLP/gQAJAXxxrTgNGZ0b4ikXYCjzGu
wWfE68CpNsuk+YmMBaZvptdgyndLIeSEsVKQwEWEXIkZRvatVjET5bzrr7eO5rb6
YyBpYFmQqxsNcJ4nMdvYpuvodKp9qOYILZpoVpnA6imc1d/lARG6tyANxzzeioMS
MWKalg2z8vyQl/TIo4gKX2ewTwMG+nPQW4NCWMcpTlyalmKWecJLBU7WtaXL+ktA
g9nG5zgoxuoNe3dIJry3uSuglIPz/BhbhyMwdxH/xC/+YvsWYfLywX/V+cYAkYae
py5uujd1POqj046QtgkjxrMo957GFt7bME3XXtLLcZsBPRYuUEreTP8hi3iOU2Hr
BiK60cs3MKeisuBgd8i74VLHNjsJt4/jkx3FeK1c85/4H9zzLGYXyZukDDOKxd/+
E1QuKNhaGgtCgdzM4YaRvj/B/Y2sgY0TCQTgBVhiv0PiwbZG0hPbXIxGuDnH22JR
uJAy7p6YEbwiGfbwf3t5uRYTjwbGmNxy3jf2KNZnQlPOM2opmqEi8dYLJvuC9MSN
8Jcvt6MdfN1REkvT0pnMaP+PP3DTB6l8Df6XAApTHyBGkaK630JhOkaFA9ZDDFhX
dFT3ZBUFfUQsVcQCORBp7e32aqA6JvqTRQIrepmL8vHk0oLtng633a/XWNaXYyGN
Dzrr0H7ZSkZb1nBR2gaQ
=56d7
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
