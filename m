From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [ANNOUNCE] TopGit 0.7
Date: Thu, 5 Mar 2009 21:27:09 +0100
Message-ID: <20090305202709.GB15486@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 21:29:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKC4-0007Uo-T9
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 21:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbZCEU1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 15:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZCEU1N
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 15:27:13 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41732 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbZCEU1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 15:27:12 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LfK9u-00072q-4v
	for git@vger.kernel.org; Thu, 05 Mar 2009 21:27:10 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LfK9t-000054-Qd
	for git@vger.kernel.org; Thu, 05 Mar 2009 21:27:09 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112334>

Hello *,

I'm happy to announce that TopGit 0.7 was released today.

This release brings you several bug fixes and a few new features.

The most useful new feature (in my opinon) is a new export method that
provides your patches as a linear history in a regular git branch for
pulling by your upstream.

TopGit aims to make handling of large amount of interdependent topic
branches easier. In fact, it is designed especially for the case when
you maintain a queue of third-party patches on top of another (perhaps
Git-controlled) project and want to easily organize, maintain and submi=
t
them - TopGit achieves that by keeping a separate topic branch for each
patch and providing few tools to maintain the branches

You can get TopGit at

	http://repo.or.cz/w/topgit.git

or if you run Debian you can install the version from the
unstable distribution[*1*].

If you want to read more about TopGit's design, usage and
implementation, let me point you to TopGit's README at

	http://repo.or.cz/w/topgit.git?a=3Dblob;f=3DREADME

The full shortlog since version TopGit 0.5[*2*] can be found below.

I would be happy if you gave it a try and reported your impressions,
suggestions and bugs.

Best regards
Uwe

[*1*] Up to now it didn't hit unstable, but if you cannot wait for a fe=
w
      hours you have to install from source :-)

[*2*] Version 0.6 was skipped, because a change bumping the version
      number was accidently pushed to a public repo.  As the latest
      version get some more changes, we decided to skip to 0.7.

Bert Wesarg (1):
      tg-summary: -t and --graphviz are mutual exclusive

Jonas Fonseca (1):
      README: spelling fixes

Kirill Smelkov (5):
      tg-completion: complete options for `tg summary`
      tg-completion: complete options for `tg remote`
      Implement setup_pager just like in git
      tg-patch: fix pagination
      tg-patch: add support for generating patches against worktree and=
 index

Marc Weber (1):
      Pass -- to rev-list for branch/filename disambiguation

Uwe Kleine-K=F6nig (15):
      tg-export: implement skipping empty patches for quilt mode
      tg export (collapse): implement skipping empty patches
      tg export (quilt): Implement flattening patch paths
      tg export (quilt): Implement numbering the patches
      make tg remote idempotent
      [TOPGIT] limit rev-list in branch_contains to a single rev
      [TOPGIT] allow working with annihilated branches
      [TOPGIT] make tg remote idempotent
      [TOPGIT] make creating a commit from a topgit branch a function
      [TOPGIT] implement linearize export method
      Don't throw away already started base on resumed create.
      Add documentation for tg export --linearize
      Merge branch 'upstream' of git.debian.org:/git/collab-maint/topgi=
t
      Fix typo s/emmail/email/
      bump version number to 0.7

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
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
