From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Fri, 31 Oct 2008 17:58:14 +0100
Message-ID: <20081031165814.GD627@artemis.corp>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org> <20081031165003.GA5355@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="wULyF7TL5taEdwHz";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 17:59:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvxLO-0003UX-P8
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 17:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbYJaQ6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 12:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbYJaQ6Q
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 12:58:16 -0400
Received: from pan.madism.org ([88.191.52.104]:54556 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbYJaQ6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 12:58:16 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 499EC3B637;
	Fri, 31 Oct 2008 17:58:15 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 1BB3D5EE243; Fri, 31 Oct 2008 17:58:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081031165003.GA5355@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99606>


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 04:50:03PM +0000, Alex Riesen wrote:
> Pierre Habouzit, Fri, Oct 31, 2008 16:55:27 +0100:
> > @@ -439,16 +436,17 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
> > =20
> >  int cmd_revert(int argc, const char **argv, const char *prefix)
> >  {
> > +#if 0
> > +	warning("git revert is deprecated, please use git cherry-pick --rever=
t/-R instead");
> > +#endif
>=20
> "git revert" is much shorter to type than "git cherry-pick -R".
> How about renaming "cherry-pick" into something short, like "pick"?

Do you really use git revert _that_ often ? I don't. And cherry-pick is
a really usual name for the tool.

FWIW the basic idea is to deprecate revert in a (not so ?) long time,
and leave git revert unimplemented for ever so that people that would
like it to be 'git checkout HEAD --' alias it to that, and the ones that
want to keep the current behaviour alias it to 'git cherry-pick -R'

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLOSYACgkQvGr7W6Hudhz7zgCdFEumJQHXulFXDNPIAPUm0Crr
P3EAnRKT4Xob1RxtjfRf6gMx17zLX1G8
=sdzY
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
