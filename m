From: Jan Hudec <bulb@ucw.cz>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Wed, 28 Nov 2007 00:56:57 +0100
Message-ID: <20071127235657.GC9174@efreet.light.src>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org> <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com> <figlf6$d48$1@ger.gmane.org> <e5bfff550711270515t2a7bc80ege92442c30bf6aebe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:57:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxAIx-0005L7-PL
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 00:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbXK0X5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 18:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757710AbXK0X5H
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 18:57:07 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:60042 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754762AbXK0X5G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 18:57:06 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id A5D1D572C4;
	Wed, 28 Nov 2007 00:57:03 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id zW1eL7e04ZR5; Wed, 28 Nov 2007 00:57:01 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3DADD5727C;
	Wed, 28 Nov 2007 00:57:00 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IxAIU-0003Pm-0P; Wed, 28 Nov 2007 00:56:58 +0100
Content-Disposition: inline
In-Reply-To: <e5bfff550711270515t2a7bc80ege92442c30bf6aebe@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66275>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2007 at 14:15:21 +0100, Marco Costalba wrote:
> On Nov 27, 2007 9:45 AM, Andy Parkins <andyparkins@gmail.com> wrote:
> > Marco Costalba wrote:
> >
> > > But...wait...Qt would require...(I'm scared to say!)... that awful,
> > > painful, hopeless thing called C++. Probably you didn't mean what you
> > > said ;-)
> >
> > Actually although I like C++, that's not the reason, the reason is that=
 Qt
> > is a significantly (IMHO) better toolkit than Tk.  It's more cross plat=
form
> > and looks a lot nicer.  The fact that it's C++ is neither here nor ther=
e.
> >
>=20
> Actually there exist a Python bindings for Qt if you prefer.

I tried to write something in them and got a bit burned. Qt has it's
idea of memory management (delete children with parent) and the bindings
don't protect from accessing pointers to objects deleted this way, which can
cause rather hard to debug crashes.=20

Gtk seems to be much better for use from various scripting languages.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHTK7JRel1vVwhjGURArjjAJwM1N3zfnL/c0xNVzWUgSzevjqkwwCgnHvs
HACSMUb43cjHEGdmNWatCN0=
=Ny/0
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
