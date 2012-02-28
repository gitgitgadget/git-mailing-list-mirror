From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] Documentation: use {asterisk} in rev-list-options.txt
 when needed
Date: Tue, 28 Feb 2012 21:20:23 +0100
Message-ID: <1330460423.691.15.camel@centaur.lab.cmartin.tk>
References: <1330443348-5742-1-git-send-email-cmn@elego.de>
	 <20120228194551.GC11725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-8RTBjSvlCzEw7+fVx0Yl"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 28 21:20:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2TWj-0004Ik-M5
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 21:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953Ab2B1UT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 15:19:57 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:55578 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964788Ab2B1UT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 15:19:56 -0500
Received: from [192.168.1.17] (brln-4db9f055.pool.mediaWays.net [77.185.240.85])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 6E41B46057;
	Tue, 28 Feb 2012 21:19:49 +0100 (CET)
In-Reply-To: <20120228194551.GC11725@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191781>


--=-8RTBjSvlCzEw7+fVx0Yl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-28 at 14:45 -0500, Jeff King wrote:
> On Tue, Feb 28, 2012 at 04:35:48PM +0100, Carlos Mart=C3=ADn Nieto wrote:
>=20
> > Text between to '*' is emphasized in AsciiDoc which made the
>=20
> s/to/two/

Oops. Thanks. Can you squash that in, Junio?

>=20
> > glob-related explanations in rev-list-options.txt very confusing, as
> > the rendered text would be missing two asterisks and the text between
> > them would be emphasized instead.
> >=20
> > Use '{asterisk}' where needed to make them show up as asterisks in the
> > rendered text.
> > [...]
> > -	'*', or '[', '/*' at the end is implied.
> > +	'{asterisk}', or '[', '/{asterisk}' at the end is implied.
>=20
> Ugh. I hate asciidoc more with each passing year. Readable source
> documents are such a wonderful idea, but the markup makes it less and
> less readable as we accumulate fixes like this.  I wonder if this has
> always been a bug, or something that appeared in more recent versions of
> the toolchain.

The generated documentation in the 'html' branch shows the wrong
formatting as well even for 1.7.0 when the --glob feature and its
explanation was first introduced. So either nobody reads the
documentation or very few people actually care about --glob and use the
--remotes and friends, where that part of the explanation isn't that
interesting.

   cmn



--=-8RTBjSvlCzEw7+fVx0Yl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPTTcHAAoJEHKRP1jG7ZzTKKoIAJPew+4QGhbz6hb/LghPKISF
EDn1JTGfancigwSRHmpgu1vwRhDlLsVvRJpGSiwudnGV1kc0i0topUmd1GI/dlf2
6lZ7ITIZ7g55QWjZRrsN7o+CtL8vQj/rSACG1XUCyCPJqdLzpSzbsJ2wHcXcezy8
XlWaLRqx+P5H8wrgEpoQIw8iJExUHRL7W/mtNs7+hzlyXbUaVwvhvrBES4HDyllK
/VW9C+G+wDa9hajrLgTrSQ/Qs1QulfNaJENv5b5CixF19DYlPN9LobHziEQxVtA5
FTcL5+9PTNirQ99bQLKglg8uwyYxQKf6PibJU/iAD3I/XnOaGyGhbjPPPLfFx1Q=
=6ACt
-----END PGP SIGNATURE-----

--=-8RTBjSvlCzEw7+fVx0Yl--
