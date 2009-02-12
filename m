From: martin f krafft <madduck@madduck.net>
Subject: topgit: call for help with releasing.
Date: Thu, 12 Feb 2009 14:24:35 +0100
Message-ID: <20090212132434.GA32715@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 12 14:26:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXbZy-0000ET-Mz
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 14:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757747AbZBLNYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 08:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756684AbZBLNYm
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 08:24:42 -0500
Received: from clegg.madduck.net ([193.242.105.96]:53106 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643AbZBLNYm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 08:24:42 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 194521D409B
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 14:24:36 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id ABE189F13D
	for <git@vger.kernel.org>; Thu, 12 Feb 2009 14:24:35 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 4582E4462; Thu, 12 Feb 2009 14:24:35 +0100 (CET)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8982/Thu Feb 12 12:23:37 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109616>


--xgyAXRrhYN0wYx8y
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear gits,

Petr and I are both swamped with work, and TopGit 0.6 has been
pending for months and it's still not released. A lot of people have
sent patches, and it pains me not to be able to honour their work
with frequent releases.

I am thus looking for someone who would be willing to take over
releases of TopGit, at least until my backlog has cleared and
I managed to get my thesis in.

The next release, 0.6 is mostly ready (announcement-in-preparation
attached), but one of the things that needs to happen in the near
future is a reimplementation of option parsing using git-rev-parse
to address some of the current limitations.

I'll be glad to assist anyone taking on the task in any way I can.
I will still take care of Debian releases.

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
all software projects are done by iterative prototyping.
some companies call their prototypes "releases", that's all.
=20
spamtraps: madduck.bogus@madduck.net

--7AUc2qLy4jB3hD7Z
Content-Type: message/rfc822
Content-Disposition: inline

From: martin f krafft <madduck@madduck.net>
X-OfflineIMAP-1790436410-7365616d75732e6d61646475636b2e6e6574-647261667473: 1232691329-08323050246-v6.0.3
To: git discussion list <git@vger.kernel.org>
Subject: [TopGit] TopGit 0.6 released
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.27-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
X-Mutt-Fcc: =store
X-Mutt-PGP: S<0x330c4a75>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename=mutt-piper-1000-32715-41
Content-Transfer-Encoding: quoted-printable

Dear everyone,

It's been a while since life has keeping me busy, but here it is:
TopGit 0.6.

This release features a number of fixes and enhancements, including

  - Uwe's work to improve tg-export
  - Completion updates (still bash-only, any zsh wizards out there?)
  - Pager improvements by Kirill
  - Kirill's work to allow you to use worktree and index to generate
    patches

Please refer to the shortlog below for more information.

If you are interested in TopGit and you work on distro packaging,
you ought to have a look at http://vcs-pkg.org.

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
/debian/pool/main/t/topgit/topgit_0.6.orig.tar.gz as soon as I find
time to upload to the Debian archive, hopefully this week. You can
also obtain the tarball from the repo's pristine-tar[0] branch:

  pristine-tar checkout ../topgit_0.6.orig.tar.gz

0. http://packages.debian.org/source/sid/pristine-tar


git shortlog topgit-0.5..topgit-0.6:

Bert Wesarg (1):
      tg-summary: -t and --graphviz are mutual exclusive

Jonas Fonseca (1):
      README: spelling fixes

Kirill Smelkov (5):
      tg-completion: complete options for `tg summary`
      tg-completion: complete options for `tg remote`
      Implement setup_pager just like in git
      tg-patch: fix pagination
      tg-patch: add support for generating patches against worktree and ind=
ex

Marc Weber (1):
      Pass -- to rev-list for branch/filename disambiguation

Uwe Kleine-K=F6nig (5):
      tg-export: implement skipping empty patches for quilt mode
      tg export (collapse): implement skipping empty patches
      tg export (quilt): Implement flattening patch paths
      tg export (quilt): Implement numbering the patches
      make tg remote idempotent

martin f. krafft (14):
      ignore tg-depend build files
      remove +x bit from tg-depend
      Make sure gitignore patterns are not recursive
      add ignore patterns for quilt and debian build
      Change tg help exit code to 0
      Check for cmddir earlier
      Print help output when no command is given
      Require an argument to tg -r
      Print help message when command is not proper
      Note that do_help is used when short messages might be wanted
      Add Vim modelines for consistent spacing
      Check for git-send-email and die if not found
      put tg version into a variable at the top
      bump version number to 0.6

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"i think, therefore i'm single"
                                                      -- lizz winstead
=20
spamtraps: madduck.bogus@madduck.net

--7AUc2qLy4jB3hD7Z--

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmUIxIACgkQIgvIgzMMSnXfjACgoDKjMGM5ZrYYO4fCPiNrGjw7
TZQAoKNNRzlx50/a0qT/8pdJxLQmIC9m
=BQy7
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
