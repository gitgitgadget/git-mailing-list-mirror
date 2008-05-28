From: Nico -telmich- Schottelius <nico-git-20080529@schottelius.org>
Subject: [RFC] Rename git-rm --cached to --index
Date: Thu, 29 May 2008 01:14:05 +0200
Message-ID: <20080528231405.GA25416@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Cc: Nico -telmich- Schottelius <nico-git-20080529@schottelius.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 01:15:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1UrQ-0007U4-Sr
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 01:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbYE1XOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 19:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754217AbYE1XOL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 19:14:11 -0400
Received: from mx2.schottelius.org ([62.65.138.77]:37767 "EHLO
	mx2.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbYE1XOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 19:14:10 -0400
Received: from denkbrett.schottelius.org (unknown [62.65.155.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.schottelius.org (Postfix) with ESMTPSA id 477003177EE;
	Thu, 29 May 2008 01:14:00 +0200 (CEST)
Received: by denkbrett.schottelius.org (Postfix, from userid 1000)
	id 579D41604E; Thu, 29 May 2008 01:14:05 +0200 (CEST)
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.25.3-denkbrett on x86_64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83143>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I just re-read the git-rm manpage and recognized git-rm knows about
the --cached option. As in current git we do not talk about the cache,
but about the index, it would imho make sense to rename --cache to
--index in a user friendly way:

- add --index to git-rm
- add --index to manpage of git-rm
- still support --cached in git-rm
- add hint in manpage that --cached is old naming style

I think naming it --index would make life more consistent for new users
of git.

Now I'm interested in your opinion ;-)

Sincerly

Nico

P.S.: As always, please CC me on reply

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIPec9uL75KpiFGIwRAmZOAKC9MzYTnjWD7iGtQ22AeM7x/WB6SgCeJl6K
veOlIttxO2AW+MuhhFYY7jM=
=n5Mw
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
