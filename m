From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 13:02:24 +0200
Message-ID: <20070719110224.GA4293@piper.oerlikon.madduck.net>
References: <20070719104351.GA17182@midwinter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 13:02:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBTmB-0005mk-O1
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 13:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbXGSLC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 07:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbXGSLC2
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 07:02:28 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:50495 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbXGSLC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 07:02:27 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 8339A895D73
	for <git@vger.kernel.org>; Thu, 19 Jul 2007 13:02:25 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 29737-02 for <git@vger.kernel.org>;
	Thu, 19 Jul 2007 13:02:25 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 4F185895D72
	for <git@vger.kernel.org>; Thu, 19 Jul 2007 13:02:25 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id AD4989F194
	for <git@vger.kernel.org>; Thu, 19 Jul 2007 13:02:24 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 892E943EA; Thu, 19 Jul 2007 13:02:24 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070719104351.GA17182@midwinter.com>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52967>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Steven Grimm <koreth@midwinter.com> [2007.07.19.1243 +0200]:
>  'GIT_PAGER'::
> -	This environment variable overrides `$PAGER`.
> +	This environment variable overrides `$PAGER`. If it is set
> +	to an empty string or to the value "cat", git will not launch
> +	a pager.

+1 on the patch, but I also wonder why use of a pager is default in
git anyway. At least I find it to be contrary to what I am used to
on the Unix command line.

For reference, there was an argument about this in
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D424978, which
includes a long IRC log in German, unfortunately, where a bunch of
people agreed with my proposal *not* to use a pager by default,
since it makes it difficult to use information from the output to
assemble the next command on the command line. Every terminal in use
nowadays can easily scroll and even search back 250 lines with the
added benefit of not randomly clearing the screen when you quit
$PAGER.

I am sure there is a reason for the choice of using a pager by
default. Could we please either rethink this reason and possibly
make it non-default, or alternatively add the reason to the FAQ?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
no micro$oft components were used
in the creation or posting of this email.
therefore, it is 100% virus free
and does not use html by default (yuck!).

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGn0S/IgvIgzMMSnURAraSAKDLfB3LkpUUbw0TJlkQtoFrVx7B5gCfViG8
5eUIrNv5Wlhf2ERkBbjgOos=
=gfC5
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
