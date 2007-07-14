From: martin f krafft <madduck@madduck.net>
Subject: Re: Restoring files from old commits
Date: Sat, 14 Jul 2007 14:37:54 +0200
Message-ID: <20070714123754.GA29622@piper.oerlikon.madduck.net>
References: <4698BD17.5080205@random-state.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
To: git-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 14:38:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9gsp-0001Q8-HD
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 14:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758342AbXGNMh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 08:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758120AbXGNMh4
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 08:37:56 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:54047 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903AbXGNMh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 08:37:56 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 20794895D73
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 14:37:55 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28094-08 for <git@vger.kernel.org>;
	Sat, 14 Jul 2007 14:37:54 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id D5AD6895D72
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 14:37:54 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 4F6E89F121
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 14:37:54 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 21DEF43FC; Sat, 14 Jul 2007 14:37:54 +0200 (CEST)
Mail-Followup-To: git-list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4698BD17.5080205@random-state.net>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52475>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Nikodemus Siivola <nikodemus@random-state.net> [2007.07.14.1409=
 +0200]:
> What is the recommended way to restore individual files
> (or directories) in the working tree to the content they
> had in a given commit?

As per my comment on IRC, I think

  git checkout <tree-ish> <path>

is the way.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"the difference between genius and stupidity
 is that genius has it's limits."
                                                    -- albert einstein

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmMOiIgvIgzMMSnURAon8AJ43p/ouE+RpKnfSJqMWzPHJhR7yLgCgq40g
O5Wear7bv2P8gQ9vv7dBo2E=
=JCKT
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
