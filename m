From: "R. Tyler Ballance" <tyler@monkeypox.org>
Subject: Automating builds and testing of git.git
Date: Wed, 24 Mar 2010 18:33:53 -0700
Message-ID: <20100325013352.GE4062@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 02:34:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NubxX-0005q1-In
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 02:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab0CYBd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 21:33:59 -0400
Received: from mail.geekisp.com ([216.168.135.169]:13279 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754329Ab0CYBd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 21:33:59 -0400
Received: (qmail 4816 invoked by uid 1003); 25 Mar 2010 01:33:57 -0000
Received: from localhost (HELO kiwi.sharlinx.com) (tyler@monkeypox.org@127.0.0.1)
  by mail.geekisp.com with SMTP; 25 Mar 2010 01:33:57 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143140>


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Howdy guys, I've been working on getting automated testing of git.git going
over the past couple weekends (this is why I sent that FreeBSD related patch).

The build is currently being run for master and next:
    http://hudson.brokenco.de/job/Git/
    http://hudson.brokenco.de/job/Git__next

They're both pulling from: git://git.kernel.org/pub/scm/git/git.git
which I don't think is seeing updates that often except for occasional pushes.

Is there a more preferrable tree that I should be tracking with Hudson for
testing git.git itself?


I'm looking forward to getting tests run in a more automated fashion along
with built packages :)

Cheers,
-R. Tyler Ballance
--------------------------------------
 Jabber: rtyler@jabber.org
 GitHub: http://github.com/rtyler
Twitter: http://twitter.com/agentdero
   Blog: http://unethicalblogger.com


--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkuqvYAACgkQFCbH3D9R4W9kjwCfcgTr1m42ZbA80Rm2XV6k14Aw
7FwAn3uuBEU3PSP5wR+cq8QiC81T9OQQ
=iwpm
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
