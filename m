From: Jacob Helwig <jacob@technosorcery.net>
Subject: Re: [PATCH/RFC] remote: support --all for the prune-subcommand
Date: Mon, 3 Oct 2011 11:13:29 -0700
Message-ID: <20111003181329.GA4368@vfa-6h>
References: <1317644168-5808-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 20:13:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAn1I-0005hk-Ej
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 20:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350Ab1JCSNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 14:13:36 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40135 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305Ab1JCSNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 14:13:35 -0400
Received: by qadb15 with SMTP id b15so1776130qad.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 11:13:34 -0700 (PDT)
Received: by 10.68.71.193 with SMTP id x1mr2658544pbu.132.1317665614329;
        Mon, 03 Oct 2011 11:13:34 -0700 (PDT)
Received: from vfa-6h ([199.223.125.134])
        by mx.google.com with ESMTPS id e7sm28304513pbq.1.2011.10.03.11.13.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 11:13:33 -0700 (PDT)
Received: by vfa-6h (Postfix, from userid 1000)
	id 62AA56406CD; Mon,  3 Oct 2011 11:13:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317644168-5808-1-git-send-email-kusmabite@gmail.com>
X-PGP-Key: http://technosorcery.net/pubkey.asc
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182681>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 03 Oct 2011 14:16:08 +0200, Erik Faye-Lund wrote:
>=20
> While we're at it, wrap a long line to fit on a 80 char terminal.
>=20
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>=20
> I recently needed to prune remote branches in a repo with a lot
> of remotes, and to my surprise "git remote prune" didn't support
> the --all option. So I added it. Perhaps this is useful for other
> people as well?
>=20

Can't really comment on the implementation (especially since I didn't
actually look at it), but having "git remote prune --all" work would be
_tremendously_ helpful to me.  Thanks for doing this!

--=20
Jacob Helwig
http://about.me/jhelwig

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQGcBAEBAgAGBQJOiftEAAoJELcuR9l9xz+I3LoL/0kPl0voYqNa5S43vfDHHxD2
/u27ueEXS7R4x+L5Ra+95fFvdTkGasCdFS6NjnYvkVgRdaoIqZS7V+GIRezx3GUR
qkwPLkraaU/VOBqOQso9rPYALpNsoOjQXxo4A40XNjHTwpCOr5YdSaA+F2zlhem3
WNDIHA3/BA7kaZRzqWVr3cqv2RkAZWHOTL77lCBfZD/aA0HC8QenmmI642QCNvSE
gnuC1FHJlxrFqqvYcUbQMSXEi/XUdjE2g4gjrJkvAUi0PQeGsRBt3AqJm9xBOi+u
bfqtiZSYKg58m3otnPx26Xx/Yo7whGWgsK5zbQ1pIbZ12TpOsYkPqmoxf3cRcQki
bqnfs0Ex8TxHtBahEl0rg1Lic/n2Wuhxd4b8nG43fWttOxHkkiHNoUWQK1bWYsTb
2oFVe/kXW+3+pkYtSIxUM0T19Sf4nMEIpsoNEPf3W9KS8JcjQCSwA9Epl3mgF5NW
YR8i6HkVUTRbvr+dsoztYGzSg+5KlL8NZ+Pc0wiKNA==
=mLwG
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
