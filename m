From: Tommi Virtanen <tv@debian.org>
Subject: [PATCH] git bugfixes and cleanups, mainly Debian things
Date: Fri, 26 Aug 2005 14:00:04 +0300
Message-ID: <11250540043384-git-send-email-tv@debian.org>
References: <11250540042850-git-send-email-tv@debian.org>
Reply-To: Tommi Virtanen <tv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:05:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8bwh-0006bq-OI
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVHZLAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbVHZLAS
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:00:18 -0400
Received: from i1.inoi.fi ([194.100.97.46]:55453 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S1751525AbVHZLAR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 07:00:17 -0400
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 8D9A0FEDD2;
	Fri, 26 Aug 2005 14:00:18 +0300 (EEST)
Received: from pooch.inoi.fi (GMMCMXXXIV.dsl.saunalahti.fi [85.76.243.135])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 2FF1DFF9DF;
	Fri, 26 Aug 2005 14:00:18 +0300 (EEST)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id 66C0DBA06A;
	Fri, 26 Aug 2005 14:00:04 +0300 (EEST)
In-Reply-To: <11250540042850-git-send-email-tv@debian.org>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7802>

Point Debian doc-base at the right files. Clean up.

Signed-off-by: Tommi Virtanen <tv@debian.org>

---
commit f4d2a91b2946330c4bf240cf73e64684cba43ddf
tree 8ccdaef874ab4161b7c22206672376fdfc338689
parent 62e16702fdb0cdc13822470f3a19b36956fd0d78
author Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 12:32:28 +0300
committer Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 12:32:28 +0300

 debian/git-core.doc-base |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/debian/git-core.doc-base b/debian/git-core.doc-base
--- a/debian/git-core.doc-base
+++ b/debian/git-core.doc-base
@@ -1,6 +1,5 @@
 Document: git-core
-Title: git-core
-Author: 
+Title: git reference
 Abstract: This manual describes git
 Section: Devel
 
@@ -9,4 +8,4 @@ Index: /usr/share/doc/git-core/git.html
 Files: /usr/share/doc/git-core/*.html
 
 Format: text
-Files: /usr/share/doc/git-core/git-core.txt
+Files: /usr/share/doc/git-core/git.txt*
