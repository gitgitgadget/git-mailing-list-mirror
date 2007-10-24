From: martin f krafft <madduck@madduck.net>
Subject: git-remote: Use of uninitialized value in string ne, line 248
Date: Wed, 24 Oct 2007 13:08:07 +0200
Message-ID: <20071024110807.GA12501@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 13:08:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ike64-0007Vg-Vr
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 13:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbXJXLIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 07:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbXJXLIN
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 07:08:13 -0400
Received: from clegg.madduck.net ([82.197.162.59]:37633 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbXJXLIM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 07:08:12 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 6030BA808F
	for <git@vger.kernel.org>; Wed, 24 Oct 2007 13:08:48 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 4A9739F13B
	for <git@vger.kernel.org>; Wed, 24 Oct 2007 13:08:07 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 27B644408; Wed, 24 Oct 2007 13:08:07 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4589/Wed Oct 24 11:55:55 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62208>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am useless at Perl, otherwise I'd fix this, but I don't know
what's going on, so best I can do is report it. This is against
current tip of master.

piper:~> git remote show origin
* remote origin
  URL: ssh://git.madduck.net/~/git/etc/mailplate.git
Use of uninitialized value in string ne at /usr/local/stow/git/bin/git-remo=
te line 248.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^
  Tracked remote branches
    master
piper:~> git branch
* master

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"... and so he killed Miguel in a rit of fealous jage."
                                               -- inspector clouseau
=20
spamtraps: madduck.bogus@madduck.net

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHyeXIgvIgzMMSnURAuMqAJ0XZ2jrMMF3n1GhbMzMLbsxQTpgVgCeIv0s
exsBcoQ+kG4g0O/REfSxELg=
=lTAg
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
