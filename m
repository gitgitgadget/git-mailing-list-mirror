From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Thu, 21 Nov 2013 12:04:26 -0400
Message-ID: <20131121160426.GA21843@kitenet.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 17:04:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjWkC-00037g-Pa
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 17:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab3KUQEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 11:04:36 -0500
Received: from wren.kitenet.net ([80.68.85.49]:58465 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab3KUQEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 11:04:35 -0500
Received: by darkstar.kitenet.net (Postfix, from userid 1000)
	id D0C8E305E9E; Thu, 21 Nov 2013 11:04:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20131121114157.GA7171@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238128>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> This latter behavior is much worse for two reasons. One,
> git reports an allocation error when the real error is
> corruption. And two, the program dies unconditionally, so
> you cannot even run fsck (which would otherwise ignore the
> broken object and keep going).

BTW, I've also seen git cat-file --batch report wrong sizes for objects,
sometimes without crashing. This is particularly problimatic because if
the object size is wrong, it's very hard to detect the actual end of the
object output in the batch mode stream.

--=20
see shy jo

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUBUo4vCMkQ2SIlEuPHAQgY0A//f6KkBHPkEUgFmYrFzuYJ6kUf28prsj39
RrWc43XFZo7b9xR1eEK5VZs4deUEhNlZt8MSHQzBudOylQ+3nTERdbsyq1mn0d3x
hDLtJG2G8OBYLu+0B1l6SY0yGkGxI67KultRxzjVqy/moeRrQkNlB0KxVDcpuM/S
aSGelGgUetQnrSiYpM2NHtJJ5Tg7mKWwFAALNz+5Rg8PQi9HIL0nWqmAaQFP12E9
6VHE4qkLFzTebknyC1t7DG1sSgK03S/A4aNkBeWr1d32S4zpLyH1KcbHrSIoY/KR
7bSNhPP2krCZTLbbz70cF/xYgHboD6GWlFu5GkIAPShuYOQUn83PhfLX6e2aufob
iAm++a77T/zZtHYpKKs5wj4dgsNBFpNsu8vuXeESMSKMLEwjJNrOjHXl+arTR+gD
+i46h9MqovAql44e9n3fAu2DBighE1nn9T35TobbxsBN7cGgc7dxBjXbyeIazb7B
k6Er5iMAinFojF4ZvsoGBwo83kqZkZ2R3on9zjVFjok0IsF/eQG2iERkWNzGcgj9
M3XhpJxn+pGOa+cI4xJSH73QSa46bFpkfgI8hfceglz1LKMXULUH2cm7TWtpJ23q
NdPmZ6Eo5VCbPS7w4gd1QjnL5+9hQXReVKQIWCx18Vw8+YBWxmqB/SicoNDA7R70
e8tyPtkXdWE=
=qfur
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
