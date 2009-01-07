From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH (topgit) 1/2] Implement setup_pager just like in git
Date: Wed, 07 Jan 2009 15:44:32 +0100
Message-ID: <20090107144432.GC831@artemis.corp>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru> <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net> <20090107112754.GA15158@roro3>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="5p8PegU4iirBW1oA";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	pasky@suse.cz
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Wed Jan 07 15:46:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKZfY-0005fC-WA
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 15:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbZAGOom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 09:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbZAGOom
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 09:44:42 -0500
Received: from pan.madism.org ([88.191.52.104]:39948 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbZAGOol (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 09:44:41 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 465AE3A5ED;
	Wed,  7 Jan 2009 15:44:38 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id DFE3B2B1DB; Wed,  7 Jan 2009 15:44:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090107112754.GA15158@roro3>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104799>


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2009 at 11:27:54AM +0000, Kirill Smelkov wrote:
> Martin, thanks for your review.
>=20
> I'll too reply inline:
>=20
> On Tue, Jan 06, 2009 at 09:32:03PM +0100, martin f krafft wrote:
> > Thanks, Kirill, for the patches. A couple of comments inline. I hope
> > Petr has a chance to look too.
> >=20
> > also sprach Kirill Smelkov <kirr@landau.phys.spbu.ru> [2009.01.06.1616 =
+0100]:
> > > +# isatty FD
> > > +isatty()
> > > +{
> > > +	tty -s 0<&$1 || return 1
> > > +	return 0
> > > +}
> >=20
> > You don't need any of the return statements. Functions' return
> > values are the return values of the last commands they execute.
>=20
> Agree, I'll rework isatty to be just
>=20
> isatty()
> {
> 	tty -s 0<&$1
> }

why not test -t 0 ? I'm not sure it's POSIX though.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklkv9AACgkQvGr7W6HudhzXOACff5NSAFe/icton5Yn91z5NG8e
tYwAn39nxiYtiU4bXWhphJBGyfw7E8Cn
=vhVc
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
