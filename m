From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 0/8] fetch.c optimizations
Date: Wed, 21 Sep 2005 20:18:29 +0400
Message-ID: <20050921161829.GA20944@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 18:23:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7JA-00065n-Jg
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 18:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVIUQSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 12:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVIUQSh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 12:18:37 -0400
Received: from mivlgu.ru ([81.18.140.87]:55778 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751119AbVIUQSg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 12:18:36 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id 8EC21180110; Wed, 21 Sep 2005 20:18:29 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9057>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I have noticed that git-*-fetch now uses much more CPU than it was
before the modifications to fix recovery after interrupted fetch.
Here is a series of small patches which fix the problems which I have
found (some of the fixes give pretty impressive results, like a 14x
decrease of CPU time); as a positive side effect, fetch.c becomes
slightly smaller and hopefully simpler than before.

--=20
Sergey Vlasov

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDMYfVW82GfkQfsqIRAg6eAKCOefWy+PDh+MWRTb7LkyBK3DIG9wCeIoH1
Ln7JZz91tRii+OqYg2WfRKI=
=hoCE
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
