From: Martin Sivak <mars@nomi.cz>
Subject: Re: [PATCH] GIT_SSH alternate ssh name or helper
Date: Wed, 3 Aug 2005 20:56:21 +0200
Message-ID: <20050803185621.GA20645@medusa>
References: <20050803151542.GA6655@medusa> <7viryndjvu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
X-From: git-owner@vger.kernel.org Wed Aug 03 20:55:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0ON0-0003XP-Q7
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 20:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVHCSxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 14:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVHCSxd
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 14:53:33 -0400
Received: from r72s12p17.home.nbox.cz ([83.240.5.75]:31115 "EHLO
	r72s12p17.home.nbox.cz") by vger.kernel.org with ESMTP
	id S262392AbVHCSxc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 14:53:32 -0400
Received: by r72s12p17.home.nbox.cz (Postfix, from userid 1000)
	id 8CE50AC687; Wed,  3 Aug 2005 20:56:21 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7viryndjvu.fsf@assigned-by-dhcp.cox.net>
X-Operating-System: Linux medusa 2.6.11.8
X-PGP-Key: http://montik.net/mars.asc
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I understand why you would want this if your ssh binary is
> called something other than ssh [*1*], but I doubt the example
> you gave needs this patch.  Could you explain why having
> something like this in your .ssh/config file is not enough?
>=20
>     Host foo.bar.xz
>       Protocol 1
>       IdentityFile ~/.ssh/privatekey.key

The example was of course about the simpliest thing i thought of.

I would find that variable (GIT_SSH) usefull, and actually it does no
harm, because you already have GIT_SSH_PULL & PUSH variables, for the
same purpose (to define different name).

Actually I think there is at least one case, when helper script is useful.
I mean, how would you setup different identities for more user accounts on =
the
same server (it doesn't happen often, but..)?

Best regards
--
Martin Sivak
mars@nomi.cz


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC8RNVLtuY88yhq1wRAn5wAJ0Zy7GL+uQX4thtFJGZt1F3Ru7S/QCfexqQ
tSAa3ch4MRBqxft93zXLmQ8=
=PEVe
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
