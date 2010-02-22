From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 10:49:05 +0100
Message-ID: <1266832145.31769.29.camel@ganieda>
References: <1266599485.29753.54.camel@ganieda> <4B821202.8070700@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-6h4t1upgx7LlvRPdDW8+"
Cc: git <git@vger.kernel.org>
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:43:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjUun-0002UI-9Y
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 10:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab0BVJtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 04:49:11 -0500
Received: from gwenhwyvar.vernstok.nl ([92.243.4.181]:43849 "EHLO
	gwenhwyvar.vernstok.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab0BVJtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 04:49:10 -0500
Received: from ganieda (localhost [127.0.0.1])
	by gwenhwyvar.vernstok.nl (Postfix) with ESMTP id 1D4A9265F8;
	Mon, 22 Feb 2010 09:50:35 +0000 (UTC)
Received: by ganieda (Postfix, from userid 1000)
	id AEDF514EC85; Mon, 22 Feb 2010 10:49:06 +0100 (CET)
In-Reply-To: <4B821202.8070700@gmail.com>
X-Mailer: Evolution 2.28.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140656>


--=-6h4t1upgx7LlvRPdDW8+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-02-22 at 00:11 -0500, Gabriel Filion wrote:
> On 2010-02-19 12:11, Jelmer Vernooij wrote:
> > To allow round-tripping pushes from Bazaar into Git, I'm looking for a
> > good place to store Bazaar semantics that can not be represented in Git
> > at the moment. This data should ideally be hidden from the user as much
> > as possible; it would e.g. contain mappings from git hashes to Bazaar
> > ids.=20
> What are you currently using for interacting with Bazaar repositories?
It's the other way around :-) I'm the developer of the bzr-git plugin,
which allows Bazaar to be used with Git repositories.=20

> If you already have code for a remote helper, I would be interested in
> helping you out. I started a discussion recently on this list about
> staring such a script. Would you be willing to collaborate on having
> this implemented?
I'm happy to discuss a remote helper for Bazaar in Git, but not
particularly interested in contributing.

Cheers,

Jelmer

--=-6h4t1upgx7LlvRPdDW8+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJLglMGAAoJEACAbyvXKaRX+KEP/1MrPqwKAwJc7sakVlkq6mBY
k/ve7VZKyXuw3GvwM/avYnm2G74rX+9mXBzj2KfzoX+0ZDZPhzYOMEY0swbFVMDc
N6cD9NEE7ec38/aVd1wYRAZzEP250iHDqRA28xp1PRzwhn2QIhk3r6nJdKOaPnrw
2H/xWiszUg4Po/vWZYU4vKU5CefFjBr67bbdmm29/1j0hrT/UN6QMFGILt0yI2qL
kevkitTCjyytCOs8Cmd5bZT4myyxY+gtvQkmcoFHM3UuZHnOAeapSOae9HvkeDze
P/3bZCR61png+dtPy8AOyc1fmEnysI6T4XBjCqDO3JN5CveFzB2EHUroK6TCrPSr
GiLfpoM1z8XwBGJAtbZbB8INMUOO/fxp3giVa78XYq0pbxZr2YyeRbuQqocv3POH
dnoE57untQMdOhmfAAiTRr3OtXvmqtzSNeoFM504917wI/ETyujii1g6C4bg94Bt
SdkbDmjYLSdhwXYG5AOoyB28c6iY+tnRHmSWH+c6QpVjYxDIQoRqhoQW5jy5j8qs
49q0O9cKXL15ouTgSW38mV9364gWQeGFfokucFaLaZaxFpkdxyqo2OfocbJHNvYy
z0QAwNMkcOYLiggrpV4fgkoH4bYLvzk3ilngwXeJLGVkesJ60/it+J3EG39X4ou+
AQUh965wpvuGrs8Nt5xA
=9flE
-----END PGP SIGNATURE-----

--=-6h4t1upgx7LlvRPdDW8+--
