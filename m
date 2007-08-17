From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] clarify need for init in git-submodules documentation
Date: Fri, 17 Aug 2007 12:08:15 +0200
Message-ID: <20070817100815.GC28477@piper.oerlikon.madduck.net>
References: <200708161553.10991.Josef.Weidendorfer@gmx.de> <11872878021267-git-send-email-madduck@madduck.net> <20070817093116.GH1070MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Fri Aug 17 12:08:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILyl3-0005DJ-D9
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 12:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbXHQKIU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 06:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754255AbXHQKIU
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 06:08:20 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:55156 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbXHQKIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 06:08:19 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 761C0895F78;
	Fri, 17 Aug 2007 12:08:17 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 10370-01; Fri, 17 Aug 2007 12:08:17 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id F230B895F51;
	Fri, 17 Aug 2007 12:08:16 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 10D989F171;
	Fri, 17 Aug 2007 12:08:16 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id D468F43F9; Fri, 17 Aug 2007 12:08:15 +0200 (CEST)
Mail-Followup-To: skimo@liacs.nl, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070817093116.GH1070MdfPADPa@greensroom.kotnet.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56057>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sven Verdoolaege <skimo@kotnet.org> [2007.08.17.1131 +0200]:
> This is not true.  The url (which is local information) is taken from .gi=
t/config,
> the name/path relation (which is shared information) is taken from .gitmo=
dules.

If you approve of this change, I shall prepare a new patch:

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.=
txt
index b1a4f95..2f69047 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -71,8 +71,9 @@ to each submodule url is "submodule.$name.url".
=20
 The file .gitmodules serves default configuration data to users who cloned=
 the
 repository. In order to work with submodules, these data need to be copied=
 to
-$GIT_DIR/config with `git-submodule init`. Only the data in $GIT_DIR/config
-are used for `git-submodule update`.
+$GIT_DIR/config with `git-submodule init`. Only the URL in $GIT_DIR/config
+is used for `git-submodule update`, as it is local information. The name/p=
ath
+relation is taken from the .gitmodules file, as it is shared data.
=20
=20
 AUTHOR

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
in africa some of the native tribes have a custom of beating the
ground with clubs and uttering spine chilling cries. anthropologists
call this a form of primitive self-expression. in america they call
it golf.
=20
spamtraps: madduck.bogus@madduck.net

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGxXOPIgvIgzMMSnURAmNiAJ9HrXK1Ra5p0UbQShF0ZNbmtXodiwCg0uyg
1JVirySTx5uwVzBsh0jxd7Y=
=Yycq
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
