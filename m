From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 24 Dec 2012 20:11:13 -0500
Message-ID: <rmilicnlyvi.fsf@fnord.ir.bbn.com>
References: <50D861EE.6020105@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Tue Dec 25 02:11:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnJ3M-0005w6-26
	for gcvg-git-2@plane.gmane.org; Tue, 25 Dec 2012 02:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab2LYBLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 20:11:15 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:62840 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab2LYBLN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 20:11:13 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 236FEA86A; Mon, 24 Dec 2012 20:11:13 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:121225:git@vger.kernel.org::mHkY3Kug0M6OyVS4:0000000000000000000000000000000000000000003/kc
X-Hashcash: 1:20:121225:eric.chamberland@giref.ulaval.ca::mHkY3Kug0M6OyVS4:000000000000000000000000000008SLY
In-Reply-To: <50D861EE.6020105@giref.ulaval.ca> (Eric Chamberland's message of
	"Mon, 24 Dec 2012 09:08:46 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212121>

--=-=-=
Content-Type: text/plain


  we are using git since may and all is working fine for all of us
  (almost 20 people) on our workstations.  However, when we clone our
  repositories to the cluster, only and only there
  we are having many problems similiar to this post:

What filesystem tests have you run on lustre?  I would run every test
you can find, and lustre should have a robust test suite.  It's really
hard to be certain, but given how many filesystems git is used with,
your experience points to a lustre bug.

I would also suggest using ktrace/ktruss/strace and perhaps poring over
the logs to see if you can spot any bad behavior.


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEYEARECAAYFAlDY/TEACgkQ+vesoDJhHiWSOgCdGzN7JPoL5IxxOJJdYKSeRmkj
ur0An1jUjVqVUiqvsbrNBznYrD091LN/
=uRJP
-----END PGP SIGNATURE-----
--=-=-=--
