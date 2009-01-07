From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH v2] parse-opt: migrate builtin-ls-files.
Date: Wed, 07 Jan 2009 15:46:40 +0100
Message-ID: <20090107144640.GD831@artemis.corp>
References: <20090106102202.GA30766@artemis.corp> <1231297894-31809-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="o0ZfoUVt4BxPQnbU";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 15:48:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKZhX-0006Qz-0r
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 15:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbZAGOqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 09:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbZAGOqn
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 09:46:43 -0500
Received: from pan.madism.org ([88.191.52.104]:42711 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798AbZAGOqn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 09:46:43 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 3E3DF3A5ED;
	Wed,  7 Jan 2009 15:46:42 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E57F32B1DB; Wed,  7 Jan 2009 15:46:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1231297894-31809-1-git-send-email-vmiklos@frugalware.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104800>


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2009 at 03:11:34AM +0000, Miklos Vajna wrote:

> +static int option_parse_ignored(const struct option *opt,
> +				const char *arg, int unset)
> +{
> +	struct dir_struct *dir =3D opt->value;
> +
> +	if (unset)
> +		dir->show_ignored =3D 0;
> +	else
> +		dir->show_ignored =3D 1;

dir->show_ignored =3D !unset ?

> +static int option_parse_directory(const struct option *opt,
> +				  const char *arg, int unset)
> +{

ditto

> +static int option_parse_empty(const struct option *opt,
> +				 const char *arg, int unset)
> +{

ditto


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklkwFAACgkQvGr7W6HudhzqbACfQvWzLUedeB4Cxz8DzTajK+lb
5OYAnj/8/xHPRvfVR25ETgurtC+bA6Ck
=ypMd
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
