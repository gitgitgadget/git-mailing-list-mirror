From: Pierre Habouzit <madcoder@debian.org>
Subject: [RFC] best way to show diff of commit
Date: Sun, 25 Nov 2007 22:18:31 +0100
Message-ID: <20071125211831.GA21121@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="6TrnltStXW4iwmi0";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 25 22:18:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOsQ-0004JM-Vi
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 22:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbXKYVSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 16:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752941AbXKYVSf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 16:18:35 -0500
Received: from pan.madism.org ([88.191.52.104]:59036 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971AbXKYVSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 16:18:34 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0C56C2C3B1
	for <git@vger.kernel.org>; Sun, 25 Nov 2007 22:18:32 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id A20B6E27; Sun, 25 Nov 2007 22:18:31 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66005>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Hi there,

  There is specific script I run in my vim with git, that tries to show
=66rom the 'status' git commit shows in the buffer which list of files has
changed, and builds a diff from it quite clumsily[0].

  I wonder how hard it would be for git commit to "stash" the current
commit being sent somewhere editors would be able to have a look at (an
alternate index is probably fine). Note that maybe I'm stupid and
overlooked that such a thing already exists.  I'd like to have it in two
flavors: normal and amend mode. normal mode would show what the
resulting commit diff looks like, and the amend mode only shows the
incrementall diff the amend adds to the previous commit.

  My question is: what do you think is the best way to do that, and
where ?



  [0] the issue with this approach is that it's completely broken in
      amending mode (does not shows the proper thing), and the generated
      diffs aren't excellent, because as an editor plugin, it's hard to
      treat renames and copies easily, so I generate really really nasty
      diffs in that case too.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHSeanvGr7W6HudhwRAtTaAJ9NWEka6mE2ZQ0ocAlGH1AFL4JIAACeJl1U
TCxIklKYR1KqUWmLlMAxKF8=
=SFQy
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
