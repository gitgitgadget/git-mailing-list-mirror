From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Sun, 04 Nov 2007 20:41:29 +0100
Message-ID: <20071104194129.GA4207@artemis.corp>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com> <11942029442710-git-send-email-shawn.bohrer@gmail.com> <11942029474058-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="VS++wcV0S1rZb1Fb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 20:41:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IolLv-0004EI-Di
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 20:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbXKDTlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 14:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753704AbXKDTlc
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 14:41:32 -0500
Received: from pan.madism.org ([88.191.52.104]:45726 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627AbXKDTlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 14:41:31 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 114312874F;
	Sun,  4 Nov 2007 20:41:29 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 31C3C3F65B; Sun,  4 Nov 2007 20:41:29 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <11942029474058-git-send-email-shawn.bohrer@gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63435>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2007 at 07:02:21PM +0000, Shawn Bohrer wrote:

> +	for (i =3D 1; i < argc; i++) {
> +		const char *arg =3D argv[i];
> +
> +		if (arg[0] !=3D '-')
> +			break;
> +		if (!strcmp(arg, "--")) {
> +			i++;
> +			break;
> +		}
> +		if (!strcmp(arg, "-n")) {
> +			show_only =3D 1;
> +			disabled =3D 0;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-f")) {
> +			disabled =3D 0;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-d")) {
> +			remove_directories =3D 1;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-q")) {
> +			quiet =3D 1;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-x")) {
> +			ignored =3D 1;
> +			continue;
> +		}
> +		if (!strcmp(arg, "-X")) {
> +			ignored_only =3D 1;
> +			dir.show_ignored =3D1;
> +			dir.exclude_per_dir =3D ".gitignore";
> +			continue;
> +		}
> +		usage(builtin_clean_usage);

  Please, parse-options.c is now in next, please use it.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLiBpvGr7W6HudhwRAm6UAJ9GG41U+zFfBbjfWDwKbXveuxwR7wCgoCLx
JhTWfOwuFneQGoYS0n/GXso=
=cHcK
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
