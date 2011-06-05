From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>
Subject: Re: git show and the --quiet option
Date: Mon, 6 Jun 2011 01:13:30 +0200
Message-ID: <20110605231330.GB30081@centaur.lab.cmartin.tk>
References: <4DE12888.1040506@isy.liu.se>
 <20110528172611.GB28708@centaur.lab.cmartin.tk>
 <7vhb8eprcb.fsf@alter.siamese.dyndns.org>
 <20110530093259.GA2990@bee.lab.cmartin.tk>
 <1307039169.28941.35.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Junio C Hamano <gitster@pobox.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Mon Jun 06 01:13:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTMVm-0004HF-6A
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 01:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756507Ab1FEXNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 19:13:32 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:57923 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505Ab1FEXNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 19:13:32 -0400
Received: from centaur.lab.cmartin.tk (brln-4d0c238c.pool.mediaWays.net [77.12.35.140])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 5C72D461E0;
	Mon,  6 Jun 2011 01:13:01 +0200 (CEST)
Received: (nullmailer pid 20497 invoked by uid 1000);
	Sun, 05 Jun 2011 23:13:31 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>,
	Drew Northup <drew.northup@maine.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Junio C Hamano <gitster@pobox.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1307039169.28941.35.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175086>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2011 at 02:26:09PM -0400, Drew Northup wrote:
>=20
> On Mon, 2011-05-30 at 11:32 +0200, Carlos Mart=C3=ADn Nieto wrote:
> > On Sat, May 28, 2011 at 12:17:40PM -0700, Junio C Hamano wrote:
> > > Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> > >=20
>=20
> > > How does this patch look?
> > >=20
> > > It does not fix "git show master~10 master^..master", but instead of =
just
> > > hijacking and ignoring the --quiet option like your patch did, it act=
ually
> > > flips the option the user wanted to affect from the command line.
> >=20
> > It's fine if that's what we want to do. The reason I blocked --quiet
> > instead of converting it to -s is because it seemed less surprising
> > than passing --quiet and still getting output (if I pass --quiet, I'd
> > expect the application to really be quiet), which doesn't happen in
> > the commands that accept --quiet on purpose. Then again, the log
> > family doesn't make any sense without any output, so if you argue that
> > way, --quiet means "quieter", which makes the interface less
> > consistent, but I don't feel that strongly about it
>=20
> There's a lot of stuff out there for which --quiet does not imply
> --silent. I side with Junio on the solution.

Then don't let me stop you.

   cmn
--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN7A2aAAoJEHKRP1jG7ZzTDMQIAIfNqgURkRHN9/AxmnQdeBmG
s6NxWMo2t9ZN9t6p09Q1+cRaMyzVidFon9KCEUcF5OvGRm62Ia5Z+PKTp+072+1D
GiQF1C5D9vdzjibMhHnOvMcMxjZj9CFJGtfoA4qTjikaLxwGOrFB838S/I/vorrU
gjIAo++MVTNQ43LpF/68ZAZaTyS0tyCfM0TGf3wR4VNdM/oHW5RwQNte1vnY6jHy
KH/HwrA+qY6OBPoodvi3lsyu62xGjgACMukdkpkvICKnfR2kzm8UEZnDm9ObWU3L
XmMSuAwlljpXu5Shoh96UeHI4qq//2dJ3HL9RgELy25uS85f9ZGPaQDs7e1WCLA=
=MZFB
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
