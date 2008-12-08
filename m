From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [StGit] kha/{safe,experimental} updated
Date: Mon, 8 Dec 2008 21:39:23 +0100
Message-ID: <20081208203923.GA9986@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Gustav =?iso-8859-1?Q?H=E5llberg?= <gustav@virtutech.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 21:41:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9mub-0002eX-Fj
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 21:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYLHUji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2008 15:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbYLHUji
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 15:39:38 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3156 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYLHUji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 15:39:38 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L9mt1-0002dx-00; Mon, 08 Dec 2008 20:39:23 +0000
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102581>

The "safe" branch has a whole bunch of stgit.el improvements by David
and Gustav. "experimental" has the same two patches that just sit
there waiting for the git features they depend on to be sufficiently
widely deployed.


                                 -+-


The following changes since commit b9756849c9297b23f0628bcb08bad9a52a8a=
acf8:
  Dan Williams (1):
        fix export -s

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git safe

David K=E5gedal (6):
      stgit.el: Try to make the point stay on the coalesced patch
      stgit.el: Rename stgit-refresh to stgit-reload
      stgit.el: Move stgit-rename to C-c C-r
      stgit.el: Add the stgit-refresh command
      stgit.el: Show running commands
      Use separate column for zero in output of stg series -e

Gustav H=E5llberg (5):
      stgit.el: Compact code for populating stgit-mode-map
      stgit.el: Add 'q' for stgit-quit
      stgit.el: Add 'm' as alias for stgit-mark
      stgit.el: Add stgit-unmark-down
      stgit.el: Fix some indentation

Karl Hasselstr=F6m (1):
      stg series: Explain the list format better

 contrib/stgit.el         |  155 ++++++++++++++++++++++++++++++--------=
--------
 stgit/commands/series.py |   34 +++++++----
 2 files changed, 124 insertions(+), 65 deletions(-)


                                 -+-


The following changes since commit 6fdc3442eda397a2c7ab999193cdcc156423=
f773:
  Karl Hasselstr=F6m (1):
        stg series: Explain the list format better

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
