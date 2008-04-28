From: Nico Schottelius <nico-git-20080428@schottelius.org>
Subject: git push: failed to push some refs and missing commit
Date: Mon, 28 Apr 2008 19:10:20 +0200
Message-ID: <20080428171020.GF23412@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 19:11:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWsk-0001GQ-Ty
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 19:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763103AbYD1RKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 13:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933547AbYD1RKY
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 13:10:24 -0400
Received: from mx2.schottelius.org ([62.65.138.77]:53749 "EHLO
	mx2.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763103AbYD1RKX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 13:10:23 -0400
Received: from denkbrett.schottelius.org (natgw.netstream.ch [62.65.128.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.schottelius.org (Postfix) with ESMTPSA id 7538A1D584F;
	Mon, 28 Apr 2008 19:10:16 +0200 (CEST)
Received: by denkbrett.schottelius.org (Postfix, from userid 1000)
	id 92C041E1A5; Mon, 28 Apr 2008 19:10:20 +0200 (CEST)
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.25-denkbrett on x86_64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80565>


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Error 1:

When doing git-push once I get:

chdebfl0@u0160:~/public_html/nello$ git-push
Counting objects: 43, done.
Compressing objects: 100% (19/19), done.
Writing objects: 100% (24/24), 6.94 KiB, done.
Total 24 (delta 17), reused 3 (delta 2)
Unpacking objects: 100% (24/24), done.
To /home/server/git/web/nello/.git
   9299071..06c9c06  master -> master
error: failed to push some refs to '/home/server/git/web/nello/.git'
chdebfl0@u0160:~/public_html/nello$ git-status
# On branch master
nothing to commit (working directory clean)

Doing git-fetch does not fetch, as there is nothing new, git-push
succeeds the second time:

chdebfl0@u0160:~/public_html/nello$ git-fetch
chdebfl0@u0160:~/public_html/nello$ git-push
Everything up-to-date
chdebfl0@u0160:~/public_html/nello$=20

Error 2:

I miss a commit, that removed the function hideContent();

If I do

% git-log -p -ShideContent

I see two commits:

- the first one, that introduced the function
- the second one that I used to git checkout <firstcommit> filename it again

It seems some other files have been modified without having an log entry.

Anyone an idea, what could be the reason for it?

Sincerly

Nico

PS: Please CC me, I am not subscribed.

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIFgT8uL75KpiFGIwRAngIAKDZxyGV5FSR3XKu2Lr2IoQ9jOECQQCgl6qP
xTqOBNRxcXEmkG+90/ed7fc=
=p9Bx
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
