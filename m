From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: kha/{stable,safe,experimental} updated
Date: Fri, 23 Jan 2009 00:29:28 +0100
Message-ID: <20090122232928.GA23456@diana.vm.bytemark.co.uk>
References: <1232412373-10836-1-git-send-email-ted@tedpavlic.com> <1232412373-10836-2-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ted@tedpavlic.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:31:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ91I-0008S2-Sy
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 00:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757686AbZAVX3r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2009 18:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757423AbZAVX3r
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 18:29:47 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2262 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756946AbZAVX3q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 18:29:46 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LQ8zI-00069J-00; Thu, 22 Jan 2009 23:29:28 +0000
Content-Disposition: inline
In-Reply-To: <1232412373-10836-2-git-send-email-ted@tedpavlic.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106802>

Ted, Both of your patches look good, and work when I try them.
(Excellent commit messages, by the way.) I've applied them and pushed
them out.

Catalin, I have stuff for you in both kha/stable and kha/safe.


                                 -+-


The following changes since commit 7cb253c05b509510177a1df4d58138616419=
68f6:
  Karl Hasselstr=F6m (1):
        Fix typo

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git stable

Karl Hasselstr=F6m (1):
      Return None instead of crashing on undefined integer config items

Pete Wyckoff (1):
      stgit.namelength is an integer

 stgit/config.py |    4 +++-
 stgit/utils.py  |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)


                                 -+-


The following changes since commit d3b31eeac6c6fba9352188755164f556faf5=
6e59:
  Catalin Marinas (1):
        Fix the patch argument parsing for the "show" command

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

Gustav H=E5llberg (7):
      stgit.el: Consistently use symbols rather than strings for patch =
names
      stgit.el: Make single file diff buffer read-only
      stgit.el: Include stat summary in patch diff
      stgit.el: Add message when there are no patches in the series
      stgit.el: Indicate empty patches
      stgit.el: Minor beautification
      stgit.el: Add optional count argument to stgit-commit

Karl Hasselstr=F6m (2):
      Return None instead of crashing on undefined integer config items
      Merge branch 'stable'

Pete Wyckoff (1):
      stgit.namelength is an integer

Ted Pavlic (2):
      Modify bash completion to support help, version, and copyright.
      Make bash completion fail to bashdefault before default completio=
n.

 contrib/stgit.el    |  245 ++++++++++++++++++++++++++++---------------=
--------
 stgit/completion.py |   11 ++-
 stgit/config.py     |    4 +-
 stgit/utils.py      |    2 +-
 4 files changed, 146 insertions(+), 116 deletions(-)


                                 -+-


The following changes since commit e80d43bd9c8baf2bc9913c6c153914403f21=
0872:
  Ted Pavlic (1):
        Make bash completion fail to bashdefault before default complet=
ion.

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

Gustav H=E5llberg (1):
      stgit.el: (EXPERIMENTAL) Show files modified in work tree

Karl Hasselstr=F6m (2):
      Read several objects at once with git cat-file --batch
      Diff several trees at once with git diff-tree --stdin

 INSTALL          |    5 +-
 contrib/stgit.el |  272 ++++++++++++++++++++++++++++++++++------------=
--------
 stgit/lib/git.py |   79 +++++++++++++++-
 stgit/run.py     |   19 ++++
 4 files changed, 266 insertions(+), 109 deletions(-)


--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
