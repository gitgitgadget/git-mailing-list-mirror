From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-fast-import crashes
Date: Sat, 13 Oct 2007 09:36:40 +0200
Message-ID: <20071013073640.GC7110@artemis.corp>
References: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com> <20071013032916.GL27899@spearce.org> <20071013033407.GM27899@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="gE7i1rD7pdK0Ng3j";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Shun Kei Leung <kevinlsk@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 13 09:37:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgbYK-0002Wd-QV
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 09:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762126AbXJMHgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 03:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761704AbXJMHgo
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 03:36:44 -0400
Received: from pan.madism.org ([88.191.52.104]:56815 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbXJMHgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 03:36:43 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F379B24BB1;
	Sat, 13 Oct 2007 09:36:40 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 971183A0B19; Sat, 13 Oct 2007 09:36:40 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Shun Kei Leung <kevinlsk@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071013033407.GM27899@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60724>


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2007 at 03:34:07AM +0000, Shawn O. Pearce wrote:
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > Shun Kei Leung <kevinlsk@gmail.com> wrote:
> > > I am using git 1.5.3.4.206.g58ba4-dirty on Mac OS X 10.4.
> ....
> > > Program received signal EXC_BAD_ACCESS, Could not access memory.
> > > Reason: KERN_INVALID_ADDRESS at address: 0x64617469
> ....
> > This looks like it is
> > memory corruption (e.g. someone overwriting a free'd segment),
> > but that sort of memory corruption is very hard to track down.
>=20
> OK, so the version you have (58ba4) is the latest fast-import after
> the strbuf.c series went in.  The one immediately before that series
> was 4bf538 and is probably actually stable.
>=20
> So I wonder, can you test 4bf538 and then if it is good bisect
> between those two commits?  There must be a memory corruption
> introduced by one of the strbuf changes...

  Gasp, if you get the offending sha1 commit, don't forget to Cc: me.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEHWIvGr7W6HudhwRAvU6AJ48Da/A3CtAouQedf6zW4NyMOyCbQCeINe9
RE/uP/rMSWWuBCpXMT53nU0=
=jez9
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
