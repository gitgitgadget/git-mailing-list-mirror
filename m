From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [Fwd: [ANNOUNCE] bzr-fastimport plugin, yet another Bazaar import option]
Date: Fri, 22 Feb 2008 12:37:37 +0100
Message-ID: <20080222113737.GA18581@artemis.madism.org>
References: <47BE167A.4060005@internode.on.net> <20080222073228.GF8410@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="rwEMma7ioTxnRzrJ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Ian Clatworthy <ian.clatworthy@internode.on.net>,
	Bazaar <bazaar@lists.canonical.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 12:38:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSWEK-0001up-NY
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 12:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbYBVLhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 06:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756558AbYBVLhl
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 06:37:41 -0500
Received: from pan.madism.org ([88.191.52.104]:40187 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756491AbYBVLhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 06:37:40 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4CD1BC356;
	Fri, 22 Feb 2008 12:37:38 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id DE82E527F1A; Fri, 22 Feb 2008 12:37:37 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ian Clatworthy <ian.clatworthy@internode.on.net>,
	Bazaar <bazaar@lists.canonical.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080222073228.GF8410@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74718>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2008 at 07:32:28AM +0000, Shawn O. Pearce wrote:
> Ian Clatworthy <ian.clatworthy@internode.on.net> wrote:
> > FYI. I thought you'd be interested in this as it's inspired by and based
> > on git-fast-import. You can download the Python source from
> > https://code.launchpad.net/bzr-fastimport/. In particular, there's a
> > Python parser of the stream format included that may be useful to the
> > Git community or other VCS communities. The fast-import-info and
> > fast-import-filter commands might also be useful to others.
>=20
> This is interesting.  I'm not a Python guy, but the info and filter
> commands do look like they could be useful beyond the Bazaar community.
>=20
> Michael Haggerty of cvs2svn has spent a good amount of time creating
> a git-fast-import backend to cvs2svn.  Given that cvs2svn is one of
> the few tools that can read some of the really strange real world
> CVS trees its good to be able to leverage that work for other systems
> (SVN, Git, and now Bazaar).

  /me opens bigs ears and eyes: does this mean that we have an
incremental importer of CVS based on git-fast-import ? I mean I'm really
interested into that, as git-cvsimport is really broken with the glibc
CVS tree, and as the glibc CVSROOT is rsync-able, an incremental
importer that has access to the CVSROOT RCS files is probably the most
efficient way.

  Is there any link you can provide to me about these new features of
cvs2svn ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHvrQBvGr7W6HudhwRAgf9AJ9dconeKET337+JMO+PQxuNlyOjxQCghZpu
3A8n7u1EKWzRaGNXVt1OVF8=
=zgAv
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
