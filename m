From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI  revamp
Date: Mon, 03 Nov 2008 10:25:07 +0100
Message-ID: <20081103092507.GD13930@artemis.corp>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="SO98HVl1bnMOfKZd";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, Sam Vilain <samv@vilain.net>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 10:26:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwvhb-00018L-1M
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 10:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbYKCJZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 04:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754739AbYKCJZN
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 04:25:13 -0500
Received: from pan.madism.org ([88.191.52.104]:36157 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593AbYKCJZL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 04:25:11 -0500
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9DB8F3A721;
	Mon,  3 Nov 2008 10:25:08 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6DC1055AC1C; Mon,  3 Nov 2008 10:25:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99917>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2008 at 10:27:57PM +0000, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> >> +  * 'git push --matching' does what 'git push' does today (without
> >> +    explicit configuration)
> >
> > I think this is reasonable even without other changes, just to override
> > any configuration.
>=20
> I don't.  Can't you say "git push $there HEAD" these days?  I vaguely
> recall that there is a way to configure push that way for people too lazy
> to type "origin HEAD" after "git push".

Yes, but it's broken in the sense that if you're in a non matching
branch it creates it remotely. The way to configure it is to say
remote.push =3D HEAD in your .gitconfig or sth similar. I removed it
because I've created 2 times a new branch remotely that I didn't want to
because I was tired and forgot to checkout and merge into the proper
one.

I rarely do mistakes with git, but something like more than half of my
mistakes are with push. I've argued that in the past, I know most of the
other core git developers disagree with the fact that git-push UI is not
helping users to not shoot themselves in the foot, I disagree, but there
is not much I can do if I'm 1:10 to think that ;)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkOw3MACgkQvGr7W6Hudhzl6wCdEf+hssbX/bbUcKzR8NLO5SbB
sDMAniSLU4zlZIPTCV6zMf/O5t4TDx6i
=KgEP
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
