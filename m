From: jepler@unpythonic.net
Subject: Re: gitk "hyperlinks" (was Re: Display of merges in gitk)
Date: Sat, 6 Aug 2005 12:07:39 -0500
Message-ID: <20050806170735.GA18063@unpythonic.net>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0508050658260.3258@g5.osdl.org> <Pine.LNX.4.58.0508050710460.3258@g5.osdl.org> <17140.47152.672091.474748@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0508060919150.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Cc: Paul Mackerras <paulus@samba.org>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 19:08:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1S9H-0004Pv-9h
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 19:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbVHFRHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 13:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbVHFRHm
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 13:07:42 -0400
Received: from craie.unpythonic.net ([206.222.212.219]:43199 "EHLO
	craie.unpythonic.net") by vger.kernel.org with ESMTP
	id S263270AbVHFRHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 13:07:40 -0400
Received: by craie.unpythonic.net (Postfix, from userid 405)
	id 4F14D5DC335; Sat,  6 Aug 2005 12:07:39 -0500 (CDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508060919150.3258@g5.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 06, 2005 at 09:20:16AM -0700, Linus Torvalds wrote:
> Looks good also. I assume the mouse can't change when it hovers?=20

In gitk?  This is be possible.  My patch[1] does it.  The way it's done sti=
nks a
little bit, though.  <Enter> and <Leave> are bound on a tag common to all t=
he
"hyperlinks", and change the -cursor of the whole widget---either to hand2 =
or
the empty string.

+    $ctext tag bind Commit <Enter> { %W configure -cursor hand2 }
+    $ctext tag bind Commit <Leave> { %W configure -cursor {} }

My patch also underlines links, as requested in a different message in this=
 thread.

+    $ctext tag configure Commit -underline yes -foreground blue

Jeff
[1] http://www.gelato.unsw.edu.au/archives/git/0508/7253.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFC9O5XJd01MZaTXX0RAim5AJ9KhZx/Gqhpd2WyKrP7s07Q47GODQCfWZI2
CFgPqF1LGjO6YkfQV+jXNLw=
=PvuF
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
