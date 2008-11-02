From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/3] git send-email: make the message file name more  specific.
Date: Sun, 02 Nov 2008 10:35:33 +0100
Message-ID: <20081102093533.GE4066@artemis>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225456609-694-1-git-send-email-madcoder@debian.org> <1225456609-694-2-git-send-email-madcoder@debian.org> <7vwsfm3b33.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="cPi+lWm09sJ+d57q";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:36:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZO5-0005aQ-Uu
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbYKBJfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbYKBJfg
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:35:36 -0500
Received: from pan.madism.org ([88.191.52.104]:36422 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065AbYKBJfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:35:36 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D71753B830;
	Sun,  2 Nov 2008 10:35:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 75A2E37A8B; Sun,  2 Nov 2008 10:35:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vwsfm3b33.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99832>


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2008 at 06:18:08AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > This helps editors choosing their syntax hilighting properly.
>=20
> Even though I agree this is the right direction to go, unfortunately this
> can break people's existing setup.

Well for now vim (I don't know if emacs has syntax highlight for it)
does:
    autocmd BufNewFile,BufRead .msg.[0-9]*
	  \ if getline(1) =3D~ '^From.*# This line is ignored.$' |
	  \   setf gitsendemail |
	  \ endif

Even if you're illiterate in vim script language, you should grok what
it does, because of the fact that .msg.nnnn is hardly something one can
recognize. I believe it's highly unlikely to break anything.

What do other people think ?

> Having said that, if we were to do this, let's do it the right way and put
> these "temporary" files under $GIT_DIR.

Agreed, I should have done that.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkNdGUACgkQvGr7W6HudhzSGwCfe67SD+NOphq7908Ued9Fmcyc
DlcAn29YA+mnrs1cH6V9KhMl767eLf8I
=hQc3
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
