From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 0/7] documentation cleanups for <rev>^{<type>}
Date: Mon,  2 Sep 2013 01:34:19 -0400
Message-ID: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 02 08:19:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNU9-0007IT-1t
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab3IBGTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:19:31 -0400
Received: from smtp.bbn.com ([128.33.0.80]:57817 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab3IBGT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:19:29 -0400
Received: from socket.bbn.com ([192.1.120.102]:55315)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VGMmf-000NLR-LX; Mon, 02 Sep 2013 01:34:41 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id F08994015A
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233603>

The documentation for the <rev>^{<type>} syntax (e.g., v1.8.4^{tree})
needed some fixing, and the fixes motivated some other documentation
cleanups.

Changes since v1 (2013-06-18, see
<http://thread.gmane.org/gmane.comp.version-control.git/228325>):
  * standardize on 'treeish' (don't use 'tree-ish')
  * standardize on 'committish' (don't use 'commit-ish')
  * don't base the definition of 'committish' on the broken definition
    of 'ref'
  * fix the definition of 'treeish' so that it is not based on the
    broken definition of 'ref'
  * fix the definiton of 'ref'

Richard Hansen (7):
  glossary: mention 'treeish' as an alternative to 'tree-ish'
  glossary: define committish (a.k.a. commit-ish)
  use 'treeish' instead of 'tree-ish'
  use 'committish' instead of 'commit-ish'
  glossary: more precise definition of treeish (a.k.a. tree-ish)
  revisions.txt: fix and clarify <rev>^{<type>}
  glossary: fix and clarify the definition of 'ref'

 Documentation/RelNotes/1.6.0.5.txt       |  2 +-
 Documentation/RelNotes/1.6.2.4.txt       |  2 +-
 Documentation/RelNotes/1.8.1.2.txt       |  2 +-
 Documentation/RelNotes/1.8.2.txt         |  2 +-
 Documentation/diff-format.txt            | 10 +++----
 Documentation/diff-generate-patch.txt    |  2 +-
 Documentation/git-archive.txt            |  4 +--
 Documentation/git-checkout.txt           | 16 +++++------
 Documentation/git-diff-index.txt         |  4 +--
 Documentation/git-diff-tree.txt          | 14 +++++-----
 Documentation/git-ls-files.txt           |  6 ++--
 Documentation/git-ls-tree.txt            |  6 ++--
 Documentation/git-read-tree.txt          | 10 +++----
 Documentation/git-rebase.txt             |  2 +-
 Documentation/git-reset.txt              | 16 +++++------
 Documentation/git-rev-parse.txt          |  2 +-
 Documentation/git-svn.txt                |  6 ++--
 Documentation/git-tar-tree.txt           |  4 +--
 Documentation/git.txt                    |  8 +++---
 Documentation/gitcli.txt                 |  2 +-
 Documentation/gittutorial-2.txt          |  2 +-
 Documentation/glossary-content.txt       | 47 ++++++++++++++++++++++++++------
 Documentation/revisions.txt              | 14 ++++++----
 archive.c                                |  6 ++--
 builtin/checkout.c                       |  6 ++--
 builtin/diff-index.c                     |  2 +-
 builtin/diff-tree.c                      |  2 +-
 builtin/diff.c                           |  2 +-
 builtin/ls-files.c                       |  8 +++---
 builtin/ls-tree.c                        |  2 +-
 builtin/read-tree.c                      |  2 +-
 builtin/reset.c                          |  4 +--
 builtin/revert.c                         |  4 +--
 builtin/tar-tree.c                       | 12 ++++----
 contrib/examples/git-checkout.sh         | 10 +++----
 contrib/examples/git-reset.sh            |  2 +-
 contrib/examples/git-revert.sh           |  4 +--
 fast-import.c                            |  2 +-
 git-svn.perl                             |  6 ++--
 gitweb/gitweb.perl                       |  4 +--
 po/de.po                                 | 20 +++++++-------
 po/fr.po                                 | 20 +++++++-------
 po/git.pot                               | 20 +++++++-------
 po/sv.po                                 | 20 +++++++-------
 po/vi.po                                 | 41 ++++++++++++++--------------
 po/zh_CN.po                              | 20 +++++++-------
 remote.c                                 |  2 +-
 t/t1512-rev-parse-disambiguation.sh      | 26 +++++++++---------
 t/t2010-checkout-ambiguous.sh            |  2 +-
 t/t4100/t-apply-3.patch                  |  8 +++---
 t/t4100/t-apply-7.patch                  |  8 +++---
 t/t9300-fast-import.sh                   |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh   |  2 +-
 t/t9501-gitweb-standalone-http-status.sh |  8 +++---
 54 files changed, 247 insertions(+), 213 deletions(-)

-- 
1.8.4
