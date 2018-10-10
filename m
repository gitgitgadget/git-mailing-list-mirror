Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA761F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 14:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJJV5F (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 17:57:05 -0400
Received: from kitenet.net ([66.228.36.95]:33208 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJJV5F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 17:57:05 -0400
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1539182067; bh=Yp+j1ua0MqmYJHYlcgJjibGHM2r0OnMQIoL13Cig+lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yx3hBQoIzmOFGeoZtLpo3HWTust7xsL1LxOetOLvJzyTBol3+3DI14El0alkT74zA
         /yGO9jq7Ft5j6JzAp2SqHqJlgSezG27lIGzRV58ztFDLEy5U4gg19Du2icch45bdBA
         lYXt67haklE6xfV7hxzhPWWULGTZ4TYKKzzCAQu8=
Date:   Wed, 10 Oct 2018 10:34:27 -0400
From:   Joey Hess <id@joeyh.name>
To:     Naja Melan <najamelan@autistici.org>
Cc:     git@vger.kernel.org
Subject: Re: bug when combined with etckeeper
Message-ID: <20181010143427.GA2725@kitenet.net>
References: <4d7cddf8-34b3-eaa4-dc9e-e190062e6135@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <4d7cddf8-34b3-eaa4-dc9e-e190062e6135@autistici.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

/etc/.git/hooks/pre-commit is installed by etckeeper and runs
etckeeper pre-commit, which deals with /etc/.etckeeper, including
running "git add .etckeeper". Why that file would match a gitignore
seems much less important than why git would run that hook in an
entirely different git repository.

       core.hooksPath
           By default Git will look for your hooks in the $GIT_DIR/hooks
           directory. Set this to different path, e.g.  /etc/git/hooks, and=
 Git
           will try to find your hooks in that directory, e.g.
           /etc/git/hooks/pre-receive instead of in $GIT_DIR/hooks/pre-rece=
ive.

Hmm, the example "/etc/git/hooks" there is very similar to the
"/etc/.git/hooks" used by etckeeper. So my guess is you have
core.hooksPath set globally.

--=20
see shy jo

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAlu+DfMACgkQ2xLbD/Bf
jzhdFQ//S2aL7ixRMNoIM4uCyQgDr4vxsZKYGebrJDt6feY4hEvgCRfy2tV8uzFS
f/e656Nol7OKXxnUV29vqEU9DPjrqeGel8v2UE/Uhpbed67fly4mJdumRy5hpluV
8KwdxgKglMWPSrAeKVoEbq98cW5Hu+Not+Fmwcr2crzvlT/kN0hXEDaH6axclMSy
PY2bSWXtu52S8xaL1Nsec4UXgTV3BoYPMEZS3fE46OHVLa7wQM1WPUylMGc94/Wp
2brrU9N3VBSroc0USyfFbTPvb2H9Qr0iBkfaS0wvXmYn+X6PfWSJn9U6ovsxdbvY
zKKkqPJHKV9xsXMol1+y6jG+WLOpAUWi9CY+Gzj97jHmy6eojhWHSwWZnco1wBNi
+lxBnGuamz1y8vNvdGAvesfg0ZiuHqNK3JKYnjEcU0KTVFVI6IbykrDHJj5BW2zl
y68m/uf7FS4Z6+92u8Rg4Ivmfi0l9CqTUc6ziB9pWH/YLc7vcfIm7lIBhP+ysDrD
w+su+nNNhHICvIGf50KoYob9G0SSQsSAnAhdeFVMLDMHkl1zlQgVY9I86xk8RBud
5uHbc5R1mrvTXYh4vXUIOBIB0y844yCL9ezN/R1dSYEP8bClNK3S9c+B4Pezu4OE
zbNtqm/5+PZHb8Ooz+T1etW9AafP3/Ngq1f2fTQDAOJb4I88HOo=
=s3Hh
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
