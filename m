From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH 0/4] Remove deprecated commands
Date: Sun, 10 Nov 2013 15:47:27 +0000
Message-ID: <cover.1384098226.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 10 16:47:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfXEp-0008Cx-4m
	for gcvg-git-2@plane.gmane.org; Sun, 10 Nov 2013 16:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab3KJPrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 10:47:43 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:50292 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab3KJPrm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 10:47:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id F1F4E606547;
	Sun, 10 Nov 2013 15:47:41 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kU8Tr5vyXfht; Sun, 10 Nov 2013 15:47:41 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 612CF6064DE;
	Sun, 10 Nov 2013 15:47:37 +0000 (GMT)
X-Mailer: git-send-email 1.8.5.rc0.170.g772b8ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237586>

"git repo-config", "git tar-tree", "git lost-found" and "git
peek-remote" have all been deprecated since at least Git 1.5.4.

With Git 2.0 approaching, I think that would be a good point to remove
then completely, which is what this series does.

John Keeping (4):
  repo-config: remove deprecated alias for "git config"
  tar-tree: remove deprecated command
  lost-found: remove deprecated command
  peek-remote: remove deprecated alias of ls-remote

 .gitignore                             |  4 --
 Documentation/git-lost-found.txt       | 74 ------------------------------
 Documentation/git-peek-remote.txt      | 43 ------------------
 Documentation/git-repo-config.txt      | 23 ----------
 Documentation/git-tar-tree.txt         | 82 ----------------------------------
 Makefile                               |  3 --
 builtin.h                              |  1 -
 builtin/config.c                       |  6 ---
 builtin/tar-tree.c                     | 62 -------------------------
 command-list.txt                       |  4 --
 contrib/completion/git-completion.bash |  4 --
 contrib/examples/git-whatchanged.sh    |  4 +-
 git-lost-found.sh                      | 33 --------------
 git.c                                  |  3 --
 t/t4116-apply-reverse.sh               |  4 +-
 t/t5000-tar-tree.sh                    | 16 ++-----
 t/t5001-archive-attr.sh                | 10 -----
 17 files changed, 7 insertions(+), 369 deletions(-)
 delete mode 100644 Documentation/git-lost-found.txt
 delete mode 100644 Documentation/git-peek-remote.txt
 delete mode 100644 Documentation/git-repo-config.txt
 delete mode 100644 Documentation/git-tar-tree.txt
 delete mode 100755 git-lost-found.sh

-- 
1.8.5.rc0.170.g772b8ec
