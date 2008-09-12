From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 0/6] Submodule support for git mv and git rm
Date: Fri, 12 Sep 2008 23:08:51 +0200
Message-ID: <20080912210817.31628.69014.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 23:10:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeFu1-0006CQ-Cq
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 23:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874AbYILVI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 17:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbYILVI5
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 17:08:57 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:53659 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755972AbYILVI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 17:08:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 23E862AC749;
	Fri, 12 Sep 2008 23:08:52 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95763>

This is a resend of the previously submitted series, with basically
no changes since the previous submission.

---

Petr Baudis (6):
      git submodule add: Fix naming clash handling
      t7400: Add short "git submodule add" testsuite
      t7403: Submodule git mv, git rm testsuite
      git mv: Support moving submodules
      git rm: Support for removing submodules
      submodule.*: Introduce simple C interface for submodule lookup by path


 Documentation/git-rm.txt   |    6 +
 Makefile                   |    2 
 builtin-mv.c               |   37 ++++++-
 builtin-rm.c               |   65 ++++++++++--
 git-submodule.sh           |   15 ++-
 submodule.c                |   50 +++++++++
 submodule.h                |    8 +
 t/t7400-submodule-basic.sh |   39 +++++++
 t/t7403-submodule-mvrm.sh  |  242 ++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 443 insertions(+), 21 deletions(-)
 create mode 100644 submodule.c
 create mode 100644 submodule.h
 create mode 100755 t/t7403-submodule-mvrm.sh
