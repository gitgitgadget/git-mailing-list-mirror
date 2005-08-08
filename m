From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 0/4] Plug some more memory leaks in git
Date: Mon, 8 Aug 2005 22:43:32 +0400
Message-ID: <20050808184332.GA5789@procyon.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 20:45:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Cbt-0000AE-AH
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 20:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVHHSo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 14:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVHHSo0
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 14:44:26 -0400
Received: from mail.murom.net ([213.177.124.17]:42179 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S932187AbVHHSo0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 14:44:26 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1E2Cbm-0007mL-9o; Mon, 08 Aug 2005 22:44:22 +0400
Received: by procyon.home (Postfix, from userid 500)
	id 68E01E51111; Mon,  8 Aug 2005 22:43:32 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

This set of patches fixes some more memory leaks which I have found in
git.  Especially the write_sha1_to_fd() leak was noticeable when
running git-ssh-push.

--=20
Sergey Vlasov

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC96fUW82GfkQfsqIRAqzJAJ4p28TlCQQ6nZ4sFddJMlmSAHpLZACeNNNk
lVldgANe7OiNmZIKD4zrPcw=
=bnJ5
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
