From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: add man page for "git bisect--helper"
Date: Tue, 14 Apr 2009 00:00:29 +0200
Message-ID: <20090414000029.f7b4e880.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 00:03:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtUFB-0006kz-Lf
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 00:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbZDMWBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 18:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbZDMWBg
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 18:01:36 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:35314 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbZDMWBg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 18:01:36 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 9BCF0D480CB;
	Tue, 14 Apr 2009 00:01:28 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with SMTP id 95770D4803C;
	Tue, 14 Apr 2009 00:01:25 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116492>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect--helper.txt |   41 ++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-bisect--helper.txt

diff --git a/Documentation/git-bisect--helper.txt b/Documentation/git-bisect--helper.txt
new file mode 100644
index 0000000..c6ae3f5
--- /dev/null
+++ b/Documentation/git-bisect--helper.txt
@@ -0,0 +1,41 @@
+git-bisect--helper(1)
+=====================
+
+NAME
+----
+git-bisect--helper - helper command for git bisect
+
+SYNOPSIS
+--------
+'git bisect--helper' --next-vars
+
+DESCRIPTION
+-----------
+
+This plumbing command implements some 'git bisect' related
+functionality in C code.
+
+It was created to make it easier to move bisect functionality from the
+"git-bisect.sh" shell script to compiled C code.
+
+OPTIONS
+-------
+--next-vars::
+	Read bisect related references in 'refs/bisect' and use them
+	to compute next bisection point information. Then output this
+	information so that it can easily and safely be eval'ed by a
+	shell script.
+
+Author
+------
+Written by Christian Couder <chriscool@tuxfamily.org> and the git-list
+<git@vger.kernel.org>.
+
+Documentation
+-------------
+Documentation by Christian Couder <chriscool@tuxfamily.org> and the
+git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.6.2.2.572.g4420a
