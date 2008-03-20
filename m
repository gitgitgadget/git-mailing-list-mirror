From: Victor Bogado da Silva Lins <victor@bogado.net>
Subject: [PATCH] Easier setup for the vim contribs.
Date: Thu, 20 Mar 2008 13:42:44 -0300
Message-ID: <1206031364.1717.11.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 17:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcNu9-00019o-48
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 17:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbYCTQpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 12:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbYCTQpd
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 12:45:33 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:45575 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbYCTQpc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 12:45:32 -0400
Received: from spunkymail-a16.g.dreamhost.com (sd-green-bigip-81.dreamhost.com [208.97.132.81])
	by hapkido.dreamhost.com (Postfix) with ESMTP id BB65417AF6F
	for <git@vger.kernel.org>; Thu, 20 Mar 2008 09:45:31 -0700 (PDT)
Received: from [127.0.0.1] (unknown [139.82.86.2])
	by spunkymail-a16.g.dreamhost.com (Postfix) with ESMTP id 665787B6ED
	for <git@vger.kernel.org>; Thu, 20 Mar 2008 09:43:30 -0700 (PDT)
X-Mailer: Evolution 2.8.0 (2.8.0-40.el5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77669>

Just copy all files in the vim contrib directory to your .vim and it will configure the syntax.
---
 contrib/vim/README                 |   15 ++++++++-------
 contrib/vim/ftdetect/gitcommit.vim |    1 +
 2 files changed, 9 insertions(+), 7 deletions(-)
 create mode 100644 contrib/vim/ftdetect/gitcommit.vim

diff --git a/contrib/vim/README b/contrib/vim/README
index 9e7881f..7981765 100644
--- a/contrib/vim/README
+++ b/contrib/vim/README
@@ -1,8 +1,9 @@
 To syntax highlight git's commit messages, you need to:
-  1. Copy syntax/gitcommit.vim to vim's syntax directory:
-     $ mkdir -p $HOME/.vim/syntax
-     $ cp syntax/gitcommit.vim $HOME/.vim/syntax
-  2. Auto-detect the editing of git commit files:
-     $ cat >>$HOME/.vimrc <<'EOF'
-     autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
-     EOF
+  1.  Copy syntax/gitcommit.vim to vim's syntax directory:
+      $ mkdir -p $HOME/.vim/syntax
+      $ cp syntax/gitcommit.vim $HOME/.vim/syntax
+  2.  Auto-detect the editing of git commit files:
+      $ mkdir -p $HOME/.vim/ftdetect
+	  $ cp ftdetect/gitcommit.vim $HOME/.vim/ftdetect
+  2b. Alternatively you can add the detection code to your vimrc file
+	  $ cat ftdetect/gitcommit.vim >> $HOME/.vimrc
diff --git a/contrib/vim/ftdetect/gitcommit.vim b/contrib/vim/ftdetect/gitcommit.vim
new file mode 100644
index 0000000..fed4684
--- /dev/null
+++ b/contrib/vim/ftdetect/gitcommit.vim
@@ -0,0 +1 @@
+autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
-- 
1.5.5.rc0
