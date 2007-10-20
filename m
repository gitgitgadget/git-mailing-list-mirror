From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Fourth incarnation of the msysGit herald
Date: Sat, 20 Oct 2007 15:33:59 +0200
Message-ID: <20071020133359.GB19521@efreet.light.src>
References: <Pine.LNX.4.64.0710200024460.25221@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 20 15:34:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjET8-0000eD-Ji
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 15:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbXJTNeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 09:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbXJTNeL
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 09:34:11 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:43003 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbXJTNeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 09:34:09 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id C87B857369;
	Sat, 20 Oct 2007 15:34:07 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id Wruiu3XMvR1F; Sat, 20 Oct 2007 15:34:05 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 42BAC573CC;
	Sat, 20 Oct 2007 15:34:04 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IjESl-00022m-Bm; Sat, 20 Oct 2007 15:33:59 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710200024460.25221@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61832>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 20, 2007 at 00:25:49 +0100, Johannes Schindelin wrote:
> git gui
> =3D=3D=3D=3D=3D=3D=3D
>=20
> git gui is a really nice program, and as I often said, I consider it
> more porcelain than a gui, since it uses the git core directly, instead
> of wrapping around porcelain commands.
>=20
> The user experience I had with git gui made me think that this should
> be the primary interface Windows users should be confronted with, not
> the command line.
>=20
> The major problem we had in msysGit is that git-gui was to be launched
> from the Start Menu, or a QuickLaunch icon.  This is in contrast to
> the shell, where you usually start git gui in a working directory.

It would be nice to install an entry in the explorer menu to run git-gui in
a selected directory. It can be done by just writing something like to the
registry (completely untested -- I just looked it up on the internet):

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shell\Git Gui]
@=3D"Git Gui"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shell\Git Gui\command]
@=3D"git --git-dir=3D%L gui"

(The directory is passed in %L, but git --git-gui=3D"dir" gui seems to work=
, at
least on Linux. It needs absolute path, but you'll have that.)

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHGgPHRel1vVwhjGURAvfQAJ4pxypHuc741WfJAOX2HYjur24BKACgyasp
I66588onRNAz+/dVq5bRNEo=
=vDkG
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
