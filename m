From: "Artur R. Czechowski" <arturcz@hell.pl>
Subject: Cannot clone the git repository shared over http with authorization.
Date: Sun, 1 Apr 2012 20:48:04 +0200
Organization: none
Message-ID: <20120401184804.GJ3236@szczaw.snafu.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V3ENGWVrnMOBWwz8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 01 20:57:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEPxt-00075C-7Q
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 20:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898Ab2DAS5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Apr 2012 14:57:20 -0400
Received: from blabluga.hell.pl ([83.143.164.164]:41824 "EHLO blabluga.hell.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598Ab2DAS5T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2012 14:57:19 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Apr 2012 14:57:19 EDT
Received: from szczaw.czesiu.lan ([192.168.109.13])
	by blabluga.hell.pl with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <arturcz@hell.pl>)
	id 1SEPor-0005DC-HP
	for git@vger.kernel.org; Sun, 01 Apr 2012 20:48:05 +0200
Received: from arturcz by szczaw.czesiu.lan with local (Exim 4.77)
	(envelope-from <arturcz@hell.pl>)
	id 1SEPoq-00055Z-W7
	for git@vger.kernel.org; Sun, 01 Apr 2012 20:48:05 +0200
Content-Disposition: inline
X-Operating-System: Linux szczaw 3.2.0-2-amd64
X-URL: http://hell.pl/arturcz/
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194481>


--V3ENGWVrnMOBWwz8
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

arturcz@szczaw:/tmp$ git clone http://blabluga.hell.pl/git/test.git
Cloning into 'test'...
Debug: Remote helper: -> capabilities
Debug: Remote helper: Waiting...
Debug: Remote helper: <- fetch
Debug: Got cap fetch
Debug: Remote helper: Waiting...
Debug: Remote helper: <- option
Debug: Got cap option
Debug: Remote helper: Waiting...
Debug: Remote helper: <- push
Debug: Got cap push
Debug: Remote helper: Waiting...
Debug: Remote helper: <-=20
Debug: Capabilities complete.
Debug: Remote helper: Waiting...
Username for 'http://blabluga.hell.pl': test
Password for 'http://test@blabluga.hell.pl':=20
Debug: Remote helper: <- @refs/heads/master HEAD
Debug: Remote helper: Waiting...
Debug: Remote helper: <- c64bcf957545f61436d405326d985521dc45058f refs/head=
s/master
Debug: Remote helper: Waiting...
Debug: Remote helper: <-=20
Debug: Read ref listing.
Debug: Remote helper: -> option progress true
Debug: Remote helper: Waiting...
Debug: Remote helper: <- ok
Debug: Remote helper: -> option verbosity 1
Debug: Remote helper: Waiting...
Debug: Remote helper: <- ok
Debug: Remote helper: -> fetch c64bcf957545f61436d405326d985521dc45058f HEAD
fetch c64bcf957545f61436d405326d985521dc45058f refs/heads/master

Debug: Remote helper: Waiting...
error: The requested URL returned error: 401 (curl_result =3D 22, http_code=
 =3D 401, sha1 =3D e884293079beab9f2583b59b4e05479fc84fc588)
error: Unable to find e884293079beab9f2583b59b4e05479fc84fc588 under http:/=
/blabluga.hell.pl/git/test.git
Cannot obtain needed commit e884293079beab9f2583b59b4e05479fc84fc588
while processing commit c64bcf957545f61436d405326d985521dc45058f.
error: Fetch failed.

The apache log from the action:

192.168.109.13 - - [01/Apr/2012:20:33:42 +0200] "GET /git/test.git/info/ref=
s?service=3Dgit-upload-pack HTTP/1.1" 401 694 "-" "git/1.7.9.1"
192.168.109.13 - - [01/Apr/2012:20:33:50 +0200] "GET /git/test.git/info/ref=
s?service=3Dgit-upload-pack HTTP/1.1" 401 694 "-" "git/1.7.9.1"
192.168.109.13 - test [01/Apr/2012:20:33:50 +0200] "GET /git/test.git/info/=
refs?service=3Dgit-upload-pack HTTP/1.1" 200 294 "-" "git/1.7.9.1"
192.168.109.13 - test [01/Apr/2012:20:33:50 +0200] "GET /git/test.git/HEAD =
HTTP/1.1" 200 257 "-" "git/1.7.9.1"
192.168.109.13 - test [01/Apr/2012:20:33:50 +0200] "GET /git/test.git/objec=
ts/c6/4bcf957545f61436d405326d985521dc45058f HTTP/1.1" 200 403 "-" "git/1.7=
=2E9.1"
192.168.109.13 - test [01/Apr/2012:20:33:50 +0200] "GET /git/test.git/objec=
ts/b8/ab890a5432053f85d74a3b4ff798011260e222 HTTP/1.1" 200 288 "-" "git/1.7=
=2E9.1"
192.168.109.13 - - [01/Apr/2012:20:33:50 +0200] "GET /git/test.git/objects/=
fe/0e1075a026f19269bd958b05f586e252af7635 HTTP/1.1" 401 694 "-" "git/1.7.9.=
1"
192.168.109.13 - - [01/Apr/2012:20:33:50 +0200] "GET /git/test.git/objects/=
e8/84293079beab9f2583b59b4e05479fc84fc588 HTTP/1.1" 401 694 "-" "git/1.7.9.=
1"
192.168.109.13 - - [01/Apr/2012:20:33:50 +0200] "GET /git/test.git/objects/=
info/packs HTTP/1.1" 401 694 "-" "git/1.7.9.1"
192.168.109.13 - - [01/Apr/2012:20:33:50 +0200] "GET /git/test.git/objects/=
info/http-alternates HTTP/1.1" 401 694 "-" "git/1.7.9.1"
192.168.109.13 - - [01/Apr/2012:20:33:50 +0200] "GET /git/test.git/objects/=
info/alternates HTTP/1.1" 401 694 "-" "git/1.7.9.1"

On the client side I'm using 1.7.9.1 from Debian package. Repository is
shared from apache using a DAV on directive (a person from #git channel
told me it's called a dumb http).

It's worth to say, that I've already asked for support on #git channel
and the problem exists with git/1.7.9.5 and git/1.7.10.rc3.3.g19a6c (at
least those versions can be seen in my access.log).

If necessary I can arrange an access to the repository.

Regards
        Artur
--=20
(ac) ,<                                            =20
    _=F3_____     We all live in a yellow submarine... =20
   <_______>                                            =20

--V3ENGWVrnMOBWwz8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk94ouQACgkQlk0AXAynaGxxtgCcDhEnU7EmX7K/8CDVbDWkX6Te
JvYAnR7gyXkKBMKOGxjarA14xqnYVOII
=MC2y
-----END PGP SIGNATURE-----

--V3ENGWVrnMOBWwz8--
