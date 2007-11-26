From: Jan Hudec <bulb@ucw.cz>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 21:09:13 +0100
Message-ID: <20071126200913.GE25784@efreet.light.src>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org> <2A34D324-48A4-49EF-9D4E-5B9469A0791D@lrde.epita.fr> <20071126185600.GA25784@efreet.light.src> <85prxw253u.fsf@lola.goethe.zz> <20071126193455.GC25784@efreet.light.src> <87ve7ozsz8.fsf@graviton.dyn.troilus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Cc: David Kastrup <dak@gnu.org>, Benoit Sigoure <tsuna@lrde.epita.fr>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwkH0-0002Wm-9u
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172AbXKZUJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163AbXKZUJW
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:09:22 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:33670 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755028AbXKZUJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 15:09:21 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id DFD515765A;
	Mon, 26 Nov 2007 21:09:19 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 7M8+5OoECUm7; Mon, 26 Nov 2007 21:09:17 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1AC6457635;
	Mon, 26 Nov 2007 21:09:15 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IwkGX-0006vK-8j; Mon, 26 Nov 2007 21:09:13 +0100
Content-Disposition: inline
In-Reply-To: <87ve7ozsz8.fsf@graviton.dyn.troilus.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66107>


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2007 at 14:50:35 -0500, Michael Poole wrote:
> Jan Hudec writes:
>=20
> > The basic pull/push actions are:
> >
> > git pull: Bring the remote ref value here.
> > git push: Put the local ref value there.
> >
> > Are those not oposites?
> >
> > Than each command has it's different features on top of this -- pull me=
rges
> > and push can push multiple refs -- but in the basic operation they are
> > oposites.
>=20
> I think that is in absolute agreement with David: Ducks swim on the
> surface of the water and lobsters swim underneath.  Why consider the
> different features on top of where they swim?
>=20
> The thing about git-pull that surprises so many users is the merge.
> There's a separate command to do that step, and git-pull had a fairly
> good excuse to do the merge before git's 1.5.x remote system was in
> place, but now the only really defensible reason for its behavior is
> history.

When I first looked at hg -- and that was long before I looked at git --
I was surprised that their pull did NOT merge and you had to do a separate
step. Partly because doing those two steps is quite common.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHSyfpRel1vVwhjGURAhYpAKCykfERs45otTeR2wcu5K0OgzR88gCeIKmT
aiHPdbxyncQsCXKxLCOqU9s=
=iWqr
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
