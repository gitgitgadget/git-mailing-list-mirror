From: Jan Hudec <bulb@ucw.cz>
Subject: Re: most commonly used git commands?
Date: Sun, 1 Jul 2007 11:16:46 +0200
Message-ID: <20070701091645.GA26243@efreet.light.src>
References: <7vlke833wr.fsf@assigned-by-dhcp.pobox.com> <20070625071752.GB15343@mellanox.co.il> <Pine.LNX.4.64.0706250846200.4059@racer.site> <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com> <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com> <Pine.LNX.4.64.0706281506390.4438@racer.site> <20070630131428.GA2866@steel.home> <Pine.LNX.4.64.0706301531050.4438@racer.site> <20070630223504.GB2703@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 11:58:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4wC2-0006RW-PP
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 11:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837AbXGAJ6G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 05:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755797AbXGAJ6F
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 05:58:05 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:34860 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575AbXGAJ6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 05:58:04 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id D76EA57366;
	Sun,  1 Jul 2007 11:58:01 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id fvg6r8WHnFI7; Sun,  1 Jul 2007 11:58:00 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 447D357361;
	Sun,  1 Jul 2007 11:58:00 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I4vXy-0001C6-6P; Sun, 01 Jul 2007 11:16:46 +0200
Content-Disposition: inline
In-Reply-To: <20070630223504.GB2703@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51288>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 01, 2007 at 00:35:04 +0200, Alex Riesen wrote:
> Johannes Schindelin, Sat, Jun 30, 2007 16:31:48 +0200:
> > On Sat, 30 Jun 2007, Alex Riesen wrote:
> > > Johannes Schindelin, Thu, Jun 28, 2007 16:07:17 +0200:
> > > > > No. It was meant as Alex said it. Windows (MinGW) doesn't underst=
and
> > > > > "chmod a+x blub".
> > > >=20
> > > > Yes, I suspected that. But I don't see a need for it on Windows (Mi=
nGW) to=20
> > > > begin with.
> > > >=20
> > >=20
> > > But it is necessary on Windows (Cygwin):
> >=20
> > I thought that on Cygwin, filemode=3D1? I mean, Cygwin _never_ had prob=
lems=20
> > with chmod under my fingers.
> >=20
>=20
> Try doing stat(2) on file.txt which contains "#!/bin/sh" in its first
> line and for which you have issued a chmod yet. Like a new file, or
> like every file in a git-tracked directory after you did a fresh
> checkout. Cygwin actually opens the files when doing stat(2), looks
> inside and tries to guess if they are executable.
>=20
> You should have said: "Cygwin _never_ had problems with chmod because
> it cannot and didn't make it work". It is not just chmod, the other
> side, stat, matters as well.

I always had the impression, that cygwin actually *implements* chmod and do=
es
so using windows ACLs. And in ACL windows *do* support executable bit (I
copied some DLL with cygwin copy and it was NOT executable then). Of course
this only works on filesystems (NTFS, NTFS exported over CIFS) that support
ACLs. On FAT it might be doing something like you describe. Though it is
mostly irrelevant for git, because git does not work on FAT (Cygwin only
supports posix rename on NTFS).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGh3D9Rel1vVwhjGURAkKJAJ0WUORdSnw2V7SvQoQBIVDxgX/kMQCfTsiM
atUVRPnU88WSdi/GN13XJ9g=
=t+0I
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
