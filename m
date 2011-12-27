From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] add post-fetch hook
Date: Tue, 27 Dec 2011 11:49:07 -0400
Message-ID: <20111227154907.GB15006@gnu.kitenet.net>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
 <20111225035059.GA29852@gnu.kitenet.net>
 <7vsjk99exw.fsf@alter.siamese.dyndns.org>
 <20111226023154.GA3243@gnu.kitenet.net>
 <7vlipz930t.fsf@alter.siamese.dyndns.org>
 <20111226155152.GA29582@gnu.kitenet.net>
 <7v8vly8qqx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 27 16:49:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfZHR-000824-4H
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 16:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603Ab1L0PtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 10:49:12 -0500
Received: from wren.kitenet.net ([80.68.85.49]:46113 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754350Ab1L0PtK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 10:49:10 -0500
Received: from gnu.kitenet.net (sctv-77-102.mounet.com [216.145.77.102])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 12ACD132972;
	Tue, 27 Dec 2011 10:49:09 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id DF09C40E44; Tue, 27 Dec 2011 10:49:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v8vly8qqx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187714>


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Joey Hess <joey@kitenet.net> writes:
>=20
> > .... And other code in git uses an async feeder similarly,
> > see for example convert.c's apply_filter(). So I think this is ok..?
>=20
> Yeah, I didn't look at your patch (sorry) but if it uses async like the
> filtering codepath does, it should be perfectly fine (please forget about
> the select(2) based kludge I alluded to; the async interface is the right
> thing to use here).

No problem, I was surprised to be getting responses at all over the
holidays. :)

Then async also seems the right thing to use for the hook refactoring. A
caller can provide two function pointers; a feeder function that is
called async, and a reader that is *not* called async (which would allow
it to modify program state), and the refactored hook function handles
running the hook(s) and connecting them to the feeder and/or reader.

--=20
see shy jo

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTvno88kQ2SIlEuPHAQiVDw//ScTVQ3JGeyeCMZQ7Z6M1PH/NiAUApP74
k79gpeQ2KrDU0VT8/BaOw8YcEAe0pD/xJkB2qTCT196WcdJ74n5EGyOu2HhkcGa2
C/AMn9kHcD9bQ3qSzt64tDGnfXqgR4Ef2UYITzoNckLqU8OTRhb7EU+y/csq8Gj4
wwSTJXGjZZGsZ4njinE25sBX4LpvVX1p3sU7zY4/a555c1X9FSZtvTqBJmRxacco
Nn1ttlkCJdH45nVxtDjChRdIEsKTa+L2+UZf+sEAQN3PtAYMxy2BBQXslOenOPvn
e9Yn31Uy6jQro6WkFVIo3afuzB7mpCP+mYH4ZGYW2HcLaAtbioB3h2y8ROcPoDbN
Lr9KpqnPCInhGwO7ab/Za5hN1tWKZjBuuaU0A7xlPXd0lfdG8TjjVini+DaEKLth
rBh3W5sxBal5xluZtcjcN9Jt41tOMeuDdWe1+9Q8kz9Lb0gcBsw0ufSKXO6bK1nU
N2hqm+32bO9D2XSGxSZeVPbyxvI0g/YdQBhDFYHXGZB7XFngcasFk8pUGFmWW/Xm
m4Fm/mivgo++xjEqsV6vFMFfOQwZwRHtMU8VmlaYvy22mK19oESKVyPxDIKmbusc
0OtIzQ8dFkrrCyKwVXdcmhe3drjFfnQOHtTaleOLEtNNyGBDjDsWOGEFcIpcGcPU
wcOo+IGg+/w=
=c2IU
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
