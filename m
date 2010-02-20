From: Carl Worth <cworth@cworth.org>
Subject: [PATCH] test-lib.sh: Add explicit license detail, with change from GPLv2 to GPLv2+.
Date: Sat, 20 Feb 2010 11:55:26 -0800
Message-ID: <87eikfhec1.fsf@yoom.home.cworth.org>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	<87hbpwpoko.fsf@yoom.home.cworth.org>
	<5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com>
	<201002081614.24284.sojkam1@fel.cvut.cz>
	<871vgr78lr.fsf@yoom.home.cworth.org>
	<87iqa2y0gz.fsf@steelpick.localdomain>
	<87r5oqe7mi.fsf@yoom.home.cworth.org>
	<871vgmki4f.fsf@steelpick.localdomain>
	<7vaav8hpfo.fsf@alter.siamese.dyndns.org>
	<87tytdiqob.fsf@steelpick.localdomain>
	<alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
	<873a0xhwxs.fsf@yoom.home.cworth.org>
	<alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Michal Sojka <sojkam1@fel.cvut.cz>,
	Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	notmuch@notmuchmail.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 20 21:32:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NivQN-00041K-7K
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 20:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990Ab0BTTza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 14:55:30 -0500
Received: from u15218177.onlinehome-server.com ([82.165.184.25]:51002 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab0BTTz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 14:55:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 5DB53431FBD;
	Sat, 20 Feb 2010 11:55:28 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jk+WQX3e-cm3; Sat, 20 Feb 2010 11:55:27 -0800 (PST)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 0F53C431FAE;
	Sat, 20 Feb 2010 11:55:27 -0800 (PST)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id BC3A125427A; Sat, 20 Feb 2010 11:55:26 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140548>

--=-=-=
Content-Transfer-Encoding: quoted-printable

This file has had no explicit license information noted in it, but
has clearly been created and modified according to the terms of GPLv2
as with the rest of the git code base.

The purpose of relicensing is to allow other GPLv3+ projects (in
particular, the notmuch project: http://notmuchmail.org) to use this
same test-suite structure (and to contribute changes back as well).

The request for relicensing was presented to the git community in:

	Message-ID: <871vgmki4f.fsf@steelpick.localdomain>

and explicitly agreed to by Junio C Hamano, Sverre Rabbelier, Johannes
Schindelin, Pierre Habouzit, and Johannes Sixt.
=2D--

On Fri, 19 Feb 2010 22:04:37 +0100 (CET), Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> On Fri, 19 Feb 2010, Carl Worth wrote:
>
> > I think the most clear step forward would be for test-lib.sh to be
> > updated in the git repository with an explicit licensing blurb
> > reflecting this agreement.
>=20
> Sure. If you make an appropriate patch, I'll ACK it.

Thanks Johannes,

Hopefully this does the trick. Otherwise, please let me know.

=2DCarl

 t/test-lib.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index afd3053..004470f 100644
=2D-- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -2,6 +2,18 @@
 #
 # Copyright (c) 2005 Junio C Hamano
 #
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see http://www.gnu.org/licenses/ .
=20
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
=2D-=20
1.6.5.7


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFLgD4u6JDdNq8qSWgRAgvsAJ967kKQACADf0bMbDEiRviz3S6s3gCfU9lR
GIzZuopHNS96brdZO264JnQ=
=mdcQ
-----END PGP SIGNATURE-----
--=-=-=--
