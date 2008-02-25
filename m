From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Mon, 25 Feb 2008 15:15:16 +0100
Message-ID: <20080225141516.GA9391@piper.oerlikon.madduck.net>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org> <200802071056.19370.robin.rosenberg.lists@dewire.com> <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org> <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org> <18368.41742.689290.877767@cargo.ozlabs.ibm.com> <20080225080739.GA13610@piper.oerlikon.madduck.net> <18370.45020.940192.10482@cargo.ozlabs.ibm.com> <30e4a070802250535g72b59106yb1e4478eb9b9f47a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
To: Mark Levedahl <mlevedahl@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 15:17:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTe8P-0007bR-6l
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 15:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbYBYOQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 09:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbYBYOQD
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 09:16:03 -0500
Received: from seamus.madduck.net ([213.203.238.82]:38581 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbYBYOQB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 09:16:01 -0500
Received: from wall.oerlikon.madduck.net (84-75-158-163.dclient.hispeed.ch [84.75.158.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTP id 208734064C3;
	Mon, 25 Feb 2008 15:16:13 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 96C259F13A;
	Mon, 25 Feb 2008 15:15:16 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 4837F4403; Mon, 25 Feb 2008 15:15:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <30e4a070802250535g72b59106yb1e4478eb9b9f47a@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/5984/Mon Feb 25 14:11:32 2008 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75029>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Mark Levedahl <mlevedahl@gmail.com> [2008.02.25.1435 +0100]:
> 1) Add a "save config now" button and a "save config on exit"
> checkbox/option to the options dialog.

and a checkbox like "disable writing window geometry data to the
configuration file"

> 2) Perform a screen geometry check at load time to see if the corners
> of the main window would be visible before applying the main window
> geometry.

I don't see the benefit of this. I really rather believe that window
geometry is the job of the window manager. If Cygwin needs it, then
maybe it could be conditionally compiled on that platform.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
quantum mechanics: the dreams stuff is made of.
=20
spamtraps: madduck.bogus@madduck.net

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHws10IgvIgzMMSnURAhh3AKC9th71q1cJoo0EDs+F4tYJZNlalgCgy2fz
5LDhIhLr1gB7wfIJNkghff8=
=VNuV
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
