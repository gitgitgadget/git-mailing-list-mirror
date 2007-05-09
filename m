From: Jan Hudec <bulb@ucw.cz>
Subject: Re: FFmpeg considering GIT
Date: Wed, 9 May 2007 23:36:10 +0200
Message-ID: <20070509213610.GA9144@efreet.light.src>
References: <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org> <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org> <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org> <17983.6136.147062.346626@cargo.ozlabs.ibm.com> <81b0412b0705070556o25289676i2df60ad84a2a4e13@mail.gmail.com> <e5bfff550705072330h3b59f4a5off5f9e341ccf3e7e@mail.gmail.com> <17985.19926.347089.878721@cargo.ozlabs.ibm.com> <e5bfff550705082338p1a0c003lef230f96a3219ab8@mail.gmail.com> <20070509182844.GA2982@efreet.light.src> <4c8ef70705091409g30674cb6p6d3af42eb47ffc08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Cc: Marco Costalba <mcostalba@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 23:36:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hltpt-0000Zn-GB
	for gcvg-git@gmane.org; Wed, 09 May 2007 23:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbXEIVgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754198AbXEIVgb
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 17:36:31 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:3724 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753148AbXEIVga (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 17:36:30 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.118903;
	Wed, 09 May 2007 23:36:11 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HltpS-0002O1-QS; Wed, 09 May 2007 23:36:10 +0200
Content-Disposition: inline
In-Reply-To: <4c8ef70705091409g30674cb6p6d3af42eb47ffc08@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46792>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2007 at 23:09:25 +0200, Fredrik Kuivinen wrote:
> I have used PyQt for some smaller projects (notably Hgct, a no longer=20
> developed
> commit tool for git and Mercurial. See
> http://repo.or.cz/w/hgct.git?a=3Dtree). For me
> PyQt has worked very well. The python interface to Qt is more or less a=
=20
> direct
> translation of the C++ interface, so the excellent documentation troll
> tech provides
> for Qt can be used when developing with PyQt as well.
>=20
> I have never seen the segfaulting you mention. Maybe my programs have bee=
n=20
> too
> small to trigger that bug...

It's not about size of the programs. It's about having to be careful not to
refer to widgets inside eg. dialog box from outside and close that dialog
box. That is having to be careful about something, that is normal in C++, b=
ut
what you normally expect python to handle for you. And such quirks of the
bindings are completely undocumented.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQj7KRel1vVwhjGURApqkAJsH29DKGL8MYi/xJGGA6f5XgloR0ACgudiP
wfDfjfhYHc3WeIjJWLblqtQ=
=m0DZ
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
