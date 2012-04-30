From: Pierre Thierry <pierre@nothos.net>
Subject: Re: Location-agnostic submodules
Date: Tue, 1 May 2012 00:02:44 +0200
Message-ID: <20120430220244.GL22827@pape.arcanes.fr.eu.org>
References: <20120427143710.GA13953@pape.arcanes.fr.eu.org>
 <CABURp0qA9hK1fBd3rmLG61ErpbbzrcxO=AAmFOsoxjt=ozu09Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YqkpBxMMfeZoT90/"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 00:02:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOygI-0002Dl-0g
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab2D3WCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 18:02:49 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:32512 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2D3WCt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:02:49 -0400
Received: from pthierry.pck.nerim.net ([81.51.1.181])
	by mwinf5d14 with ME
	id 4N2l1j0013uK2zV03N2lLx; Tue, 01 May 2012 00:02:46 +0200
Received: by pthierry.pck.nerim.net (Postfix, from userid 1000)
	id D9C0C1800FC; Tue,  1 May 2012 00:02:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CABURp0qA9hK1fBd3rmLG61ErpbbzrcxO=AAmFOsoxjt=ozu09Q@mail.gmail.com>
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196614>


--YqkpBxMMfeZoT90/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Scribit Phil Hord dies 30/04/2012 hora 16:39:
> Maybe something like this:
>     [submodule "foo"]
>         path =3D foo-mod
>         url =3D ../foo ../foo-alternate
> https://someplace.com/git/foo.git  https://kernel.org/git/foo

<rant>That is typically the kind of occasion when I wish every config
file were sexprs...</rant>

> But if one of them lags behind the others by a day or even an hour,
> then you may have gitlinks in your superproject which have not made
> it into the lagging mirror yet.  And this will cause problems.

I see your point, but what if your only repository is lagging behind?
I.e. in what way is it worse than now?

> Moreover, each time you clone the repository you may get different
> results.  This would be confusing.

Again, I fail to see the difference with the current state. If the
commit is specified, you will always get the same results, now or with
my suggested addition.

> I don't think there is any need for a new 'clone' command since the
> clone porcelain already understands submodules.

What do you mean? When I clone a repo with submodules, they are not
cloned as well.

--=20
pierre@nothos.net
OpenPGP 0xD9D50D8A

--YqkpBxMMfeZoT90/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+fDAQACgkQxe13INnVDYos1gCgmuwRicHpRAloHpLyXWT/KFwi
XiQAoPL+GZnZjNM7m28Hcqbb34iGcavK
=WNNw
-----END PGP SIGNATURE-----

--YqkpBxMMfeZoT90/--
