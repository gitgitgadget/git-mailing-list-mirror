From: martin f krafft <madduck@madduck.net>
Subject: Re: how to combine two clones in a collection
Date: Wed, 11 Jul 2007 20:13:01 +0200
Message-ID: <20070711181301.GA26815@piper.oerlikon.madduck.net>
References: <200707110145.28931.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 20:13:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8gga-0007wK-U6
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 20:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469AbXGKSNH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 14:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbXGKSNF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 14:13:05 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:45121 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbXGKSNE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 14:13:04 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id B8841895D73
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 20:13:02 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 31006-08 for <git@vger.kernel.org>;
	Wed, 11 Jul 2007 20:13:02 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 83408895D72
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 20:13:02 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id D5C6C9F15D
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 20:13:01 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id A1F8543FC; Wed, 11 Jul 2007 20:13:01 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200707110145.28931.robin.rosenberg.lists@dewire.com>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52181>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach robin:
> And the simplest way to create an new indpendent branch:

> echo ref: refs/heads/newbranch >.git/HEAD
> Then prepare the content and commit like you used to do.

Hi Robin, thanks for this nice suggestion, which doesn't only
createa a new, independent branch, it also teaches me yet a bit
more about git.

I am a little uneasy about touching files in .git with non-git
tools, but everyone seems to be doing it, so I guess it's okay, and
it make git a lot more powerful too.

Anyway, I tried your method and there is one small problem:

  piper:~> git init-db
  Initialized empty Git repository in .git/
  piper:~> date > date; git add date; git commit -m.
  Created initial commit 2dd8d6f: .
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 date
  piper:~> echo ref: refs/heads/newbranch >| .git/HEAD
  piper:~> git status
  # On branch newbranch
  #
  # Initial commit
  #
  # Changes to be committed:
  #   (use "git rm --cached <file>..." to unstage)
  #
  #       new file: date
  #

If I were to run commit now, the file 'date' would become part of
the first commit to newbranch. But it's already in the master
branch.

Is there anyway I can prevent this and start a new branch from
scratch without having to unstage all previous additions?

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"anyone who is capable of getting themselves made president
 should on no account be allowed to do the job"
                                                      -- douglas adams

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlR2tIgvIgzMMSnURAqMWAJ9GxK/i5LV4j7wzoqt3az/iyysQqwCfU1vt
REl54nuqL9vjtmT5K8Uqe9o=
=l4pT
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
