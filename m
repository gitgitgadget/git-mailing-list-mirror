From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation/git-archive: spell --worktree-attributes correctly
Date: Mon, 10 Jan 2011 13:57:43 +0100
Message-ID: <70050800dea108b9e371210fc85b45cb6ba4d691.1294664224.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 10 13:58:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcHK0-00067u-0N
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 13:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab1AJM5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 07:57:46 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:13952 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907Ab1AJM5p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 07:57:45 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 10 Jan
 2011 13:57:43 +0100
Received: from localhost.localdomain (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 10 Jan
 2011 13:57:43 +0100
X-Mailer: git-send-email 1.7.4.rc1.309.g58aa0
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164874>

The --worktree-attributes option was correctly documented in ba053ea
(archive: do not read .gitattributes in working directory,
2009-04-18).  However, later in 9b4c8b0 (archive documentation:
attributes are taken from the tree by default, 2010-02-10) the
misspelling "--work-tree-attributes" was used to refer to it.  Fix
this.

Noticed-by: Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-archive.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 4163a1b..bf5037a 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -116,7 +116,7 @@ Note that attributes are by default taken from the `.gitattributes` files
 in the tree that is being archived.  If you want to tweak the way the
 output is generated after the fact (e.g. you committed without adding an
 appropriate export-ignore in its `.gitattributes`), adjust the checked out
-`.gitattributes` file as necessary and use `--work-tree-attributes`
+`.gitattributes` file as necessary and use `--worktree-attributes`
 option.  Alternatively you can keep necessary attributes that should apply
 while archiving any tree in your `$GIT_DIR/info/attributes` file.
 
-- 
1.7.4.rc1.309.g58aa0
