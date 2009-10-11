From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Installing full fledged git on solaris?
Date: Sun, 11 Oct 2009 09:12:08 -0400
Message-ID: <1255265817-sup-4123@ntdws12.chass.utoronto.ca>
References: <c94f8e120910110526r68e4abe1l269dc4b3ab22bac3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1255266736-115327-1386-2717-31-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 15:14:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwyFX-0002xd-JQ
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 15:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240AbZJKNM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 09:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbZJKNMz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 09:12:55 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:35313 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbZJKNMz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 09:12:55 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:60200 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1MwyDh-00020R-HF; Sun, 11 Oct 2009 09:12:17 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1MwyDh-0001wC-3s; Sun, 11 Oct 2009 09:12:17 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n9BDCG3T007448;
	Sun, 11 Oct 2009 09:12:16 -0400
In-reply-to: <c94f8e120910110526r68e4abe1l269dc4b3ab22bac3@mail.gmail.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129920>


--=-1255266736-115327-1386-2717-31-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Dilip M's message of Sun Oct 11 08:26:10 -0400 2009:

Hi Dilip,

> Has anyone has the list of pkg's to be installed on solaris 10 sparc,
> to get the GIT compiled (with all features)..

This may not be what you want, but if you use the CSW package stack,
you can get git easily.  This is, I believe, a very complete git
installation.  There will soon be an update to 1.6.5.

http://www.opencsw.org/packages/git

If your intent is to build it yourself, let me know and I'll share
with you the build recipe I use, which will outline (within the CSW
stack) which packages are used for compilation and which for runtime
dependencies.  You should be able to translate it to use the
libs/tools available to solaris 10 (that aren't in 8, which we also
support).

HTH
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1255266736-115327-1386-2717-31-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFK0dmv8vuMHY6J9tIRAsaKAJ4pru4BqbKw2H7/PrQ2C7ec3bRdmgCgiuO9
L8KfK8XhYYpYoYO2UOKvQYQ=
=gFvc
-----END PGP SIGNATURE-----

--=-1255266736-115327-1386-2717-31-=--
