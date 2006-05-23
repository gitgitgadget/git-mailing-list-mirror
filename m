From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Make more commands builtin
Date: Tue, 23 May 2006 10:31:13 +0200
Message-ID: <26310.811765916$1148373101@news.gmane.org>
Reply-To: Patches/0001-Builtin-git-ls-files.txt@bohr.gbar.dtu.dk
X-From: git-owner@vger.kernel.org Tue May 23 10:31:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiSIa-0001bZ-L4
	for gcvg-git@gmane.org; Tue, 23 May 2006 10:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWEWIbX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 04:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWEWIbX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 04:31:23 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:53995 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932109AbWEWIbW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 04:31:22 -0400
Received: (qmail 8456 invoked by uid 5842); 23 May 2006 10:31:20 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20579>

 Makefile                               |   26 +++++++++++++++-----------
 apply.c => builtin-apply.c             |    3 ++-
 commit-tree.c => builtin-commit-tree.c |    3 ++-
 diff-files.c => builtin-diff-files.c   |    3 ++-
 diff-index.c => builtin-diff-index.c   |    3 ++-
 diff-stages.c => builtin-diff-stages.c |    3 ++-
 diff-tree.c => builtin-diff-tree.c     |    3 ++-
 ls-files.c => builtin-ls-files.c       |    3 ++-
 ls-tree.c => builtin-ls-tree.c         |    3 ++-
 read-tree.c => builtin-read-tree.c     |    3 ++-
 show-branch.c => builtin-show-branch.c |    3 ++-
 tar-tree.c => builtin-tar-tree.c       |    3 ++-
 builtin.h                              |   12 ++++++++++++
 git.c                                  |   13 ++++++++++++-

I've tried to follow the trend of making commands builtin.
All patches have the same form.  This is my second use
of git-send-email, so this might come out wrong.

Peter Eriksen <s022018@student.dtu.dk>
