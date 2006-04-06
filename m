From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: gitweb: A git:// link for the project?
Date: Thu, 6 Apr 2006 21:14:34 +0200
Message-ID: <20060406191434.GX13324@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vDpQvD79HZx/5O2q"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 06 21:14:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRZwR-0002BR-L7
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 21:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWDFTOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 15:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWDFTOi
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 15:14:38 -0400
Received: from lug-owl.de ([195.71.106.12]:9899 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932228AbWDFTOh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 15:14:37 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 7BB93F0069; Thu,  6 Apr 2006 21:14:34 +0200 (CEST)
To: Kay Sievers <kay.sievers@suse.de>
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18478>


--vDpQvD79HZx/5O2q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kay!

I've got another small idea for gitweb, probably only a line or two,
but Perl isn't exactly my preferred language :)

The idea is to have a 'Copy Link-Lokation'able link presented by
gitweb, maybe placed right to summary, shortlog and log.

That should just link to a URL prefix
(git://git.yourbox.tld/some/path) plus the project path. I guess it's
something like this, but I haven't tested it. Should be good enough to
get an idea of what I ment:

Signed-off-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>

diff --git a/gitweb.cgi b/gitweb.cgi
index c1bb624..b2942fd 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -26,6 +26,9 @@ my $rss_link =3D		"";
 #my $projectroot =3D	"/pub/scm";
 my $projectroot =3D	"/home/kay/public_html/pub/scm";
=20
+# URL prefix for the git:// link
+my $urlprefix =3D		"git://git.kernel.org/pub/scm";
+
 # location of the git-core binaries
 my $gitbin =3D		"/usr/bin";
=20
@@ -920,6 +923,7 @@ sub git_project_list {
 		      $cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$pr->{'path'};a=3D=
summary")}, "summary") .
 		      " | " . $cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$pr->{'pat=
h'};a=3Dshortlog")}, "shortlog") .
 		      " | " . $cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$pr->{'pat=
h'};a=3Dlog")}, "log") .
+		      " | " . $cgi->a({-href =3D> "$urlprefix" . esc_param("/$pr->{'path=
'}")}, "GIT") .
 		      "</td>\n" .
 		      "</tr>\n";
 	}


--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--vDpQvD79HZx/5O2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFENWiaHb1edYOZ4bsRAvRsAJ9MMgmZuo7zCtAU+oHwrpT679qmlQCfXKCe
2SqLxYv+vPf9i2ZJvynV94M=
=NvGS
-----END PGP SIGNATURE-----

--vDpQvD79HZx/5O2q--
