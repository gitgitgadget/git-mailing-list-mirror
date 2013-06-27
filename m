From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Thu, 27 Jun 2013 16:10:32 -0400
Message-ID: <20130627201032.GF9999@odin.tremily.us>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
 <20130523102959.GP9448@inner.h.apk.li> <20130523110839.GT27005@serenity.lan>
 <7vd2shheic.fsf@alter.siamese.dyndns.org>
 <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=GV0iVqYguTV4Q9ER
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 23:11:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsJTF-0002ob-86
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 23:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab3F0VLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 17:11:08 -0400
Received: from vms173005pub.verizon.net ([206.46.173.5]:20347 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab3F0VLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 17:11:07 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2013 17:11:07 EDT
Received: from odin.tremily.us ([unknown] [72.68.87.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MP200BJYIPKP260@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 27 Jun 2013 15:10:35 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id ADCD8A543DF; Thu,
 27 Jun 2013 16:10:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1372363832; bh=+T9Cv5gKdEJwIm/1CoZ3+5/SZ5qL7x01MqEW6435pd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IEZgPjcJP2prI2iuMTTYauh6EOPZvcveTUoEJd26FaU+AsTVLC4KQDk17expMB4Kx
 OFA7lI644j+sewlmj91t7wOb3KwAVmQ5S9BR9WOdc5WOIbKofznwP9EkpaXZ48R0WS
 HKLIDmB7NFyVluOh6RmbIcFCAv6BMQ7CPik7mGZA=
Content-disposition: inline
In-reply-to: <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229160>


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
> Because letting a trivial merge automatically handled by Git is so
> easy with "git pull", a person who is new to Git may not realize
> that the project s/he is interacting with may prefer "rebase"
> workflow.

Or they may not even realize that they've just merged an unrelated
branch at all, dragging in a thousand unrelated commits which they
accidentally push to a central repository without looking,
contaminating future branches based on the central repostitory without
drastic rebase surgery ;).  I just saw one of these earlier this week.

>  * This is not a serious inclusion proposal yet, but to see if
>    people are still interested in possibly helping new users.

What needs to happen to make it serious?  I'm happy to help.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRzJw3AAoJEKKfehoaNkbt1qcP/11QsZ8pWgT4RVf5S5+AzgDi
X36bQ+TK/QE6rxH/+zO/qWnMR7x3HOyeUzkruLfVDrykamc3/SFcgd5qPrXjymG/
e6o1IN72Idd32bbJQd8DUIDeYJhZlQChS226PflrDY0J7WNHHFS26ehd2BVi/Iao
HvjGvsYU3XlDx86E+8wlsMp/v+9Ob1ezPjX5/BznZ9Hy+V4KKxN6XUDpr/ecDwrM
ZiSORcVIpFzFUBAawKYzRy+Z6gON/ThmcPjYLeMmDGf+/gN66MqgZnhP2wqrYj1a
9RdbgBcWuO5GRLFzfFmIcHC2ORhxCMQzKe8nnOTWQCFgwI3LpJCMxTr+2vDmkwWU
5NRajzVTs+pHhMYG/uPXuMt8EWXVPxwzyTgVH/kszOffJKdgELZNBvhSOnnS+h62
GHVTgn58/lTNWoVnbmBcehitG5zXCI8iZtsk6rATGflQkv6XUEh7jwcWabvBviu7
wZ9ol1qB3h3KprYkiCdwB42/WDdw5ksC/qXo0OVxpt5ft54xVAx/ZSIl+B3enDzd
3Ctfhfcd5Do1bDlbPnSdUxM4/2Ah5IXEasQRGnjYRpj4zzbJp4XbLoYrw9BfjzXS
BdVz7OJLjRgVmueKhLVKH2TxDwpGXfrmnM/CvziPI8Cuia4ubKynepQVc3PZShn4
7JJoMDD/ckEEKMwDJVU8
=e8+B
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--
