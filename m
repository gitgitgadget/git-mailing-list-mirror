From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-opt: migrate builtin-ls-files.
Date: Tue, 06 Jan 2009 11:22:02 +0100
Message-ID: <20090106102202.GA30766@artemis.corp>
References: <1231200669-30684-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OgqxwSJOaUobr8KG";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 11:23:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK95u-0008Ew-O6
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 11:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbZAFKWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 05:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbZAFKWJ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 05:22:09 -0500
Received: from pan.madism.org ([88.191.52.104]:37583 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbZAFKWI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 05:22:08 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9FD2E32118;
	Tue,  6 Jan 2009 11:22:04 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 1C7152A294; Tue,  6 Jan 2009 11:22:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1231200669-30684-1-git-send-email-vmiklos@frugalware.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104675>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2009 at 12:11:09AM +0000, Miklos Vajna wrote:

> +static int option_parse_no_empty(const struct option *opt,
> +				 const char *arg, int unset)
> +{
> +	struct dir_struct *dir =3D opt->value;
> +
> +	dir->hide_empty_directories =3D 1;
> +
> +	return 0;
> +}

Should be option_parse_empty and deal with "unset" to know if `no-` was
prefixed to it or not.


> +		{ OPTION_CALLBACK, 0, "no-empty-directory", &dir, NULL,
> +			"do not list empty directories",

This should be "empty-directory" and "list empty directories as well"


I've not checked if you could also check more of the "unsets" things in
your callbacks as well btw, but it looks like it could.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkljMMcACgkQvGr7W6Hudhw2HACgnwvSKBL0a46S89Xnb9ziUk+d
7sYAoJovNYGQLfmYroNrqu8PCtz2OHQx
=Dcu9
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
