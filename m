From: Joey Hess <joey@kitenet.net>
Subject: Re: [regression] Re: git-cat-file --batch reversion; cannot query
 filenames with spaces
Date: Fri, 2 Aug 2013 11:27:13 -0400
Message-ID: <20130802152713.GA23548@gnu.kitenet.net>
References: <20130801201842.GA16809@kitenet.net>
 <20130802064003.GB3013@elie.Belkin>
 <20130802105402.GA25697@sigill.intra.peff.net>
 <20130802115906.GA9183@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 02 17:35:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5HOS-0007aS-8u
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 17:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806Ab3HBPfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 11:35:48 -0400
Received: from wren.kitenet.net ([80.68.85.49]:60265 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab3HBPfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 11:35:47 -0400
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Aug 2013 11:35:47 EDT
Received: from gnu.kitenet.net (cl-539.chi-02.us.sixxs.net [IPv6:2001:4978:f:21a::2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (not verified))
	by kitenet.net (Postfix) with ESMTPS id F21CA11958D;
	Fri,  2 Aug 2013 11:27:15 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id C2A404827C; Sat,  3 Aug 2013 01:27:13 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <20130802115906.GA9183@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231526>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> By the way, Joey, I am not sure how safe "git cat-file --batch-check" is
> for arbitrary filenames. In particular, I don't know how it would react
> to a filename with an embedded newline (and I do not think it will undo
> quoting). Certainly that does not excuse this regression; even if what
> you are doing is not 100% reliable, it is good enough in sane situations
> and we should not be breaking it. But you may want to double-check the
> behavior of your scripts in such a case, and we may need to add a "-z"
> to support it reliably.

Yes, I would prefer to have a -z mode. I think my code otherwise handles
newlines.

Thanks for the quick fix. I agree that only enabling the behavior with
%{rest} makes sense.

--=20
see shy jo

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUBUfvPzskQ2SIlEuPHAQgqxQ/9ELzVISADWa1CL99jgm9yhdI2k4z9o0JR
4ls3PAYVPTgOfIltpV9+JDWy32Wx8PMN/trLFhp5QgzC3YJ7SxgKpZKTVN7MnafE
ANgBKhk879d+vLMk3C8Fg7oEzbJhkzUy+2FQisn+7i6dwG7akgK44hj8QInskA3/
F9pXaZMGLJ9/hsJDjSTUZe1RFhW5qkmHO/CDYVzraG+vr5XDTI0yRk9LUAEjhEwi
PHa/lYkt2x6D4XO706XYKg56Br++cQFNgjG8bXsN+acpXAUAfDQMJxGXFeO7hszY
n56hGIUYTL0YwYfd88wEh9+smpjtHdQq9lgHvVgYbzTGE+BcIpakbG1rzO1I6t3o
V737DslV75s4//fPBcsoFmE3U9QS8SNDPNsUOfZbxgoU53bG4cnrmBP4KK6CCxmG
XAUtd2sYsZcM9O0SkYJIYeclCkDfOZfbafkBbb9lMTdwUqV3Xn14Dlxz/TUEBJvh
v0tBhT6+LMMm9ZAwZx0P9QL5yEeM6VzD0EjmloKs6v5Hc4h3FYdb4qC9HGxuLCXr
ungVML2sl0PDXym3/dfCWnT5mKN5jjDolg2QDC3zjoFCc/8LzmFAdLuVNAt5gzjN
3Cf2ihK8aNLjn2Egnx354lXscLU1fxXdPrz/Icw/UpdSdydqoh7HS0LG9ROScOMY
Jr2h60xJShQ=
=vIwY
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
