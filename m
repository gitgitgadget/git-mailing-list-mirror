From: Joey Hess <joey@kitenet.net>
Subject: Re: speed of git reset -- file
Date: Thu, 2 Jun 2011 00:36:30 -0400
Message-ID: <20110602043630.GA5081@gnu.kitenet.net>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
 <7v62oqignm.fsf@alter.siamese.dyndns.org>
 <20110601195831.GA30070@sigill.intra.peff.net>
 <20110601201629.GA25354@gnu.kitenet.net>
 <20110601211847.GA31958@sigill.intra.peff.net>
 <20110601220502.GA28493@gnu.kitenet.net>
 <20110601225647.GD16820@sigill.intra.peff.net>
 <20110601233157.GA2468@gnu.kitenet.net>
 <20110602031831.GA21008@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 06:37:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRzez-0002Hv-5G
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 06:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159Ab1FBEgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 00:36:38 -0400
Received: from wren.kitenet.net ([80.68.85.49]:59047 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab1FBEgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 00:36:37 -0400
Received: from gnu.kitenet.net (dialup-4.152.108.216.Dial1.Atlanta1.Level3.net [4.152.108.216])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id B5B5F11914F;
	Thu,  2 Jun 2011 00:36:35 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id D829640039; Thu,  2 Jun 2011 00:36:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110602031831.GA21008@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174923>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> Yeah, it is going to be painful on a cold cache. But I wonder whether
> your workflow would really permit the "reset" thing to make a
> difference. That is, are you doing "git reset -- file" from a cold
> cache, and then doing _nothing_ else with git? Because while yes, it may
> be annoying for the "reset" to take 30 seconds, it's warming the cache
> so that the subsequent "diff" or "status" will take 29.1 seconds less.
>=20
> Which isn't to say I'm not sympathetic to the performance problems of
> large repos on a cold cache. But I'm not sure there's really a way
> around that. You're going to want to see the stat information eventually
> if you are doing anything meaningful with git, and once it's loaded, the
> warm cache delay isn't too bad. Trying to avoid it seems like a losing
> battle.

Could be true in general. While I've gotten the reset out of this
workflow (realized I could just `git checkout HEAD file` and that would
also clear staged changes), in this case it was actually *unlikely* that
the cache would be unused, as I was resetting to throw unwanted changes
away.

--=20
see shy jo

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTecTTskQ2SIlEuPHAQgKdw//W0ufqQW6Pz1uHC8tCM4ysy1T5pXATQi2
wo6XuIVoSmToi227awL15Cp5iMS2FLi1S5ZnH+lN4/Y+5MnbcQ+dj+/XU0x+ikKh
KxqqdFcz1k/93uXqYpN4ZyKYWxG2ONPs8qmqkMR3usaTxXLI5PuC1ifNpA/fCyLs
4pT2MfGDdBzbAnecKgjiokPzgrY8oWM/rxqVJup5nNFmugFT1XDe51L+ZKlfwXC2
hZD6x448r5Fd1/1ZTBe6dORQJFA0hLw7XkoL/7jYixRy8wbu4Qcthq/gGEH/h25Y
QZRot9PfC9y3G9V5wwvWxI6EJ5MEI71wuGTbVUHBlHZbYCi7bnRbgCNnNQL/5s4Y
mq4WK77pGkl6HQhd9Fi/wFHQ/offL7ShqfvmKNkhgDXyMoG2rBew2YmNqolQlT9F
Ms6vXqz03l+9mfg1Qey2Nh85fAnjmydI5mhaMVBArpYPfNmHLzpTfUXukzkuNhwi
7k/n8sk7jVnNrrA3kIbGqzg8bCXm0oMcrW211sPXFgrfW/s4tVUxcGRCmBZ84YrA
Vz2VrI2yIoRDi995o+Tli/zpxpKWuoVh2eiFRHkKrHv9slvuQHhpu2rmc97TL0SX
5+Hm5oNH21NEMCS33a1JYpfHXekE8Eon5EkCU3uJSqFgc+uC6oBXijt1IrK580d3
u7dMoqmzPy4=
=6xev
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
