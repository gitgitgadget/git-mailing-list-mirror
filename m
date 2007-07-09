From: martin f krafft <madduck@madduck.net>
Subject: how to combine two clones in a collection
Date: Tue, 10 Jul 2007 00:22:50 +0200
Message-ID: <20070709222250.GA8007@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 00:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I828C-00068T-SZ
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 00:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548AbXGIWy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 18:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758199AbXGIWy5
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 18:54:57 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:45762 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757034AbXGIWyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 18:54:54 -0400
X-Greylist: delayed 1918 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2007 18:54:54 EDT
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id E0BC7895D78
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 00:22:51 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 07101-09 for <git@vger.kernel.org>;
	Tue, 10 Jul 2007 00:22:51 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 9EDCD895D74
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 00:22:51 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id C544E9F121
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 00:22:50 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 2BC9E43FC; Tue, 10 Jul 2007 00:22:50 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52024>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

I am new to git but already quite sold on it. Especially git-svn
makes my heart jump.

I am now ready to move to using git for most of my everyday work,
but I am still unsure how to tackle one specific aspect of it, for
which I used svn:externals in the past. I know about git
subprojects, but these aren't what I want, really.

I am a Debian developer, and while the upstream trunk is usually
maintained in SVN by upstream him/herself, I maintain the ./debian
directory elsewhere.

With SVN, I would have a directory with two external entries:

  upstream.trunk svn+ssh://svn.upstream.org/path/to/trunk
  upstream.trunk/debian svn+ssh://svn.debian.org/svn/pkg/trunk/debian

I hope this makes what I mean obvious. GNU arch has a similar
concept called configs.

How can I do this with git? I am aware that maybe the best way would
be to use git-svn to track the upstream branch remotely and to add
=2E/debian in a separate git branch (and to stop using SVN and switch
to git for ./debian), but I am not sure I want to mirror all
upstream projects in git repos published on svn.debian.org, and if
it's only for space reasons.

Do you know of other approaches, short of writing my own
config-manager?

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"never eat more than you can lift."
                                                       -- miss piggy

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGkrU6IgvIgzMMSnURAgoSAKDjpW/Yd41nviSnspKG7gQjuSXHNQCg4ZpX
N9G5ImrPAly3njwHNj/9Ve4=
=REAi
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
