From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 0/7] C cleanup series, mostly nasty shadowing
Date: Wed, 23 Aug 2006 12:38:10 +0200
Organization: Polytechnique.org
Message-ID: <200608231238.10963.madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1266832.HvbWjUAKNA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 23 12:40:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFq7k-0006vb-Qn
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 12:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWHWKiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 06:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWHWKiO
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 06:38:14 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:30604 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S964822AbWHWKiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 06:38:13 -0400
Received: from mad.intersec.eu (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id 2554733296;
	Wed, 23 Aug 2006 12:38:12 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Wed Aug 23 12:38:12 2006 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000041, queueID=430073332C
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25909>

--nextPart1266832.HvbWjUAKNA
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


This series of patches intend to fix some not very nice bits of code.
None of them are critical though.

 0001-avoid-to-use-error-that-shadows-the-function-name-use-err-instead.txt
 0002-git_dir-holds-pointers-to-local-strings-hence-MUST-be-const.txt
 0003-missing-static-keywords.txt
 0004-remove-ugly-shadowing-of-loop-indexes-in-subloops.txt
 0005-missing-define-DEBUG-0-that-made-the-preprocessor-whine.txt
 0006-use-name-len-in-switch-directly-instead-of-creating-a-shadowed-variab=
le.txt
 0007-n-is-in-fact-unused-and-is-later-shadowed.txt

 builtin-apply.c    |   10 ++++------
 builtin-grep.c     |    2 ++
 builtin-mv.c       |    6 +++---
 builtin-push.c     |   10 +++++-----
 builtin-tar-tree.c |    2 +-
 cache.h            |    2 +-
 date.c             |    5 ++---
 environment.c      |    7 ++++---
 git.c              |    6 +++---
 http-push.c        |    2 +-
 10 files changed, 26 insertions(+), 26 deletions(-)

=2D-=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--nextPart1266832.HvbWjUAKNA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE7DASvGr7W6HudhwRAiQTAJ9Mkr6SbFoK0wPBBTQdxgLKPRoJ4ACfQZGh
11XZv57S6uf43UxBN26lGj0=
=Iml8
-----END PGP SIGNATURE-----

--nextPart1266832.HvbWjUAKNA--
