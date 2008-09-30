From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-opt: migrate fmt-merge-msg.
Date: Tue, 30 Sep 2008 10:40:20 +0200
Message-ID: <20080930084019.GB11453@artemis.corp>
References: <1222595139-32087-1-git-send-email-madcoder@debian.org> <1222595139-32087-2-git-send-email-madcoder@debian.org> <20080929163523.GC18340@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="5/uDoXvLw7AC5HRs";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 10:41:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkanX-00045L-G6
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 10:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbYI3IkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 04:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbYI3IkX
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 04:40:23 -0400
Received: from pan.madism.org ([88.191.52.104]:43561 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029AbYI3IkW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 04:40:22 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 0EC433B797;
	Tue, 30 Sep 2008 10:40:21 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4296D2AF00; Tue, 30 Sep 2008 10:40:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080929163523.GC18340@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97082>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2008 at 04:35:23PM +0000, Shawn O. Pearce wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:
> > Also fix an inefficient printf("%s", ...) where we can use write_in_ful=
l.
> >=20
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  builtin-fmt-merge-msg.c |   50 +++++++++++++++++++++------------------=
-------
> >  1 files changed, 23 insertions(+), 27 deletions(-)
>=20
> Near as I can tell, this is based upon a merge commit in next.
>=20
> We can't do that.  Patches need to be based on master, or worst-case
> on a topic head that is in next or pu (in which case the name of
> the topic, or its tip commit, is helpful in the note).

Hmm I've always sent my patches this way, and I believe you can git am
-3 them on top of master easily. I can send you the updated series if
you want.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjh5fMACgkQvGr7W6HudhzsJQCeP3AJ+QSbyEOSa1MTUkZbCBSa
PIMAn1qMRzOubpyn9a+5ImK711S5j3ik
=2wne
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
