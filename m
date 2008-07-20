From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 20 Jul 2008 22:33:06 +0200
Message-ID: <20080720203306.GO10347@genesis.frugalware.org>
References: <20080718182010.6117@nanako3.lavabit.com> <7v63r38r4r.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness> <7vabge30dh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness> <20080720130407.GF10347@genesis.frugalware.org> <7vd4l88l77.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807202102370.3305@eeepc-johanness> <7vd4l85nv5.fsf@gitster.siamese.dyndns.org> <bd6139dc0807201303u406484e2x127b2391a9920425@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vSGBLC0MgRtV7sTP"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sun Jul 20 22:34:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKfbd-0008AM-RG
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 22:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbYGTUdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 16:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYGTUdJ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 16:33:09 -0400
Received: from virgo.iok.hu ([193.202.89.103]:49292 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbYGTUdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 16:33:08 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7BF021B251E;
	Sun, 20 Jul 2008 22:33:07 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id EC92E4465E;
	Sun, 20 Jul 2008 21:53:20 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 07E70177001C; Sun, 20 Jul 2008 22:33:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd6139dc0807201303u406484e2x127b2391a9920425@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89225>


--vSGBLC0MgRtV7sTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2008 at 10:03:24PM +0200, Sverre Rabbelier <alturin@gmail.c=
om> wrote:
> On Sun, Jul 20, 2008 at 9:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> You mean something like
> >>
> >>       $ git merge -s subtree -X --path -X git-gui/ git-gui/master
> >>
> >> Wow. :-)
> >
> > I would envision it to be more like:
> >
> >        $ git merge -s subtree -Xpath=3Dgit-gui git-gui/master
>=20
> Whatever happened to quotes?
>=20
>         $ git merge -s subtree -Xpath=3D"git-gui git-gui/master"

Read again what did you wrote. ;-)

The current form is

git merge -s subtree git-gui/master, so at most it could be

        $ git merge -s subtree -Xpath=3D"git-gui" git-gui/master

--vSGBLC0MgRtV7sTP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiDoQIACgkQe81tAgORUJbO+QCfb0ZCOnQK/TEXjNcBJulzM9R0
86YAnRTcebIS7Gf3B7Vr6QPOes8j+xi1
=wH3E
-----END PGP SIGNATURE-----

--vSGBLC0MgRtV7sTP--
