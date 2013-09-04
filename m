From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 0/7] documentation cleanups for <rev>^{<type>}
Date: Wed,  4 Sep 2013 15:04:27 -0400
Message-ID: <1378321474-7125-1-git-send-email-rhansen@bbn.com>
References: <xmqq1u55plqe.fsf@gitster.dls.corp.google.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 04 21:05:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHINr-0002Az-Sj
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760019Ab3IDTEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 15:04:52 -0400
Received: from smtp.bbn.com ([128.33.1.81]:64144 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759718Ab3IDTEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 15:04:51 -0400
Received: from socket.bbn.com ([192.1.120.102]:59575)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VHINf-00032v-An; Wed, 04 Sep 2013 15:04:43 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 1C9FA4004A
X-Mailer: git-send-email 1.8.4
In-Reply-To: <xmqq1u55plqe.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233857>

On 2013-09-03 18:46, Junio C Hamano wrote:
> I hate to say this after seeing you doing a thorough job in this
> series, but because "tree-ish" and "commit-ish" are both made-up
> words, I have a feeling that we are better off unifying to the
> dashed form, which unfortunately is the other way around from what
> your series does.

I thought you might say that so I held on to the commits that
standardize on tree-ish and commit-ish in my local repo.  :)

This series still says "tree-ish (also treeish)" and "commit-ish (also
committish)" in gitglossary(7).  Would you like me to eliminate the
"(also ...)"  part?

I'm not 100% confident that these don't break translations, although
it still builds and "make test" passes.

Changes since v2:
  * standardize on 'tree-ish' instead of 'treeish'
  * standardize on 'commit-ish' instead of 'committish'

Richard Hansen (7):
  glossary: mention 'treeish' as an alternative to 'tree-ish'
  glossary: define commit-ish (a.k.a. committish)
  use 'tree-ish' instead of 'treeish'
  use 'commit-ish' instead of 'committish'
  glossary: more precise definition of tree-ish (a.k.a. treeish)
  revisions.txt: fix and clarify <rev>^{<type>}
  glossary: fix and clarify the definition of 'ref'

 Documentation/RelNotes/1.7.11.2.txt          |  2 +-
 Documentation/config.txt                     |  4 +--
 Documentation/git-cat-file.txt               |  2 +-
 Documentation/git-describe.txt               | 14 ++++-----
 Documentation/git-fast-import.txt            | 26 +++++++--------
 Documentation/git-merge-tree.txt             |  2 +-
 Documentation/git-name-rev.txt               |  2 +-
 Documentation/git-push.txt                   |  2 +-
 Documentation/gitcli.txt                     |  2 +-
 Documentation/glossary-content.txt           | 47 +++++++++++++++++++++++-----
 Documentation/howto/revert-branch-rebase.txt |  2 +-
 Documentation/revisions.txt                  | 12 ++++---
 builtin/describe.c                           |  4 +--
 builtin/merge.c                              |  2 +-
 contrib/examples/git-merge.sh                |  2 +-
 fast-import.c                                | 20 ++++++------
 git-cvsserver.perl                           |  2 +-
 po/da.po                                     |  2 +-
 po/de.po                                     |  6 ++--
 po/fr.po                                     |  4 +--
 po/git.pot                                   |  4 +--
 po/it.po                                     |  2 +-
 po/nl.po                                     |  2 +-
 po/pt_PT.po                                  |  2 +-
 po/sv.po                                     |  6 ++--
 po/vi.po                                     |  6 ++--
 po/zh_CN.po                                  |  4 +--
 sha1_name.c                                  |  6 ++--
 t/t9300-fast-import.sh                       |  6 ++--
 test-match-trees.c                           |  4 +--
 30 files changed, 118 insertions(+), 83 deletions(-)

-- 
1.8.4
