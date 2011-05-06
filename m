From: Patrick =?iso-8859-1?q?H=E4cker?= 
	<patrick.haecker@lss.uni-stuttgart.de>
Subject: Improvement of git add interface
Date: Fri, 6 May 2011 14:03:28 +0200
Organization: LSS
Message-ID: <201105061403.28674.patrick.haecker@lss.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6099022.cmT5hgCqHl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 14:13:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIJuU-0005XN-0C
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 14:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130Ab1EFMNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 08:13:25 -0400
Received: from charybdis.rus.uni-stuttgart.de ([129.69.1.58]:38857 "EHLO
	charybdis.rus.uni-stuttgart.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752206Ab1EFMNY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 08:13:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by charybdis.rus.uni-stuttgart.de (Postfix) with ESMTP id 82AE5DB9CD
	for <git@vger.kernel.org>; Fri,  6 May 2011 14:03:30 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at charybdis.rus.uni-stuttgart.de
Received: from charybdis.rus.uni-stuttgart.de ([127.0.0.1])
	by localhost (charybdis.rus.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ib+08iOSLaXs for <git@vger.kernel.org>;
	Fri,  6 May 2011 14:03:29 +0200 (CEST)
Received: from uni-stuttgart.de (mbox.uni-stuttgart.de [129.69.1.9])
	by charybdis.rus.uni-stuttgart.de (Postfix) with ESMTP id D9801DB9BD
	for <git@vger.kernel.org>; Fri,  6 May 2011 14:03:29 +0200 (CEST)
X-Virus-Scanned: by mbox.uni-stuttgart.de
Received: from [129.69.32.117] (account insm113@isb.uni-stuttgart.de HELO pc117.localnet)
  by uni-stuttgart.de (CommuniGate Pro SMTP 5.3.7)
  with ESMTPSA id 145034208 for git@vger.kernel.org; Fri, 06 May 2011 14:03:29 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-686; KDE/4.4.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172972>

--nextPart6099022.cmT5hgCqHl
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I introduce git to students and thus see, where they have a harder time tha=
n=20
necessary to understand git.

Thus, I was thinking about a CLI improvement regarding "git add". It follow=
s=20
from the observation, that the students can learn consistent interfaces=20
faster.

Similar to "ls -a" =3D "ls --all" there is a "git commit -a" =3D "git commi=
t --
all", which means the same thing: use all files (with the known exceptions=
=20
in git). There is a "git add -A" =3D "git add --all", too, which is basical=
ly=20
the same. This leads to the following consistency question: Why is there no=
=20
"git add -a"? I suggest adding "git add -a" as an alias to "git add -add".=
=20
Maybe "git add -A" could then be deprecated in the long run, to not waste=20
option name space, but this can be discussed later.

Kind regards
Patrick

P.S. Please CC, as I am not subscribed

=2D-=20
Patrick H=E4cker
Universit=E4t Stuttgart=20
Lehrstuhl f=FCr Systemtheorie und Signalverarbeitung=20
Tel: +49 711 685 67362
E-Mail: patrick.haecker@lss.uni-stuttgart.de
URL: http://www.lss.uni-stuttgart.de

--nextPart6099022.cmT5hgCqHl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk3D45AACgkQRDNqD/jh8GJxewCfSt+SVu2ilEgQXwwqed909yq9
tagAn1JpyvhFRSbAwFge6ofOLodv76cd
=VyKV
-----END PGP SIGNATURE-----

--nextPart6099022.cmT5hgCqHl--
