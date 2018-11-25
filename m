Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553731F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 23:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeKZKmu (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 05:42:50 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55854 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbeKZKmu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Nov 2018 05:42:50 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c029:e61c:1a0c:a1e6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DBE86609D4;
        Sun, 25 Nov 2018 23:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1543189830;
        bh=yyUhQvAO9HbNe74pzq3/HIaT2Gxj3/JF6i79IDX2ioY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NRzuigCGHNtCkkH/9u3PG4nMFR74yx3jSva9jcIGAf2yrek/u9JewqpX+6hU/UqSJ
         UYadM77IE31SmIE+qvv1GxSTj+8aBy7bGWve4B20hy5Bc7STqUu89U5XaJ7DAxHmn+
         15MXujOwmSLJ0rQPKRCQflm0FxB8ZA1+XVJeIWKG/lRd7vPtLLLvjngRCrC3YQYiPN
         6Q2dCMnUfdmQH/tz3AY1UfinuaWEyV2EmEeGnwzwKy8GyXR9BLKRR3pQqWZUTcOiXP
         WUNRCC8H4RvmERV5Ox8J40ZrWr4pxVPVjuF9WMvijY8L8Qg2WTlRUhgBnib9AKV4qS
         VsV+JxjMsvWw2rwjzqHB2nZoygYB7OP0IRD3I8mCXU49Zcjm6cHXp2p5OIN/b8Hz/d
         0J/VFWmOQf9z8/sYZXv5RbXTVrcRmUiEOqwAdGDVgs1IxVL8id4/IADBF0PuXj/nhJ
         xN5JSlAcw+2iDo1026KJVSMISyZF6PcVv4ysaszyXlazjGQSfK6
Date:   Sun, 25 Nov 2018 23:50:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Frank =?utf-8?Q?Sch=C3=A4fer?= <fschaefer.oss@googlemail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
Message-ID: <20181125235023.GS890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Frank =?utf-8?Q?Sch=C3=A4fer?= <fschaefer.oss@googlemail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
 <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
 <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="szdyR02yM8NCQUEm"
Content-Disposition: inline
In-Reply-To: <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--szdyR02yM8NCQUEm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2018 at 03:03:11PM +0100, Frank Sch=C3=A4fer wrote:
> Am 24.11.18 um 23:07 schrieb Johannes Sixt:
> > I don't think that there is anything to fix. If you have a file with
> > CRLF in it, but you did not declare to Git that CRLF is the expected
> > end-of-line indicator, then the CR *is* trailing whitespace (because
> > the line ends at LF), and 'git diff' highlights it.=20
>=20
> Sure, it's correct to highlight it.
> But it doesn't highlight it in removed lines, just in added lines.
> I can see no good reason why removed and added lines should be treated
> differently.

The default behavior is to highlight whitespace errors only in new
lines, because the assumption is that while you don't want to introduce
new errors, you can't do anything about old mistakes without rewriting
history.

I agree that in many circumstances, such as code review, this may be
undesirable.  In the past, I've done code reviews where I may let
existing trailing whitespace go but am strict about not introducing
new trailing whitespace, and being able to see both is helpful.

If you want to see whitespace errors in both the old and the new, use
--ws-error-highlight or set diff.wsErrorHighlight.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--szdyR02yM8NCQUEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.11 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlv7NT8ACgkQv1NdgR9S
9osZnhAAh1St/RyQ+lDaen6wdbU7idegpjSfABizNvZ0WlGO2TxYTcoECVmCeXQF
/7y6x2mZe+i3TsNiLAUEGoWTcFrx8jWH41w1PoYIO2q/0qgr4v/frkUVh0wSNF2X
vXMGVBrlfRUmLN8s7TGLa2j5cUJ8CDVhXqdVGTYSqy1KVqv1TYIW5WHqZQViZwcU
rHgCOqw0K9lEv4gaFDx7Z35VNxc/4srhi6aoV3zwO2fCgQcVWzL3jTzTgWFeK22J
RORjHqfGAGT4jlWHefLYsCnyc1oLivqGQlLh8eDIZfSGuxeK1+8cSU+u/rK4yhar
S8ho2AXBiPXkS0WjDYW+aMeQwkXZQVRl99PfbP3hwZgu92H1UHOhFW46b8e2D4YT
rMX1lC/J49Tl8v57S/tCnzWgbIJ35EvzCRxiTFgtOlveDdo5A23mtF+bJ/h4QomF
JLXm/fL1mEFMgsrYWhD7IDwpuTZnH4oJLMZa+FQajCCCo97YQCLDtj3McxQUWwb7
ZKwb20FGNKjfRKpwOfBLssVuwZh3t265ZOQ/A44h2NQScKu5Dk3cHFpZF3l35Pg4
x4JFkhR12xW2drAqQ07Qx6r8aLQiggF7EZi0/rwC1gHmRDXn7n4GS9nmtGVt0dJg
0SM7AM0NGIE5zhoLKMqlXdXab7k3MZ7RGtA0TntlbMB4RNmcACs=
=DTkx
-----END PGP SIGNATURE-----

--szdyR02yM8NCQUEm--
