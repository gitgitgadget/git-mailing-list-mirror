From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI   revamp
Date: Tue, 04 Nov 2008 01:02:07 +0100
Message-ID: <20081104000207.GA29458@artemis.corp>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <7v3ai9226q.fsf@gitster.siamese.dyndns.org> <20081103092507.GD13930@artemis.corp> <7v4p2ov0zt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Dxnq1zWXvFF0Q93v";
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
X-From: git-owner@vger.kernel.org Tue Nov 04 01:06:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx9Qh-0007pc-Ur
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 01:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbYKDACO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbYKDACO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 19:02:14 -0500
Received: from pan.madism.org ([88.191.52.104]:46664 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbYKDACO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 19:02:14 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7D9F93BCAB;
	Tue,  4 Nov 2008 01:02:09 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 89BF52AF01; Tue,  4 Nov 2008 01:02:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v4p2ov0zt.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100013>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2008 at 11:33:10PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > On Sun, Nov 02, 2008 at 10:27:57PM +0000, Junio C Hamano wrote:
> >> Jeff King <peff@peff.net> writes:
> >>=20
> >> >> +  * 'git push --matching' does what 'git push' does today (without
> >> >> +    explicit configuration)
> >> >
> >> > I think this is reasonable even without other changes, just to overr=
ide
> >> > any configuration.
> >>=20
> >> I don't.  Can't you say "git push $there HEAD" these days?  I vaguely
> >> recall that there is a way to configure push that way for people too l=
azy
> >> to type "origin HEAD" after "git push".
> >
> > Yes, but it's broken in the sense that if you're in a non matching
> > branch it creates it remotely.
>=20
> Ok, I agree that may be a problem.
>=20
> But that would not change if you only changed the default behaviour from
> matching to _this branch_.  You need to also teach a new mode of operation
> to send-pack/receive-pack pair, which is to "update the same branch as the
> one I am on locally, but do not do anything if there is no such branch
> over there".  I do not think we have such a mode of operation currently.

You're right.

> By the way, didn't we add a feature to let you say "git push $there :"
> which is to do what "git push --matching $there" would do?

I don't know, I thought git push --matching $remote would be the same as
git push $remote ?

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkPkP0ACgkQvGr7W6HudhxttgCdEiKuePRi3h02kbe1pxxLA98y
adgAn1jdSJl0yoiT+TMm+6LmvbhriU8I
=D1kK
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
