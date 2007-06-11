From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [Qgit RFC] commit --amend
Date: Mon, 11 Jun 2007 06:42:58 +0200
Message-ID: <20070611044258.GJ4084@efreet.light.src>
References: <20070610150839.GG4084@efreet.light.src> <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 06:43:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxbkB-0007hd-OR
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 06:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbXFKEnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 00:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbXFKEnF
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 00:43:05 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:49758 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbXFKEnE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 00:43:04 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5BD6C577A6;
	Mon, 11 Jun 2007 06:43:01 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hxbk2-00067S-O6; Mon, 11 Jun 2007 06:42:58 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49816>


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2007 at 00:10:20 +0200, Marco Costalba wrote:
> On 6/10/07, Jan Hudec <bulb@ucw.cz> wrote:
> >Hello,
> >
> >I am thinking about adding commit --amend support to Qgit.
> >
>=20
> Good!
>=20
> > - Add a separate action to the menu. This action would take over the=20
> > refresh
> >   (Add to top) operation when using stgit.
> >
> >   I believe this has lower risk of user errors than the previous option=
=2E=20
> >   It
> >   also has the advantage, that I don't have to touch the disabling logi=
c=20
> >   for
> >   the commit action. Amending last commit is always possible, even if=
=20
> >   there
> >   are no changes, because you might want to edit the message (eg. if you
> >   forget to sign-off or forget to mention some change or something).
> >
>=20
> Yes. But amending is an option of commit (also in git) so probably the
> amend action will fire the commit dialog anyway and we are back to
> previous situation. The only advantage is that we can load the message
> of the tip revision as default instead of git-status output as the
> current.
>=20
>=20
> >I'll try doing the first option now, unless somebody persuades me that i=
t's
> >a nonsense.
> >
>=20
> I think it's the best: 'Sync' button is very seldom used (I think I've
> never used it but for testing that it works) and updating the index is
> something very plumbing anyway.
>=20
> What we could add is another button 'Load prev msg' to do what it
> says, so we would end up with 5 buttons:
>=20
> - Settings /Cancel/ Load prev msg / Amend /Commit
>=20
> I don't see a reason to set 'Load prev msg' as a check button, you may
> want to reload the prev msg as many times as you need, (re)clicking
> everytime on the button, also for a normal commit where as example you
> want to keep the header or part of the subject of the previous
> revision.

I think it would be somewhat complicated unfortunately :-(. The loading of
previous message should be really tied to whether you are about to
amend/refresh or to commit/add new. In this respect this would actually mat=
ch
the command-line interface, because you say whether you want to amend
*before* you edit the message.

So I am now inclined more to the separate action and trying to go that way.
But the difference between the variants would not be that big.

> Please let me know if and where you find something obscure/messy with
> the code, I will be happy to help you.

I think I mostly understood it now. Thank you.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGbNLSRel1vVwhjGURAioHAJwN82t3FMWknr8k26GPEGkWByecMACfYnix
iJDKZp6oeUKz+33KhpRVxGs=
=ChRi
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--
