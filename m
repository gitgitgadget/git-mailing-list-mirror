From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: safecrlf not in 1.5.4
Date: Mon, 14 Jan 2008 18:35:02 +0100
Message-ID: <20080114173502.GA26586@artemis.madism.org>
References: <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <31687420-EB17-4651-AD6C-07213311ABDA@zib.de> <7vejcklv84.fsf@gitster.siamese.dyndns.org> <20080114090456.GZ2963@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="4Ckj6UjgE2iN1+kY";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 18:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JETDm-0001m3-Ky
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 18:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbYANRfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 12:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbYANRfJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 12:35:09 -0500
Received: from pan.madism.org ([88.191.52.104]:52261 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbYANRfH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 12:35:07 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2B9E22EF1C;
	Mon, 14 Jan 2008 18:35:03 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id DA9E9146D49; Mon, 14 Jan 2008 18:35:02 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
Content-Disposition: inline
In-Reply-To: <20080114090456.GZ2963@dpotapov.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70466>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2008 at 09:04:56AM +0000, Dmitry Potapov wrote:
> On Sun, Jan 13, 2008 at 11:30:51PM -0800, Junio C Hamano wrote:
> >=20
> > But we could end up having a short cycle for 1.5.5 if we agree
> > that the lack of crlf=3Dsafe is a severe bug that is worth fixing
> > post 1.5.4.
>=20
> Hopefully, the cycle for 1.5.5 will be a bit shorter than 1.5.4, because
> 1.5.4 seems to have the longest development cycle of all versions, and
> it already contains almost as much changes as three previous versions
> ("git diff v1.5.3 master" is almost as big as "git diff v1.5.0 v1.5.3").

  hehe, though we still do not have Megabytes of changes between two RCs
yet ;)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHi51GvGr7W6HudhwRArc8AKCVeGgmt0J6g8GUY6sJS8ucUmE9/wCgqbBY
j6Xr83OX5nZQjV5B/ephU1Y=
=KR0J
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
