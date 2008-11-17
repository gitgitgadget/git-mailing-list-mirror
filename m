From: martin f krafft <madduck@madduck.net>
Subject: TopGit 0.5 released
Date: Mon, 17 Nov 2008 22:45:01 +0100
Organization: The Debian project
Message-ID: <20081117214501.GB12901@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 17 22:46:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2BvQ-0006cr-6x
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 22:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbYKQVpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 16:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbYKQVpM
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 16:45:12 -0500
Received: from clegg.madduck.net ([193.242.105.96]:37290 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbYKQVpK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 16:45:10 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id D17191D40AC
	for <git@vger.kernel.org>; Mon, 17 Nov 2008 22:45:03 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 566CE9F184
	for <git@vger.kernel.org>; Mon, 17 Nov 2008 22:45:02 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id AB20545F1; Mon, 17 Nov 2008 22:45:01 +0100 (CET)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8643/Mon Nov 17 20:40:22 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101247>


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear everyone,

I have the pleasure to announce TopGit 0.5, hopefully taking some
load of Petr's shoulders. I am sorry for the delay, I have myself
been swamped with work lately.

This release features a number of fixes and enhancements, including

  - Jonas' bash completion,
  - the tg-summary -t option (output just branch names),
  - tg-summary --graphviz to create dot graphs
  - tg-import -s to name commits and -d to specify base dependencies explic=
itly,=20
  - tg-mail -r to generate an In-Reply-To header

Please refer to the shortlog below for more information.

Let me use the opportunity to bring http://vcs-pkg.org to your
attention. If you are using Git for distro packaging, maybe we could
work together.

TopGit is meant as a fresh start in the steps of StGIT, quilt-in-git
and others, of course in an attempt to Get It Right this time
around. TopGit is a minimal porcelain layer that will manage your
patch queue using topic branches, one patch per branch, never
rewriting the history in order to enable a fully distributed
workflow.

You can get TopGit at

  http://repo.or.cz/w/topgit.git

and read up on its design, usage and implementation at:

  http://repo.or.cz/w/topgit.git?a=3Dblob;f=3DREADME

A tarball will become available on the Debian mirrors as
/debian/pool/main/t/topgit/topgit_0.5.orig.tar.gz as soon as I find
time to upload to the Debian archive, hopefully this week. You can
also obtain the tarball from the repo's pristine-tar[0] branch:

  pristine-tar checkout ../topgit_0.5.orig.tar.gz

0. http://packages.debian.org/source/sid/pristine-tar


git shortlog topgit-0.4..topgit-0.5:

Antonio Ospite (2):
      TopGit: small Makefile nitpichink
      TopGit: Force adding .topdeps on tg-depend

Jonas Fonseca (3):
      Add bash completion script for TopGit
      depend: Fix help listing
      Complete depend subcommand

Matt McDonald (2):
      tg depend: Allow adding deps from a subdir inside the repo.
      Make sure $root_dir does not have a trailing slash

Petr Baudis (17):
      README: Add warning about editing .topdeps manually
      tg depend: Even more robust subcommand handling
      tg summary -t: Very quick mode, only branch names
      tg-completion: Use tg summary -t for __tg_topics()
      tg mail: Fix $header string construction
      tg import -s: Import single commit using well-defined name
      tg import -d: Explicitly specify base dependency of the created branc=
hes
      tg import -s: Whitespace fix
      tg import: Construct actually proper .topmsg file
      tg import: More graceful conflicts handling
      tg update: Fix bogus advice on failed base update
      tg update: Always checkout head, even if we didn't update base further
      tg mail -r MSGID: Generate In-reply-to header
      tg export: Clarify usage
      README: lever -> level (spotted by jikos)
      tg summary --graphviz: Dot-suitable dependency graph
      README: tg depend rm TODO (insp. by Jonas)

martin f. krafft (2):
      tg-mail: do not use arrays, which are bashisms
      tg-export: no current branch check with -b
      Update version in tg script to 0.5

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
save the plankton - eat a whale.
=20
spamtraps: madduck.bogus@madduck.net

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkh5d0ACgkQIgvIgzMMSnXlZQCfe7M0CDl5i5szpZCx6Xuc6xs4
ZkMAnihNLPLxBbVtMJty8ec6VKYRKwG4
=foch
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
