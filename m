From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Make more commands builtin
Date: Tue, 23 May 2006 14:15:28 +0200
Message-ID: <15865.7899396077$1148386583@news.gmane.org>
Reply-To: s022018@student.dtu.dk
X-From: git-owner@vger.kernel.org Tue May 23 14:16:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiVnz-0002bL-Co
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWEWMPt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWEWMPr
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:15:47 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:49343 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932187AbWEWMPi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:15:38 -0400
Received: (qmail 5904 invoked by uid 5842); 23 May 2006 14:15:36 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20592>

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
 14 files changed, 61 insertions(+), 23 deletions(-)

Junio, I've formatted this batch of patches with -M, so
they are easier to read.  It seems there were some problems
with sending the last batch (patch 1 and 6 hasn't arrived),
but this should work, since I tested it by sending the
batch to myself first.

Sorry for the noise.

Regards,

Peter Eriksen
