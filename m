From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-fast-import crashes
Date: Tue, 16 Oct 2007 10:04:05 +0200
Message-ID: <20071016080405.GC6919@artemis.corp>
References: <20071013032916.GL27899@spearce.org> <20071013033407.GM27899@spearce.org> <20071013073640.GC7110@artemis.corp> <20071013075027.GD7110@artemis.corp> <e66701d40710142153o70a7b696r928491be437ac6d@mail.gmail.com> <20071015073307.GA1508@artemis.corp> <e66701d40710150119y7c9e0ff6n83c5fbd25d351fc6@mail.gmail.com> <e66701d40710160013h270f685sef57f80382089f3c@mail.gmail.com> <20071016074645.GA6919@artemis.corp> <e66701d40710160101x5c697a6fmeecea4c81dfd9972@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="96YOpH+ONegL0A3E";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Shun Kei Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:04:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhhPd-0001PJ-Me
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401AbXJPIEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbXJPIEK
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:04:10 -0400
Received: from pan.madism.org ([88.191.52.104]:46616 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757100AbXJPIEH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:04:07 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id EC5B625384;
	Tue, 16 Oct 2007 10:04:05 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 855CF32BA7E; Tue, 16 Oct 2007 10:04:05 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Shun Kei Leung <kevinlsk@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <e66701d40710160101x5c697a6fmeecea4c81dfd9972@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61112>


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2007 at 08:01:18AM +0000, Shun Kei Leung wrote:
> >   What I _really_ need is that you run your test into valgrind (the easy
> > way is to rename git-fast-import into git-fast-import.bin, and make
> > git-fast-import be a shell-script doing:
> ....
>=20
> valgrind is not yet ported to Mac OS X, sadly enough.

  hmmm I see. hmmm isn't there _any_ chance that you can have access to
a linux box to see if that fails in the same conditions ? I mean I
believe qemu (or virtual pc or =E2=80=A6) on your macos would be just fine.

  But this realloc() that returns 0xd looks fishy. I would be tempted to
think of a stack corruption, but the frame just before still looks
correct so I'm confused. And valgrind is definitely the tool to use for
stack smashing and other memory related corruptions :/

  Using gcc -Wstack-protector may also help.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFHB1vGr7W6HudhwRAlPCAJ97iY+p33nHt2/naPbDUWU2XAA27ACfQ6re
0noY5I65vSe9PENekQAfpPc=
=9Xhd
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
