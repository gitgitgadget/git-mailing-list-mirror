Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66DC2092F
	for <e@80x24.org>; Mon, 23 Jan 2017 04:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750734AbdAWEJZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 23:09:25 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59004 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750712AbdAWEJZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Jan 2017 23:09:25 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CA516280AD;
        Mon, 23 Jan 2017 04:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485144561;
        bh=kpfjsiBmdWYQ68D+yNnpoRJWrjqirUUizVI3QNDeeRc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=aHpva3hitNi+KexeWswmNjLcq8L1oWkgjRq9QWtNUVEyqb7SBuBoyaytnKlNuVTei
         sk7zJOrj8oyLyWrtLzA4Ucxs23/29CpSp+b03euPZh78Zi61ogmtoHNl/aWrx/TesG
         L2goitopQN8Z54LCLWYU8Uno5VNDvg8stPPYpKBul8hZMgQbo7WS7PgwCXdSgcFzgG
         ZWsaJdpGKSQ291zMNm2VXXt3tD3gPd8Je6TFu0+t50QRDO98juw/oqgXS2G7OWyrKm
         ADT/NxQ8nEsVC2SchF2zTMi2yCpnKQYWUlVYP3r0yisgyXjOhumpQjBcSitOg/liwl
         BBFfdHdGIWJI1tLYd/a4Fw6RWde+w7Y1uosHTQAS/j8BmURZFIxmZcVljWxb6lXFTI
         Av/P/a4vRNnImdmUUVljzdIznt/eLNOtvBt78Fk8RSK+6HJqSC2BzyoWPaK8MUYZcX
         kPxZwvVMpynZaHvTFMjsCA+cyCnBAgieI2L45WgbPIG6YBsmVvi
Date:   Mon, 23 Jan 2017 04:09:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 7/7] Makefile: add a knob to enable the use of
 Asciidoctor
Message-ID: <20170123040917.lrd6ic6wb6nxulzf@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20170122024156.284180-1-sandals@crustytoothpaste.net>
 <20170122024156.284180-8-sandals@crustytoothpaste.net>
 <20170123025712.o52hgkdu26h6lrm2@sunbase.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="du33dhs3k5wonoiq"
Content-Disposition: inline
In-Reply-To: <20170123025712.o52hgkdu26h6lrm2@sunbase.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--du33dhs3k5wonoiq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2017 at 03:57:13AM +0100, =C3=98yvind A. Holm wrote:
> On 2017-01-22 02:41:56, brian m. carlson wrote:
> > While Git has traditionally built its documentation using AsciiDoc, some
> > people wish to use Asciidoctor for speed or other reasons.  Add a
> > Makefile knob, USE_ASCIIDOCTOR, that sets various options in order to
> > produce acceptable output.  For HTML output, XHTML5 was chosen, since
> > the AsciiDoc options also produce XHTML, albeit XHTML 1.1.
>=20
> I applied and tested the patches on the current master, commit=20
> 787f75f0567a ("Sixth batch for 2.12"), and "make doc" with=20
> USE_ASCIIDOCTOR fails:
>=20
>   $ git clean -fxd && make doc USE_ASCIIDOCTOR=3D1
>   Removing Documentation/cmd-list.made
>   Removing Documentation/cmds-ancillaryinterrogators.txt
>   Removing Documentation/cmds-ancillarymanipulators.txt
>   Removing Documentation/cmds-foreignscminterface.txt
>   Removing Documentation/cmds-mainporcelain.txt
>   Removing Documentation/cmds-plumbinginterrogators.txt
>   Removing Documentation/cmds-plumbingmanipulators.txt
>   Removing Documentation/cmds-purehelpers.txt
>   Removing Documentation/cmds-synchelpers.txt
>   Removing Documentation/cmds-synchingrepositories.txt
>   Removing Documentation/doc.dep
>   Removing Documentation/mergetools-diff.txt
>   Removing Documentation/mergetools-list.made
>   Removing Documentation/mergetools-merge.txt
>   Removing GIT-VERSION-FILE
>   GIT_VERSION =3D 2.11.0.460.g218feb5a0e89
>   make -C Documentation all
>   make[1]: Entering directory '/home/sunny/src/git/src-other/devel/git/gi=
t/Documentation'
>       GEN mergetools-list.made
>       GEN cmd-list.made
>       GEN doc.dep
>   make[2]: Entering directory '/home/sunny/src/git/src-other/devel/git/gi=
t'
>   make[2]: 'GIT-VERSION-FILE' is up to date.
>   make[2]: Leaving directory '/home/sunny/src/git/src-other/devel/git/git'
>   make[2]: Entering directory '/home/sunny/src/git/src-other/devel/git/gi=
t'
>   make[2]: 'GIT-VERSION-FILE' is up to date.
>   make[2]: Leaving directory '/home/sunny/src/git/src-other/devel/git/git'
>       ASCIIDOC git-init-db.html
>   Couldn't find a view in @views for document
>     Use --trace for backtrace
>   Makefile:330: recipe for target 'git-init-db.html' failed
>   make[1]: *** [git-init-db.html] Error 1
>   make[1]: Leaving directory '/home/sunny/src/git/src-other/devel/git/git=
/Documentation'
>   Makefile:2091: recipe for target 'doc' failed
>   make: *** [doc] Error 2
>   2017-01-23 03:50:05 sunny@sunbase:~/src/git/src-other/devel/git/git (tp=
-bmc-asciidoctor)
>=20
>   $ lsb_release -d
>   Description:    Debian GNU/Linux 8.7 (jessie)
>=20
>   $ asciidoctor --version
>   Asciidoctor 0.1.4 [http://asciidoctor.org]
>=20
> I installed Asciidoctor with a standard "apt-get install asciidoctor",=20
> do I need to install more packages?
>=20
> The build is broken by patch #7 ("Makefile: add a knob to enable the use=
=20
> of Asciidoctor"), the other commits seems to work, though I haven't=20
> tested them all individually yet. Standard "make doc" works.

I think you need a newer version of Asciidoctor.  I fixed one or two
issues upstream in 1.5.2, I think, that made it work properly.

You could try to do the build with the "html5" target instead of
"xhtml5" and see if that works.  If so, we could switch to that instead
if we want to support older Asciidoctor versions.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--du33dhs3k5wonoiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliFge0ACgkQv1NdgR9S
9ovjcw//RSfvqDd+pQ5j10jHuB/qC2yptTpQWUvJ3xVzefg0Cos70n+GFFFTxFxW
govxXyEwucoF75+8BPvszCQVZ8anZn0QDZPM0Bo/xnB0ilQvIaASaWXQF303etCv
uUPN/JKgrZenK0QXoE4ntuyKkgvYjtqQP30uGpM5XmsYyv5jyW7zHQg00yIV8sT9
uGcMVX63j7HuIgkSy9qHySBluFVEo62nJ/Pvt8PHZfazjF+5956ozFr9l9cJL18u
kZ1pHfobplIIC4eZ+IzZF0XGfUouKxQPHqx8yZTaenTvvv1PrcA/2szN5VjlgKuM
9mxInyU6414xMFVrBNLpA2HfSWQCT5WNDqLth8XeJ7MMVs1cG8Qtd2yoTKfraDHq
FHaEiVXYR1GmxQdyz0RCK6+YFklSPs/uzsAahXmw6SVDC34EWrgoxGBZ/GT2vWVK
5GP1E4PteY0Xt82fHGu3Z8wywGfZ+9mmSGL56eU+CAECDG4Se8+7e8JTyB1b/B6U
wt7ij4ei+cBZQ553Y2z4ThlY/g/kA44bTMFcRJ7xRF1CnNGn3IycTKXC2qd43Ssr
xct+eebrJxQ+p6dRl9UoFzXv+d1b1CBx7rJ7WFWxLD0Tq/FR/8p5AoGGVsERhFP3
ZP3QqiEKNJb4QXHOgsoz7qu9Yow+ssjJeSosd8TJ5SKSv2dMIno=
=mblk
-----END PGP SIGNATURE-----

--du33dhs3k5wonoiq--
