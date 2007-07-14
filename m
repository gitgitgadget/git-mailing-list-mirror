From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH 2/2] Wire new date formats to --date=<format> parser.
Date: Sat, 14 Jul 2007 08:44:51 +0200
Message-ID: <20070714064451.GH11809@lug-owl.de>
References: <7vy7hklzsf.fsf@assigned-by-dhcp.cox.net> <20070713225836.17922.32546.stgit@lathund.dewire.com> <7vodiflc3v.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RkLO0ZVuuT1d19pw"
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 08:44:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9bNA-0003bG-6Q
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 08:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbXGNGoy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 02:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbXGNGox
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 02:44:53 -0400
Received: from lug-owl.de ([195.71.106.12]:53630 "EHLO lug-owl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874AbXGNGox (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 02:44:53 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 06497F0074; Sat, 14 Jul 2007 08:44:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vodiflc3v.fsf_-_@assigned-by-dhcp.cox.net>
X-Operating-System: Linux mail 2.6.18-4-686 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52446>


--RkLO0ZVuuT1d19pw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-07-13 23:43:00 -0700, Junio C Hamano <gitster@pobox.com> wrote:
> --- a/revision.c
> +++ b/revision.c
> @@ -1133,6 +1133,14 @@ int setup_revisions(int argc, const char **argv, s=
truct rev_info *revs, const ch
>  			if (!strncmp(arg, "--date=3D", 7)) {
>  				if (!strcmp(arg + 7, "relative"))
>  					revs->date_mode =3D DATE_RELATIVE;
> +				else if (!strcmp(arg + 7, "iso8601") ||
> +					 !strcmp(arg + 7, "iso"))
> +					revs->date_mode =3D DATE_ISO8601;
> +				else if (!strcmp(arg + 7, "rfc2822") ||
> +					 !strcmp(arg + 7, "rfc"))

Maybe also add "rfc822"?

> +					revs->date_mode =3D DATE_RFC2822;
> +				else if (!strcmp(arg + 7, "short"))
> +					revs->date_mode =3D DATE_SHORT;
>  				else if (!strcmp(arg + 7, "local"))
>  					revs->date_mode =3D DATE_LOCAL;
>  				else if (!strcmp(arg + 7, "default"))

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:            http://www.chiark.greenend.org.uk/~sgtatham/bugs.h=
tml
the second  :

--RkLO0ZVuuT1d19pw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmHDjHb1edYOZ4bsRAuuNAJ9jIyYdewsK7AkMXIF+bGRNCnK4ggCfa+i7
w2JEpEp8xZdIthI3ChDg9cI=
=zpJi
-----END PGP SIGNATURE-----

--RkLO0ZVuuT1d19pw--
