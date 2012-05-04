From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] Fix synopsis for git-tag
Date: Fri, 04 May 2012 15:19:45 +0200
Message-ID: <1336137585.3490.32.camel@beez.lab.cmartin.tk>
References: <1336136676-16510-1-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-slrkiWsXx7Z94MLn7ewB"
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Fri May 04 15:20:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQIQb-00007G-4J
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 15:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015Ab2EDNTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 09:19:48 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:38928 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756735Ab2EDNTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 09:19:47 -0400
Received: from [87.77.57.197] (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id CAC9346057;
	Fri,  4 May 2012 15:19:40 +0200 (CEST)
In-Reply-To: <1336136676-16510-1-git-send-email-vonbrand@inf.utfsm.cl>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197019>


--=-slrkiWsXx7Z94MLn7ewB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 09:04 -0400, Horst H. von Brand wrote:
> From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
>=20
> Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
> ---
>  Documentation/git-tag.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index e36a7c3..ff7fa28 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	<tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
> -	[--column[=3D<options>] | --no-column] [<pattern>...]
> +	[--column[=3D<options> | --no-column] [<pattern>...]

This removes the closing bracket for --column=3D[=3D<options]. Your text
says that --column--no-column is valid and makes the [<pattern...] part
of the continuation of --column.

How is this a fix? Why is this necessary? The subject doesn't explain
any of this.

   cmn


--=-slrkiWsXx7Z94MLn7ewB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJPo9dxAAoJEHKRP1jG7ZzTKqgH/3V4KsMM+kYl3z/8ZJ+6E+mL
EpFjUou1xaRnu0WomFL0xsCg5Nki6YF/fQtZZ1C7a9YvLfNDsZbZFO7UN5B9cdaz
pLDBSKU6Mn+f6wWNwMijnEVXj58nLLYNbyxa/TbqXHBhwSZvv/PN1GEXwnnPBUNu
AXJkKNf9QZfKSSAt/jeS8N28Fl9IbehgMZed0HAQ6zMNONhZp5I/vQyNByIJFZHK
7jpQOKyEd+bg5+UgAFf6zwF5awhHcCEkJaLnR3nKQc9RQCyBKNb12Gp9C5Ctlbc1
VYAnePBSEvKHG5v5ju9SW0paxqn6bXefrDCXIGc6PC7MyDBobQT2WtmXxotiT6A=
=uvBn
-----END PGP SIGNATURE-----

--=-slrkiWsXx7Z94MLn7ewB--
