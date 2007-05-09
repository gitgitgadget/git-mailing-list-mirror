From: Jan Hudec <bulb@ucw.cz>
Subject: Re: FFmpeg considering GIT
Date: Wed, 9 May 2007 20:28:44 +0200
Message-ID: <20070509182844.GA2982@efreet.light.src>
References: <87y7k4lahq.wl%cworth@cworth.org> <20070505133543.GC3379@diana.vm.bytemark.co.uk> <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org> <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org> <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org> <17983.6136.147062.346626@cargo.ozlabs.ibm.com> <81b0412b0705070556o25289676i2df60ad84a2a4e13@mail.gmail.com> <e5bfff550705072330h3b59f4a5off5f9e341ccf3e7e@mail.gmail.com> <17985.19926.347089.878721@cargo.ozlabs.ibm.com> <e5bfff550705082338p1a0c003lef230f96a3219ab8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Cc: Paul Mackerras <paulus@samba.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 20:29:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlqui-0005Cw-Jf
	for gcvg-git@gmane.org; Wed, 09 May 2007 20:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672AbXEIS3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 14:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756699AbXEIS3T
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 14:29:19 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:2697 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756672AbXEIS3S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 14:29:18 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.116270;
	Wed, 09 May 2007 20:28:52 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hlqu4-0001sb-BJ; Wed, 09 May 2007 20:28:44 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550705082338p1a0c003lef230f96a3219ab8@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46763>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2007 at 08:38:48 +0200, Marco Costalba wrote:
> On 5/9/07, Paul Mackerras <paulus@samba.org> wrote:
> >Marco Costalba writes:
> >
> >> Language to use is C++, not C (much more powerful IMHO)
> >
> >Sorry, C++ is not an option because I dislike it so much.
>=20
> Well, speaking about GUI applications, the 90% is in the graphic
> library and only in small part in the language. With Qt we are at 95%
>=20
> Anyhow does exist also python bindings for Qt.

Tried them, beed deeply disapointed. Qt always destroys all child objects
with the parent, which is OK in C++, but does not play well with
garbage-collection. And the python bindings (ruby ones seem to be better)
fail to check reference validity, so you can quite easily segfault the pyth=
on
interpreter. Gtk plays much better with dynamic languages.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQhLcRel1vVwhjGURAi1BAJ0bCsEWYDUp/CQt2g6SSEkBuJDBiwCfREsP
PWA9ZZ/2LGnojC+o9szCbLg=
=5N43
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
