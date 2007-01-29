From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH 1/1] Teach for-each-ref about a little language called Tcl.
Date: Mon, 29 Jan 2007 12:51:22 +0300
Message-ID: <20070129095122.GB3375@master.mivlgu.local>
References: <20070128073913.GA9915@spearce.org> <20070128094909.GA3740@procyon.home> <7v4pqaeulw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 29 10:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBTAj-0002Tz-J9
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 10:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXA2Jv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 04:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbXA2Jv2
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 04:51:28 -0500
Received: from mivlgu.ru ([81.18.140.87]:35368 "EHLO master.mivlgu.local"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750773AbXA2Jv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 04:51:28 -0500
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id BC436180113; Mon, 29 Jan 2007 12:51:22 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7v4pqaeulw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38071>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2007 at 12:58:51PM -0800, Junio C Hamano wrote:
> Then I'd commit after applying this on top of Shawn's.  Ok?
>=20
> diff --git a/quote.c b/quote.c
> index 01db5e2..fb9e4ca 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -395,11 +395,9 @@ void tcl_quote_print(FILE *stream, const char *src)
>  	fputc('"', stream);
>  	while ((c =3D *src++)) {
>  		switch (c) {
> -		case '[':
> -		case ']':
> -		case '$':
> -		case '\\':
> -		case '"':
> +		case '[': case ']':
> +		case '{': case '}':
> +		case '$': case '\\': case '"':
>  			fputc('\\', stream);
>  		default:
>  			fputc(c, stream);

Looks OK (still didn't have time to actually test this thing).

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFFvcOaW82GfkQfsqIRArfnAJ4wG7MdDO/kVDo6AHx8YyFhKk8pnACcDVA0
xRDnhGAmVq3c/PVv0Mdc7+c=
=oKDB
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
