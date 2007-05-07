From: Jan Hudec <bulb@ucw.cz>
Subject: Re: FFmpeg considering GIT
Date: Mon, 7 May 2007 19:52:22 +0200
Message-ID: <20070507175222.GA13927@efreet.light.src>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org> <20070505133543.GC3379@diana.vm.bytemark.co.uk> <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org> <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org> <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org> <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 07 20:07:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl7ca-0005tP-9D
	for gcvg-git@gmane.org; Mon, 07 May 2007 20:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966120AbXEGSHg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 14:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966117AbXEGSHf
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 14:07:35 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:1728 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S966120AbXEGSHe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 14:07:34 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 May 2007 14:07:34 EDT
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.61134;
	Mon, 07 May 2007 19:52:23 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hl7Nm-0005ts-Qy; Mon, 07 May 2007 19:52:22 +0200
Content-Disposition: inline
In-Reply-To: <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46475>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2007 at 22:13:44 +1000, Paul Mackerras wrote:
> Linus Torvalds writes:
>=20
> > Finally, it realy _should_ check that the first 7 characters of the com=
mit=20
> > log (the ones it ignores by just asking for substring 7..) are actually=
=20
> > the exact characters "commit ", but I'll blame my lack of comfort with =
the=20
> > language again.
>=20
> I have thought about rewriting it in a different language, but I
> haven't found anything that really appeals.  I don't want to go to
> C/GTK or C/Qt since that would make it hard to port to Windows and

C/Gtk would be perfectly portable. As would C++/Gtk, Python/Gtk and Perl/Gt=
k.
C++/Qt4 would be perfectly portable as well, so choose whichever you find
easier to work with. For C/C++ they are on par, for Python/Perl/Ruby I think
Gtk has better bindings.

> MacOS AFAIK.  Python/Tk would be a possibility, but I have never
> learnt python and I'm actually not all that comfortable with having to
> do things the object-oriented way.

I would actually recommend against Python/Tk, because (tried it) py2exe does
not work seem to work with it, so you couldn't wrap it to easy to install
binary for windows folks. I did not try Python/Gtk, but I expect you might
have better luck with it (it's the Tcl/Tk interpreter that causes problems).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGP2dWRel1vVwhjGURAoDcAJ9Z90Z1+QcSxr9mKDn6cygzcy1kRQCcCw+u
D2F5q7Sao6fYXbqu7qvjW/o=
=6wsG
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
