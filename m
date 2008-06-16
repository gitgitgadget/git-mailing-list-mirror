From: Nico -telmich- Schottelius <nico-git-svn-20080616@schottelius.org>
Subject: git-svn breaks svn when adding .svn
Date: Mon, 16 Jun 2008 14:21:17 +0200
Message-ID: <20080616122117.GA14292@denkbrett.schottelius.org>
References: <20080606122421.GA1521@denkbrett.schottelius.org> <20080606123539.GA3119@mithlond.arda.local> <20080608094754.GB1521@denkbrett.schottelius.org> <7v1w38l0el.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Cc: Frederik Dohr <F.N.Dohr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 14:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Dpt-0007Ca-86
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 14:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbYFPM2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 08:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753741AbYFPM2S
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 08:28:18 -0400
Received: from mx2.schottelius.org ([62.65.138.77]:56707 "EHLO
	mx2.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbYFPM2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 08:28:17 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jun 2008 08:28:17 EDT
Received: from denkbrett.schottelius.org (natgw.netstream.ch [62.65.128.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.schottelius.org (Postfix) with ESMTPSA id D6B3C364E52;
	Mon, 16 Jun 2008 14:21:17 +0200 (CEST)
Received: by denkbrett.schottelius.org (Postfix, from userid 1000)
	id 33CED214E5; Mon, 16 Jun 2008 14:21:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1w38l0el.fsf@gitster.siamese.dyndns.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.25.3-denkbrett on x86_64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85185>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello dear git list!

The following information was submitted to me by Frederik and is forwarded =
to
the list, because he's no mail access right now:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 - -=20
Using "git-svn dcommit", files or folders named ".svn" can be committed to =
the Subversion repository.
This breaks the SVN repo - e.g. "svn update" results in the following error:
    svn: Failed to add directory '.svn': object of the same name already ex=
ists

Ideally, the SVN server would reject such a commit.
However, if I interpret the following issues correctly, Subversion doesn't =
want to handle this server-side:
    http://subversion.tigris.org/issues/show_bug.cgi?id=3D1068
    (also: http://subversion.tigris.org/issues/show_bug.cgi?id=3D1065)

Since this is potentially a very critical issue, I suggest git-svn dcommit =
check and filter for such occurrences.
Alternatively, a prominent warning could be added to the relevant git-svn c=
ommands.


Details:
    git version 1.5.4.3
    svn version 1.4.6 (r28521)
    Plattform: Ubuntu 8.04 Hardy Heron
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 - -=20

Sincerly

Nico

PS: Please CC him and me on reply.

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIVlq9uL75KpiFGIwRAun/AJwKJCrDP3WDw9n6seDXP0ZFIPwGXgCdGWnB
jTk9xamigzmzhCWV19dGJrQ=
=FrPk
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
