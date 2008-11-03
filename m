From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: error: non-monotonic index
Date: Mon, 03 Nov 2008 09:51:05 +0100
Message-ID: <20081103085105.GA13930@artemis.corp>
References: <804dabb00811021832k28276bf7ke0146a8bbd648574@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="lrZ03NoBR/3+SXJZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Peter Teoh <htmldeveloper@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 09:52:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwvAe-0001LH-1n
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 09:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbYKCIvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 03:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbYKCIvJ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 03:51:09 -0500
Received: from pan.madism.org ([88.191.52.104]:45747 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808AbYKCIvI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 03:51:08 -0500
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8B5823B429;
	Mon,  3 Nov 2008 09:51:06 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3428755AC1C; Mon,  3 Nov 2008 09:51:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <804dabb00811021832k28276bf7ke0146a8bbd648574@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99913>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2008 at 02:32:44AM +0000, Peter Teoh wrote:
> I git pull and got errors, then git repack and pull again......the
> error increased....what happened?

what is your local git version and the remote one ?

It's likely that your local git is not aware of packs v2 which is now
default. You want to upgrade your local git, if you're on Debian etch,
updates have been pushed in the last dot release. Or you can even use
git-core from backports.org which is even more up to date (1.6.sth I
guess).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkOu3cACgkQvGr7W6HudhzrdACgldecVEOL4n5gp3R2pvuxcyY3
bK4AoIKRwNA6N+QuSJEWNQL+3KJKwwTd
=4vXE
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
