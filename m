From: Andreas =?utf-8?q?Kl=C3=B6ckner?= <lists@informa.tiker.net>
Subject: git repack and dumb protocols
Date: Wed, 3 Jun 2009 19:50:54 -0400
Message-ID: <200906031950.56974.lists@informa.tiker.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3620844.eDXxLrlkiA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 01:57:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC0Kr-00011b-Nu
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 01:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbZFCX5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 19:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbZFCX5Y
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 19:57:24 -0400
Received: from outbound-mail-306.bluehost.com ([67.222.53.252]:59355 "HELO
	outbound-mail-306.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753153AbZFCX5X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 19:57:23 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2009 19:57:23 EDT
Received: (qmail 24001 invoked by uid 0); 3 Jun 2009 23:50:46 -0000
Received: from unknown (HELO host304.hostmonster.com) (74.220.215.104)
  by outboundproxy6.bluehost.com with SMTP; 3 Jun 2009 23:50:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=informa.tiker.net;
	h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:X-Identified-User;
	b=FNuB7pXX2jfCl3F4CrKN5T7D63+C8T5EF9hx4PpuOlt//yBJdEGfQBhwjA3wKPAyacDZDXc84BuFBL/y9YZpMF3nRcD5YXTgCKFZOIdxFc67oQEyq1y4GLzJUySaRxVE;
Received: from ip68-9-132-118.ri.ri.cox.net ([68.9.132.118] helo=grizzly.localnet)
	by host304.hostmonster.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <lists@informa.tiker.net>)
	id 1MC0EH-00089A-Sp
	for git@vger.kernel.org; Wed, 03 Jun 2009 17:50:46 -0600
User-Agent: KMail/1.11.2 (Linux/2.6.30-rc7-686; KDE/4.2.2; i686; ; )
X-Identified-User: {11749:host304.hostmonster.com:tikernet:tiker.net} {sentby:smtp auth 68.9.132.118 authed with andreas-store+tiker.net}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120667>

--nextPart3620844.eDXxLrlkiA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

I've posted a git repository to the web that is an rsync copy of my=20
development archive's .git directory, with update-server-info run on it. No=
w=20
if I understand correctly, this contains a single file for every=20
commit/file/whatever else I ever made, which is a paint over HTTP. I have t=
hen=20
recently learned about the wonder that is git repack, which I would love to=
=20
use on this repository, were it not for this comment in its manpage:

8< ----------------------------------------------------------------------
Especially useful when packing a repository that is used for private=20
development and there is no need to worry about people fetching via dumb=20
protocols from it. 8<=20
=2D---------------------------------------------------------------------

It says this relating to the '-a' option, but it makes me wonder if I'll br=
eak=20
copies of the repo that other people have pulled if I use 'repack'? What ar=
e=20
the possible interactions and things to keep in mind between repack and dum=
b=20
protocols?

In any case, I would like to suggest that the rather ominous-sounding text =
in=20
the manpage be replaced with something more concrete, i.e. "If you repack a=
n=20
archive that has people fetching via dumb protocols from it, X, Y, and Z wi=
ll=20
happen."

Thanks,
Andreas

(please cc--not subscribed)

--nextPart3620844.eDXxLrlkiA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQBKJwxeJZ7T4Hn4+FIRAoKTAJ91/4b5g2b78ERdvX2HmU93Hn3Y6gCfeSKQ
Kg0PkwJROKjuXulVZ/+pAf0=
=lRnf
-----END PGP SIGNATURE-----

--nextPart3620844.eDXxLrlkiA--
