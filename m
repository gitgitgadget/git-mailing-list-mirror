From: Jan Hudec <bulb@ucw.cz>
Subject: Re: FFmpeg considering GIT
Date: Thu, 10 May 2007 18:52:15 +0200
Message-ID: <20070510165215.GA13060@efreet.light.src>
References: <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org> <17983.6136.147062.346626@cargo.ozlabs.ibm.com> <81b0412b0705070556o25289676i2df60ad84a2a4e13@mail.gmail.com> <e5bfff550705072330h3b59f4a5off5f9e341ccf3e7e@mail.gmail.com> <17985.19926.347089.878721@cargo.ozlabs.ibm.com> <e5bfff550705082338p1a0c003lef230f96a3219ab8@mail.gmail.com> <20070509182844.GA2982@efreet.light.src> <4c8ef70705091409g30674cb6p6d3af42eb47ffc08@mail.gmail.com> <20070509213610.GA9144@efreet.light.src> <e5bfff550705100420x63b365f7x526c1d58d9d5c761@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 18:52:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmBsa-000381-Bl
	for gcvg-git@gmane.org; Thu, 10 May 2007 18:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbXEJQwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 12:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbXEJQwb
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 12:52:31 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:4135 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751642AbXEJQwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 12:52:30 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.159274;
	Thu, 10 May 2007 18:52:20 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HmBsF-0003Qr-5y; Thu, 10 May 2007 18:52:15 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550705100420x63b365f7x526c1d58d9d5c761@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46877>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2007 at 13:20:02 +0200, Marco Costalba wrote:
> On 5/9/07, Jan Hudec <bulb@ucw.cz> wrote:
> >On Wed, May 09, 2007 at 23:09:25 +0200, Fredrik Kuivinen wrote:
> >> I have used PyQt for some smaller projects (notably Hgct, a no longer
> >> developed
> >> commit tool for git and Mercurial. See
> >> http://repo.or.cz/w/hgct.git?a=3Dtree). For me
> >> PyQt has worked very well. The python interface to Qt is more or less a
> >> direct
> >> translation of the C++ interface, so the excellent documentation troll
> >> tech provides
> >> for Qt can be used when developing with PyQt as well.
> >>
> >> I have never seen the segfaulting you mention. Maybe my programs have=
=20
> >been
> >> too
> >> small to trigger that bug...
> >
> >It's not about size of the programs. It's about having to be careful not=
 to
> >refer to widgets inside eg. dialog box from outside and close that dialog
> >box.
>=20
> In Qt all the classes that ineriths from QObject are memory managed,
> to be more clear
> you can say that one class is "child" of another class (always
> ineritherd from QObject) that becames the parent.
>=20
> When you delete the parent, all his children are deleted too, this is
> a (big) feature to avoid
> missing free() calls for resources created with mallocs() , (well, in
> C++ we say 'delete' for resources created by 'new' but the concept is
> more or less the same).

I know well how it works. And while it is definitely a nice feature in C++
(though it can't beat well done reference-counting smart pointers as Gtkmm
has), it is a gross misfeature in any dynamic language.

And no, I am not objecting to existence of that system -- it's useful in C+=
+.
What I say is, that the PyQt bindings are buggy because it completely
fails to make this feature compatible with python memory management - python
program should not be able to segfault the interpreter no matter how buggy
that program is.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQ02/Rel1vVwhjGURAimaAJ497XwBCplP//bz0J7sxoWNFbBDIgCbBlih
VvuxndxaFWvucvZYG2NMtAI=
=RQc0
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
