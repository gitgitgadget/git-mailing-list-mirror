From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Fri, 31 Oct 2008 17:54:01 +0100
Message-ID: <20081031165401.GC627@artemis.corp>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org> <m33aichgc1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="QRj9sO5tAVLaXnSD";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 17:55:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvxHX-0001o8-6r
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 17:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbYJaQyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 12:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbYJaQyG
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 12:54:06 -0400
Received: from pan.madism.org ([88.191.52.104]:53545 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbYJaQyF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 12:54:05 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B287D3B637;
	Fri, 31 Oct 2008 17:54:02 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B6E715EE243; Fri, 31 Oct 2008 17:54:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m33aichgc1.fsf@localhost.localdomain>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99605>


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 04:36:33PM +0000, Jakub Narebski wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > * Rename builtin-revert.c into builtin-cherry-pick.c
> >=20
> > * Add option -R/--revert to git-cherry-pick.
> >   Document it by taking the current content of git-revert manpage for t=
he
> >   option.
> >=20
> > * get rid of the no_replay initialization, just ignore it when we're in
> >   the revert case, it makes really no sense to error out.
> >=20
> > * put the warning of deprecation in cmd_revert, #if 0-ed out for now.
>=20
> > +#if 0
> > +	warning("git revert is deprecated, please use git cherry-pick --rever=
t/-R instead");
> > +#endif
>=20
> By the way, Mercurial names this command IIRC 'hg backout'.=20
>=20
> But I think that adding '-R' option to git-cherry-pick is a good idea
> even if we don't go deprecating git-revert.

Actually part of the "Git UI sucks at time"-talk by pasy, we somehow
decided that git-revert would probably be deprecated in the future to
avoid the clash between what people coming from other's SCM worlds
expect it to be.

I don't remember what the tentative schedule was, that's why I left the
warning commented out for now.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLOCkACgkQvGr7W6HudhzEPgCfWpRFVDs2z23I4Ea8m+Ld0JHz
R/IAnA1zVr8WXqgS9nQFlkm7dioxxhz7
=e1wR
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
