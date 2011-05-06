From: Patrick =?iso-8859-1?q?H=E4cker?= 
	<patrick.haecker@lss.uni-stuttgart.de>
Subject: Improvement of git commit interface
Date: Fri, 6 May 2011 14:03:20 +0200
Organization: LSS
Message-ID: <201105061403.27242.patrick.haecker@lss.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2659567.KF26eyQT0c";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 14:10:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIJrh-000448-PW
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 14:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616Ab1EFMKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 08:10:32 -0400
Received: from charon.rus.uni-stuttgart.de ([129.69.1.54]:34622 "EHLO
	charon.rus.uni-stuttgart.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751324Ab1EFMKb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 08:10:31 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 May 2011 08:10:31 EDT
Received: from localhost (localhost [127.0.0.1])
	by charon.rus.uni-stuttgart.de (Postfix) with ESMTP id 16F785FDCA
	for <git@vger.kernel.org>; Fri,  6 May 2011 14:03:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at charon.rus.uni-stuttgart.de
Received: from charon.rus.uni-stuttgart.de ([127.0.0.1])
	by localhost (charon.rus.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qh1QaS97ZfDn for <git@vger.kernel.org>;
	Fri,  6 May 2011 14:03:28 +0200 (CEST)
Received: from uni-stuttgart.de (mbox.uni-stuttgart.de [129.69.1.9])
	by charon.rus.uni-stuttgart.de (Postfix) with ESMTP id 5D2FB5FDC4
	for <git@vger.kernel.org>; Fri,  6 May 2011 14:03:28 +0200 (CEST)
X-Virus-Scanned: by mbox.uni-stuttgart.de
Received: from [129.69.32.117] (account insm113@isb.uni-stuttgart.de HELO pc117.localnet)
  by uni-stuttgart.de (CommuniGate Pro SMTP 5.3.7)
  with ESMTPSA id 145034199 for git@vger.kernel.org; Fri, 06 May 2011 14:03:27 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-686; KDE/4.4.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172971>

--nextPart2659567.KF26eyQT0c
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I introduce git to students and thus see, where they have a harder time tha=
n=20
necessary to understand git.

Thus, I was thinking about a CLI improvement regarding "git commit". It=20
follows from the observation, that the staging area is a very valuable=20
thing, but it should not be needed for very simple workflows and thus shoul=
d=20
not be the first concept, the students have to learn about.

After a file has been added to the repository once, you can use git without=
=20
knowing anything about the staging area, with "git commit <filename>".=20
Shouldn't we allow "git commit <filename>" for files never added to git, as=
=20
well?
Then, IMHO this would be more consistent, as in a small project a typical=20
commit (with a new file) consists of adding a new file to the repository an=
d=20
changing an existing file (e.g. to call a function located in the new file)=
=2E=20
ATM this is done with "git add <newfile> <oldfile> && git commit". But as w=
e=20
track content and not files, it were perfectly logical, if "git commit=20
<newfile> <oldfile>" were possible, as then it were completely consistent t=
o=20
only change an existing file without adding a new file, which is "git commi=
t=20
<oldfile>".

So I suggest to change "git commit <filename>" so that if <filename> cannot=
=20
be found in the repository, it is also looked for in the working directory=
=20
and basically a "git add <filename> && git commit" is done if the <filename=
>=20
is found.

I do _not_ suggest to change "git commit -a" to include all files never=20
added to git, because that would be rather error prone. So after the change=
=20
we would have an inconsistency between "git commit <newfile>" and "git=20
commit -a", but I think this inconsistency is better than having the=20
inconsistency between "git commit <oldfile>" and "git commit <newfile>".

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

--nextPart2659567.KF26eyQT0c
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk3D44gACgkQRDNqD/jh8GL90ACcDPCFQOneNeXT52wb9XlxH23X
o+8An1dWQjRdnz4Fdhv4dlSbfXSJ9FMg
=sh6R
-----END PGP SIGNATURE-----

--nextPart2659567.KF26eyQT0c--
