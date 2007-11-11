From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git rm --cached
Date: Sun, 11 Nov 2007 15:05:18 +0100
Message-ID: <20071111140518.GA3847@efreet.light.src>
References: <20071102021711.GA28703@fawkes.hq.digizenstudio.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 15:06:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrDRg-0003eX-7i
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 15:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbXKKOFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 09:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbXKKOFb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 09:05:31 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:59195 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374AbXKKOFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 09:05:30 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 23B8857446
	for <git@vger.kernel.org>; Sun, 11 Nov 2007 15:05:29 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id DTSvQX8C5yza for <git@vger.kernel.org>;
	Sun, 11 Nov 2007 15:05:26 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 815FA5741F
	for <git@vger.kernel.org>; Sun, 11 Nov 2007 15:05:26 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IrDR8-0006hy-Ru
	for git@vger.kernel.org; Sun, 11 Nov 2007 15:05:18 +0100
Content-Disposition: inline
In-Reply-To: <20071102021711.GA28703@fawkes.hq.digizenstudio.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64461>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2007 at 22:17:11 -0400, Jing Xue wrote:
> In the following scenario, why do I have to run 'git reset' following
> 'git rm --cached 1.txt' to revert to exactly where I was before 'git add
> 1.txt'?  Shouldn't 'git rm --cached' have done that already?

The message in git-commit suggesting to use 'git rm --cached' to unstage is
just plain wrong. It really should mention 'git reset'.

git rm, as the name suggests, *removes* the file.=20

git reset, as the name suggests, reverts it to the state it was before (but,
somewhat confusingly, with path limit only resets the index, so no --cached
option there).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHNwweRel1vVwhjGURAtsSAJ0YvCXWbiG49WKNIsPyaLVZhDd9/ACeOGUD
F4tQ5cJUIz0gYnOX8VyT8MQ=
=o+v/
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
