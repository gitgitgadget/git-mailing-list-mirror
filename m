From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Mon, 23 Mar 2009 08:57:27 -0400
Message-ID: <1237812904-sup-3864@ntdws12.chass.utoronto.ca>
References: <1237728044-15651-1-git-send-email-bwalton@artsci.utoronto.ca> <20090323065710.GA7048@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1237813051-764318-28712-7757-29-="; micalg="pgp-sha1"
Cc: GIT List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 13:59:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lljk8-0007g2-Og
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 13:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbZCWM5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 08:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbZCWM5e
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 08:57:34 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:60515 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbZCWM5d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 08:57:33 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Lljid-0004Ro-Uq; Mon, 23 Mar 2009 08:57:31 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Lljid-0006Iu-SO; Mon, 23 Mar 2009 08:57:31 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n2NCvV3r024232;
	Mon, 23 Mar 2009 08:57:31 -0400
In-Reply-To: <20090323065710.GA7048@coredump.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114300>


--=-1237813051-764318-28712-7757-29-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Jeff King's message of Mon Mar 23 02:57:10 -0400 2009:
> Nit: I have lots of systems where sh is not bash, and they work fine. It
> is really about "where sh is not horribly broken". There aren't (AFAIK)
> and should not be any bash-isms in these scripts.

That's a fair point.  I've been lugging this around for a bit in the
build tree I use, so I don't recall specifically what was breaking.
The sh in question is the one found in solaris 8.  When I get a few
mintues, I'll build without the patch to see what the problem was...

> The patch itself looks fine; thanks for addressing my concerns.

Thanks for the helpful feedback! :)

-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1237813051-764318-28712-7757-29-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJx4c78vuMHY6J9tIRAjDEAJ4tpZDnO41V0Q+YdFjiPiLAw78ftQCfaRCY
ly/Ab6Wg2DaPAbp18HfZeJ4=
=COWC
-----END PGP SIGNATURE-----

--=-1237813051-764318-28712-7757-29-=--
