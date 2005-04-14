From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [PATCH] Git pasky include commit-id in Makefile
Date: Fri, 15 Apr 2005 00:37:25 +0200
Message-ID: <1113518245.23299.107.camel@nosferatu.lan>
References: <20050414141022.GE10385@cse.unsw.EDU.AU>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8bIcm2B4JO23k+x7g2yy"
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:31:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMCrP-0000Dl-JM
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVDNWeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVDNWeO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:34:14 -0400
Received: from ctb-mesg3.saix.net ([196.25.240.75]:36782 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S261601AbVDNWds
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 18:33:48 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg3.saix.net (Postfix) with ESMTP id E545324B4;
	Fri, 15 Apr 2005 00:33:38 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id C937E3A26DB;
	Fri, 15 Apr 2005 00:39:43 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26226-17; Fri, 15 Apr 2005 00:39:38 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 8C94F3A26DA;
	Fri, 15 Apr 2005 00:39:38 +0200 (SAST)
To: Darren Williams <dsw@gelato.unsw.edu.au>
In-Reply-To: <20050414141022.GE10385@cse.unsw.EDU.AU>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-8bIcm2B4JO23k+x7g2yy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-15 at 00:10 +1000, Darren Williams wrote:
> Currently the commit-id script is not install with
> make install, this patches includes it in the SCRIPT
> target. This patch is against git-pasky-0.4
>=20

Hmm, this is still not fixed ...

> Signed-off-by Darren Williams <dsw@gelato.unsw.edu.au>
>=20
> COPYING:  fe2a4177a760fd110e78788734f167bd633be8de
> Makefile:  ca50293c4f211452d999b81f122e99babb9f2987
> --- Makefile
> +++ Makefile    2005-04-14 23:52:35.701915203 +1000
> @@ -19,7 +19,7 @@
>  SCRIPT=3D        parent-id tree-id git gitXnormid.sh gitadd.sh gita=
ddremote.sh \
>         gitcommit.sh gitdiff-do gitdiff.sh gitlog.sh gitls.sh gitlso=
bj.sh \
>         gitmerge.sh gitpull.sh gitrm.sh gittag.sh gittrack.sh gitexp=
ort.sh \
> -       gitapply.sh gitcancel.sh gitlntree.sh
> +       gitapply.sh gitcancel.sh gitlntree.sh commit-id
>=20
>  GEN_SCRIPT=3D gitversion.sh
>=20
> README:  ded1a3b20e9bbe1f40e487ba5f9361719a1b6b85
> VERSION:  c27bd67cd632cc15dd520fbfbf807d482efa2dcf
> cache.h:  4d382549041d3281f8d44aa2e52f9f8ec47dd420
> cat-file.c:  45be1badaa8517d4e3a69e0bf1cac2e90191e475
> check-files.c:  927b0b9aca742183fc8e7ccd73d73d8d5427e98f
> checkout-cache.c:  f06871cdbc1b18ea93bdf4e17126aeb4cca1373e
> commit-id:  65c81756c8f10d513d073ecbd741a3244663c4c9
> commit-tree.c:  12196c79f31d004dff0df1f50dda67d8204f5568
> diff-tree.c:  7dcc9eb7782fa176e27f1677b161ce78ac1d2070
> fsck-cache.c:  9c900fe458cecd2bdb4c4571a584115b5cf24f22
> git:  2c557dcf2032325acc265b577ee104e605fdaede
> gitXnormid.sh:  a5d7a9f4a6e8d4860f35f69500965c2a493d80de
> gitadd.sh:  3ed93ea0fcb995673ba9ee1982e0e7abdbe35982
> gitaddremote.sh:  bf1f28823da5b5270aa8fa05b321faa514a57a11
> gitapply.sh:  d0e3c46e2ce1ee74e1a87ee6137955fa9b35c27b
> gitcancel.sh:  ec58f7444a42cd3cbaae919fc68c70a3866420c0
> gitcommit.sh:  3629f67bbd3f171d091552814908b67af7537f4d
> gitdiff-do:  d6174abceab34d22010c36a8453a6c3f3f184fe0
> gitdiff.sh:  5e47c4779d73c3f2f39f6be714c0145175933197
> gitexport.sh:  dad00bf251b38ce522c593ea9631f842d8ccc934
> gitlntree.sh:  17c4966ea64aeced96ae4f1b00f3775c1904b0f1
> gitlog.sh:  177c6d12dd9fa4b4920b08451ffe4badde544a39
> gitls.sh:  b6f15d82f16c1e9982c5031f3be22eb5430273af
> gitlsobj.sh:  128461d3de6a42cfaaa989fc6401bebdfa885b3f
> gitmerge.sh:  23e4a3ff342c6005928ceea598a2f52de6fb9817
> gitpull.sh:  0883898dda579e3fa44944b7b1d909257f6dc63e
> gitrm.sh:  5c18c38a890c9fd9ad2b866ee7b529539d2f3f8f
> gittag.sh:  c8cb31385d5a9622e95a4e0b2d6a4198038a659c
> gittrack.sh:  03d6db1fb3a70605ef249c632c04e542457f0808
> init-db.c:  aa00fbb1b95624f6c30090a17354c9c08a6ac596
> ls-tree.c:  3e2a6c7d183a42e41f1073dfec6794e8f8a5e75c
> parent-id:  1801c6fe426592832e7250f8b760fb9d2e65220f
> read-cache.c:  7a6ae8b9b489f6b67c82e065dedd5716a6bfc0ef
> read-tree.c:  eb548148aa6d212f05c2c622ffbe62a06cd072f9
> rev-tree.c:  395b0b3bfadb0537ae0c62744b25ead4b487f3f6
> show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
> show-files.c:  a9fa6767a418f870a34b39379f417bf37b17ee18
> tree-id:  cb70e2c508a18107abe305633612ed702aa3ee4f
> update-cache.c:  62d0a6c41560d40863c44599355af10d9e089312
> write-tree.c:  1534477c91169ebddcf953e3f4d2872495477f6b
> =20
> ---------------------------------------------------
> Darren Williams <dsw AT gelato.unsw.edu.au>
> Gelato@UNSW <www.gelato.unsw.edu.au>
> --------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
Martin Schlemmer


--=-8bIcm2B4JO23k+x7g2yy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXvCkqburzKaJYLYRAt9yAJ90y4Eivx4IPMC77QQMOm/+BjB2xgCggoiq
3OXIprNGrTuvH4OTpO+fHb4=
=Q/Qr
-----END PGP SIGNATURE-----

--=-8bIcm2B4JO23k+x7g2yy--

