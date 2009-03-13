From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: kha/{safe,experimental} updated
Date: Fri, 13 Mar 2009 06:33:59 +0100
Message-ID: <20090313053359.GA19140@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	gustav@virtutech.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 06:35:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li03e-0000oQ-PU
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 06:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756146AbZCMFeQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 01:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755934AbZCMFeP
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 01:34:15 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:39116 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663AbZCMFeP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 01:34:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Li01v-0004zq-00; Fri, 13 Mar 2009 05:33:59 +0000
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113144>

The following changes since commit 594aa463c1852f77b89bdce853da4e7052d7=
cdd2:
  Karl Hasselstr=F6m (1):
        Rename "stg coalesce" to "stg squash"

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

David K=E5gedal (1):
      stgit.el: Don't steal bindings of C-p and C-n

Gustav H=E5llberg (7):
      stgit.el: Manually draw/erase the mark in stgit-{add,remove}-mark
      stgit.el: Clarify documentation of stgit-capture-output
      stgit.el: Add "M" for stgit-move-patches
      stgit.el: Run 'git show' with -M to detect renames when showing e=
ntire patch
      stgit.el: Break out stgit-sort-patches to a separate function for=
 future reuse
      stgit.el: Sort patches correctly before merging them in stgit-squ=
ash
      stgit.el: Handle errors in first phase of stgit squash

Karl Hasselstr=F6m (3):
      stg squash: Improve documentation
      Documentation: Ignore generated .xml files
      Documentation: Rename link macros

 Documentation/.gitignore    |    1 +
 Documentation/asciidoc.conf |   19 +++---
 Documentation/stg.txt       |   10 ++--
 Documentation/tutorial.txt  |  116 +++++++++++++++++-----------------
 contrib/stgit.el            |  148 +++++++++++++++++++++++++++++++++--=
--------
 stgit/commands/__init__.py  |    2 +-
 stgit/commands/branch.py    |    6 +-
 stgit/commands/clone.py     |    6 +-
 stgit/commands/new.py       |    2 +-
 stgit/commands/sink.py      |    2 +-
 stgit/commands/squash.py    |   20 +++++-
 11 files changed, 211 insertions(+), 121 deletions(-)


                                 -+-


The following changes since commit d7af287e9818dd12a8b7d9c7c217d7918614=
35af:
  David K=E5gedal (1):
        stgit.el: Don't steal bindings of C-p and C-n

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

Karl Hasselstr=F6m (2):
      Read several objects at once with git cat-file --batch
      Diff several trees at once with git diff-tree --stdin

 INSTALL          |    5 +++-
 stgit/lib/git.py |   79 ++++++++++++++++++++++++++++++++++++++++++++++=
+++----
 stgit/run.py     |   19 +++++++++++++
 3 files changed, 96 insertions(+), 7 deletions(-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
