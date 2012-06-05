From: Kevin Stange <kevin@steadfast.net>
Subject: Re: [RFC] Deal with HTTP 401 by requesting credentials.
Date: Tue, 05 Jun 2012 11:41:37 -0500
Message-ID: <4FCE36C1.3010807@steadfast.net>
References: <4FC7EFB7.4090704@steadfast.net> <20120601083537.GA32340@sigill.intra.peff.net> <4FC8F590.2070308@steadfast.net> <20120605162824.GB20915@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig46E5D2A801C1A33B4A50EEA6"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:41:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbwpD-0008Lj-MR
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 18:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab2FEQlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 12:41:40 -0400
Received: from staffmx.steadfast.net ([67.202.100.6]:44110 "EHLO
	staffmx.steadfast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab2FEQlj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 12:41:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by staffmx.steadfast.net (Postfix) with ESMTP id 9C4C616AC09E;
	Tue,  5 Jun 2012 11:41:38 -0500 (CDT)
X-Virus-Scanned: amavisd-new at steadfast.net
Received: from staffmx.steadfast.net ([127.0.0.1])
	by localhost (staffmx.steadfast.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-ZOen4MJQ2c; Tue,  5 Jun 2012 11:41:38 -0500 (CDT)
Received: from ziyal.office.steadfast.net (unknown [IPv6:2607:f128:0:1:222:4dff:fe51:2ed5])
	by staffmx.steadfast.net (Postfix) with ESMTPSA id 0147016AC09D;
	Tue,  5 Jun 2012 11:41:38 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120605162824.GB20915@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199260>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46E5D2A801C1A33B4A50EEA6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/05/2012 11:28 AM, Jeff King wrote:
> On Fri, Jun 01, 2012 at 12:02:08PM -0500, Kevin Stange wrote:
>=20
>>> The dumb-http push code is the only thing that does not go through
>>> http_request these days. So another option would be to refactor it to=
 go
>>> through that central point. I took a brief look at this when I was
>>> updating the credential code a few months ago, but didn't consider it=
 a
>>> priority, as most people should be using smart http these days. Is th=
ere
>>> a reason you can't use smart-http? It's significantly more efficient.=

>>
>> Smart HTTP didn't come up in any of my Google searches.  With that as =
an
>> option, I might just drop this work now.  I'd rather see incomplete me=
thods
>> that aren't recommended go away than further facilitate their use, per=
sonally.
>=20
> Me too. I would love it if dumb http push just went away. It's extremel=
y
> neglected, and has very few advantages over smart http (really, the onl=
y
> advantage is that the server does not need to run git). However, we do
> get bug reports on it occasionally, so I think people are still using
> it.
>=20
> So far our approach has mostly been to prevent any serious regressions,=

> and otherwise not worry too much about dragging it along with new
> features.

It seemed a lot of "guides" that I found while searching suggested using =
the
"dumb" system.  That may be why it remains in use.  I can't imagine too m=
any
people have issues running a CGI to ensure everything works right.

>> If I decide to continue working on this, I will keep these in mind.  I=
'm
>> pretty sure that if I can get smart HTTP working, there's no reason to=
 even
>> bother with this from my perspective, unless you think there's substan=
tial
>> value in it.
>=20
> No, I don't think there's substantial value. If you can move to smart
> http, you are much better off.

I've gotten smart HTTP working perfectly.  Thank you for pointing me to i=
t.  I
am considering this resolved.

--=20
Kevin Stange
Chief Technology Officer
Steadfast Networks
http://steadfast.net
Phone: 312-602-2689 ext. 203 | Fax: 312-602-2688 | Cell: 312-320-5867


--------------enig46E5D2A801C1A33B4A50EEA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/ONsEACgkQkd/BoeKjg0iLtwCgiKloaKzUFBQTeIP2+39vXnTY
TsIAnjxcZG3PQSxkUjQD3DOyTfFiJgdp
=yOit
-----END PGP SIGNATURE-----

--------------enig46E5D2A801C1A33B4A50EEA6--
