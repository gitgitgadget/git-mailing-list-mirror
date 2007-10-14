From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add a simple option parser.
Date: Sun, 14 Oct 2007 09:02:19 +0200
Message-ID: <20071014070219.GA1198@artemis.corp>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <1192282153-26684-2-git-send-email-madcoder@debian.org> <20071013191655.GA2875@steel.home> <20071013205404.GK7110@artemis.corp> <20071013221450.GC2875@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="VS++wcV0S1rZb1Fb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 09:02:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgxUk-00027l-Dj
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 09:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbXJNHCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 03:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753671AbXJNHCX
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 03:02:23 -0400
Received: from pan.madism.org ([88.191.52.104]:41730 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbXJNHCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 03:02:22 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CE14E244A4;
	Sun, 14 Oct 2007 09:02:20 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CA6253A9; Sun, 14 Oct 2007 09:02:19 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071013221450.GC2875@steel.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60799>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2007 at 10:14:50PM +0000, Alex Riesen wrote:
> Pierre Habouzit, Sat, Oct 13, 2007 22:54:04 +0200:
> > On Sat, Oct 13, 2007 at 07:16:55PM +0000, Alex Riesen wrote:
> > > Pierre Habouzit, Sat, Oct 13, 2007 15:29:03 +0200:
> > > BTW, if you just printed the usage message out (it is about usage of a
> > > program, isn't it?) and called exit() everyone would be just as happy.
> > > And you wouldn't have to include strbuf (it is the only use of it),
> > > less code, too. It'd make simplier to stea^Wcopy your implementation,
> > > which I like :)
> >=20
> >   the reason is that usage() is a wrapper around a callback, and I
> > suppose it's used by some GUI's or anything like that.
>=20
> It is not. Not yet. What could they use a usage text for?
> Besides, you could just export the callback (call_usage_callback or
> something) from usage.c and call it.

  Okay makes sense.

> >   FWIW you can rework the .c like this:
>=20
> on top of yours:

  Added (reworked a bit for the current state of parse_options), and pushed.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEb77vGr7W6HudhwRAr/pAKCbSMQF9/Ok1Ufzamd5H9Ysz6ucjACfYOxC
8419iQmhWb5mVOPoii6CWf8=
=Kr0q
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
