From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Start conforming code to "git subcmd" style part 3
Date: Sat, 13 Sep 2008 19:08:31 +0200
Message-ID: <200809131908.34145.trast@student.ethz.ch>
References: <20080913163058.GA5108@zakalwe.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4963059.kGAzGPFYDP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Andreas Ericsson <ae@op5.se>
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Sat Sep 13 19:09:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeYcz-0007Ms-Td
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 19:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbYIMRIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 13:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbYIMRIj
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 13:08:39 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:47954 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbYIMRIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 13:08:38 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 19:08:36 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 19:08:37 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080913163058.GA5108@zakalwe.fi>
X-OriginalArrivalTime: 13 Sep 2008 17:08:37.0524 (UTC) FILETIME=[5CB98D40:01C915C3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95810>

--nextPart4963059.kGAzGPFYDP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Heikki Orsila wrote:
> diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
> index cb7007e..edcf72a 100644
> --- a/builtin-tar-tree.c
> +++ b/builtin-tar-tree.c
> @@ -9,19 +9,19 @@
> =20
>  static const char tar_tree_usage[] =3D
>  "git tar-tree [--remote=3D<repo>] <tree-ish> [basedir]\n"
> -"*** Note that this command is now deprecated; use git-archive instead.";
> +"*** Note that this command is now deprecated; use \"git archive\" inste=
ad.";
> =20
>  int cmd_tar_tree(int argc, const char **argv, const char *prefix)
>  {
>  	/*
> -	 * git-tar-tree is now a wrapper around git-archive --format=3Dtar
> +	 * "git tar-tree" is now a wrapper around "git archive" --format=3Dtar
>  	 *
>  	 * $0 --remote=3D<repo> arg... =3D=3D>

I think the quotes should go one further to the right:
+	 * "git tar-tree" is now a wrapper around "git archive --format=3Dtar"

The rest looks fine.

=2D Thomas


--nextPart4963059.kGAzGPFYDP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjL85IACgkQqUud07tmzP2sogCfREbdq/0hNAmHTGcZXg6J9XFN
WTEAn2e4YJTajSrXRN/pmSxVQbmUr4Vd
=Efhp
-----END PGP SIGNATURE-----

--nextPart4963059.kGAzGPFYDP--
