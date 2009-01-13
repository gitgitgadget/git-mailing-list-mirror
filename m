From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] contrib/vim: change URL to point to the latest syntax files
Date: Tue, 13 Jan 2009 03:10:26 +0100
Message-ID: <200901130310.26727.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 03:11:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMYkh-0001pz-H0
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 03:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380AbZAMCKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 21:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754195AbZAMCKK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 21:10:10 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:59357 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbZAMCKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 21:10:08 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 60A40F8C7D8A;
	Tue, 13 Jan 2009 03:10:07 +0100 (CET)
Received: from [89.59.65.79] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LMYjH-00038N-00; Tue, 13 Jan 2009 03:10:07 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/85l3YRYciqG3BTz6XiKTkW9uEORP2pWoLqy9e
	kl7VzdE9SJ5fVZw5WJOhkOHay33ghkaCIM9n7Y1hlYjX7kuIxa
	MBhF+W7U1W0auc898d6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105443>

Vim's SVN repository doesn't offer the latest runtime files, since
normally they are only updated there on a release. Though currently
there is no difference between the SVN and HTTP/FTP version of the git
syntax files.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 contrib/vim/README |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/contrib/vim/README b/contrib/vim/README
index c487346..fca1e17 100644
--- a/contrib/vim/README
+++ b/contrib/vim/README
@@ -5,11 +5,13 @@ automatically.
 If you have an older version of vim, you can get the latest syntax
 files from the vim project:
 
-  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/git.vim
-  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitcommit.vim
-  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitconfig.vim
-  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitrebase.vim
-  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitsendemail.vim
+  http://ftp.vim.org/pub/vim/runtime/syntax/git.vim
+  http://ftp.vim.org/pub/vim/runtime/syntax/gitcommit.vim
+  http://ftp.vim.org/pub/vim/runtime/syntax/gitconfig.vim
+  http://ftp.vim.org/pub/vim/runtime/syntax/gitrebase.vim
+  http://ftp.vim.org/pub/vim/runtime/syntax/gitsendemail.vim
+
+These files are also available via FTP at the same location.
 
 To install:
 
-- 
1.6.1.35.g0c23
