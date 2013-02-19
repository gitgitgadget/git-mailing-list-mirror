From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [PATCH v3 8/9] user-manual: Flesh out uncommitted
 changes and submodule updates
Date: Tue, 19 Feb 2013 04:35:24 -0500
Message-ID: <20130219093524.GB4024@odin.tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <6219cb47a0a5b7428ae6c729e9a1a55344f47428.1361146398.git.wking@tremily.us>
 <7vfw0ucoxk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 10:36:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7jcK-0005YG-P9
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758447Ab3BSJfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 04:35:41 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:41077 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669Ab3BSJfj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 04:35:39 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIG007OTNZ01Q60@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 19 Feb 2013 03:35:25 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 3D69E8AB931; Tue,
 19 Feb 2013 04:35:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361266524; bh=oq4yLIeJQPdHlkKvy2StES2+BDCFQlHt8CpRJUEYMJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KtWwATGEESfhsyZK0VKj7f98xBAajGHU1sY46YG4s45XzFyHqNnDv5IQ1cVpemtf4
 gmWYdTpQgZ1eBoqgZFyaACsEuLhQwrzotFdRiVk/QMAG7AzD8gy6IcqCs+rHCEGtjx
 /PzP5sbJPRk0u/UwWzUI+c6Lr/yBTeAeQD0iskaE=
Content-disposition: inline
In-reply-to: <7vfw0ucoxk.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216583>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 17, 2013 at 06:53:59PM -0800, Junio C Hamano wrote:
> > +If you did not commit your submodule changes, the changes will *not*
> > +be silently overwritten.  Instead, you get the usual warning about not
> > +being able switch from a dirty branch.
>=20
> The scenario this talks about is to commit changes in the
> superproject and then to run "submodule update".  I think the above
> clarification is still incomplete.  You may have committed in the
> submodule some changes but not all.
>=20
> 	If you have uncommitted changes in your submodule working
> 	tree, "git submodule update" will not overwrite them.
> 	Instead...
>=20
> would be an improvement, I think.

Will do in v4.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRI0dbAAoJEEUbTsx0l5OMN8YP/1L+EqI3LfiT67w6HLipCnnq
5H4CifZIQXavpbR6nGUl/jFRdPs53Z5X3fSaq6fEY3asvPO9GpI9uy3PvP2J8BnD
YmxyOUb3hiHKzRDv4m7kDbnm4oGvi4yOv89Y+ZS3ofJrLTs94CWltHoJtoeVrG+l
CsPTJn8GX+K9JleoOXWO4gv1ZSRIgdLM4b7A9IvFiZGixlEPYKtaPDgiypnwQCPs
ueauijdSrdOJ+vPMSPTKHwaeWFjp75n+5Wpwz2h08yROogC6Yi/J/jvRXD+qlUOQ
to5ClhN2GCSRYE/H6ElSS3nyuKrA/j3NpXQhKKKgwZWjJgL35R1xqoep4dEBQa9M
Bg+aXxsqQzTINs3qPkfC/vpam+dqbpwdQ0CvwLxZZqZzUy8MX4Ahc/ZCtVvrSAkg
YTOnOUNc0VUatKswDbtut+RZrK88PY1I1S6zLahRtewifAj9BNHCXRtX9GyUl7pY
1k2GnkjUzJypQ7ZR2X7Yvct0jqUzKIzvTxtAWrHtj/uJ9rI3egLFnk1T+PrhdYJM
p+QjExJmlLOV7+VpbaK6zuBjRlOyas81v/ISnmRX9J45Zk0js0oZXuBRLdjhpD2C
dL/Cfme+ej5ogoWP1RTxmQkVJaeR5zDpy0lsJSh/76V4dUg8ILUNYlcqcHZV1Ebs
Xqx9TGH8RfF0VCiEGjM+
=WZhS
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
