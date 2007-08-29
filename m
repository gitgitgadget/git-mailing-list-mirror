From: martin f krafft <madduck@madduck.net>
Subject: double occurrence of filenames on command lines
Date: Wed, 29 Aug 2007 10:11:22 +0200
Message-ID: <20070829081122.GA604@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Cc: 439992-quiet@bugs.debian.org
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 10:34:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQJ0h-0006tD-Mw
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 10:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbXH2Ief (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 04:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbXH2Iee
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 04:34:34 -0400
Received: from clegg.madduck.net ([82.197.162.59]:42343 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbXH2Ied (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 04:34:33 -0400
X-Greylist: delayed 1382 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Aug 2007 04:34:33 EDT
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 7510BBF73;
	Wed, 29 Aug 2007 10:11:23 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 064539F161;
	Wed, 29 Aug 2007 10:11:22 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id BF64943F4; Wed, 29 Aug 2007 10:11:22 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4099/Wed Aug 29 05:14:54 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56910>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

While I can say something like

  git add foo bar foo
  (note the doubled foo)

when using git-add from a script, the following fails:

  $ git commit -m. foo foo
  error: pathspec 'foo' did not match any file(s) known to git.
  Did you forget to 'git add'?

I am bringing this up in the context of
http://bugs.debian.org/439992, where debcommit.pl would duplicate
a file argument under certain conditions. It's since been fixed, but
I wonder whether git-commit could be made more robust in the
presence of duplicate arguments? Or is this behaviour by choice?

PS: please keep 439992-quiet@bugs.debian.org on Cc.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
an egg has the shortest sex-life of all: if gets laid once; it gets
eaten once. it also has to come in a box with 11 others, and the
only person who will sit on its face is its mother.
=20
spamtraps: madduck.bogus@madduck.net

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG1SoqIgvIgzMMSnURAqfEAKDieu28n3kAmdLV7atWz/CD+DQhcgCgtI3d
sDfiKypuZxTEpRIxqfDdiKA=
=/wMt
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
