From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Mon, 10 Mar 2008 12:29:23 +0100
Message-ID: <20080310112923.GA21252@piper.oerlikon.madduck.net>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org> <200802071056.19370.robin.rosenberg.lists@dewire.com> <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org> <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org> <18368.41742.689290.877767@cargo.ozlabs.ibm.com> <47C190E3.6000407@gmail.com> <18383.57540.26282.526111@cargo.ozlabs.ibm.com> <20080307111144.GA18108@piper.oerlikon.madduck.net> <18386.29775.512557.202621@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
To: Paul Mackerras <paulus@samba.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	442253-quiet@bugs.debian.org
X-From: git-owner@vger.kernel.org Mon Mar 10 12:30:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYgDX-0001Kh-Ur
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 12:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbYCJLaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 07:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbYCJLaQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 07:30:16 -0400
Received: from seamus.madduck.net ([213.203.238.82]:48702 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbYCJLaP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 07:30:15 -0400
Received: from wall.oerlikon.madduck.net (84-75-158-163.dclient.hispeed.ch [84.75.158.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTP id 1E0D140612D;
	Mon, 10 Mar 2008 12:30:22 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 001E49F18E;
	Mon, 10 Mar 2008 12:29:23 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id A70C8442D; Mon, 10 Mar 2008 12:29:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18386.29775.512557.202621@cargo.ozlabs.ibm.com>
X-Motto: Keep the good times rollin'
X-Debbugs-No-Ack: please spare me
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/6191/Mon Mar 10 11:45:33 2008 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76720>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Paul Mackerras <paulus@samba.org> [2008.03.08.1211 +0100]:
> > I understand that Cygwin has issues and needs this code, but
> > couldn't it then be made to run only on Cygwin, such that on
> > "proper" Unix systems, the config file is *not* updated every
> > time I move the window before closing the application?
>=20
> What's the issue with updating the config file?

Conflicts when synchronising the files between different machines,
or the need for a custom merge driver just for .gitkrc files.

> > As I said earlier, this is really the job of a window manager,
> > *not* a configuration option. If your window manager cannot
> > restore the window to a size you control, then it's broken.
> > Let's not hack applications to work around that, please.
>=20
> I disagree.  It's not a window manager's job to tell an
> application how big its window should be.

I always assumed it was: position and geometry. However, I am
starting to see your point.

I guess the best way would be a checkbox with which I can disable
the saving of the geometry on application close, possibly paired
with a button "save now".

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
an egg has the shortest sex-life of all: if gets laid once; it gets
eaten once. it also has to come in a box with 11 others, and the
only person who will sit on its face is its mother.
=20
spamtraps: madduck.bogus@madduck.net

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH1RuTIgvIgzMMSnURAnSHAKDjb4k4Dwqrp5glQv9+Hqp7XdsH2wCgwHQs
98RKLbXSMnJvV4aRrgREFcQ=
=/vlJ
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
