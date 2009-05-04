From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/5] completion: add missing configuration variables to _git_config()
Date: Sun,  3 May 2009 23:25:31 -0700
Message-ID: <1241418335-18474-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 04 08:25:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0rcf-0004ml-K3
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 08:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbZEDGZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 02:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbZEDGZn
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 02:25:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:60755 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbZEDGZm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 02:25:42 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2785056rvb.1
        for <git@vger.kernel.org>; Sun, 03 May 2009 23:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=4zzX9WRof/MaL9KNplWn7UXgT+xuNy/xJOmDufoujsc=;
        b=yIaGuSAhUStWYriZVs0ay1Ec4ur0DXPcjeRsvU9VIWF64kUL/DRf45m9eZ6vR8Ultm
         wIUTVac3zUXTVifL/YB1Glk1TPqCSZb6TVGVI2UzZYtojqlLO+CCqSrEEBEK/kPmijU9
         7jNMlLm7uskDjU5hnDkdDPyG0DboPGk7xTjew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mUfsc+2LHUJp2l5msUBq3JsRy2saTdJiiKBhHOwhCeZ1oyUfUYoR39KXhB2c69+AZ2
         yH0oVAcOGNQBaV4XC/bJFbUp75fjOnKRTa5hYxxTGxvsZ85gryTWYmo8y37vaBgpXE+j
         ijWCItt4jJItOst0uvvRCQPyHsVTa3XeJTnm4=
Received: by 10.141.113.3 with SMTP id q3mr2003869rvm.82.1241418341880;
        Sun, 03 May 2009 23:25:41 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id f21sm14507265rvb.15.2009.05.03.23.25.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 23:25:38 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 03 May 2009 23:25:35 -0700
X-Mailer: git-send-email 1.6.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118205>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |   48 ++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1a90cb8..28682a7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1393,6 +1393,7 @@ _git_config ()
 		;;
 	esac
 	__gitcomp "
+		alias.
 		apply.whitespace
 		branch.autosetupmerge
 		branch.autosetuprebase
@@ -1410,6 +1411,9 @@ _git_config ()
 		color.diff.old
 		color.diff.plain
 		color.diff.whitespace
+		color.grep
+		color.grep.external
+		color.grep.match
 		color.interactive
 		color.interactive.header
 		color.interactive.help
@@ -1427,6 +1431,7 @@ _git_config ()
 		core.autocrlf
 		core.bare
 		core.compression
+		core.createObject
 		core.deltaBaseCacheLimit
 		core.editor
 		core.excludesfile
@@ -1457,11 +1462,20 @@ _git_config ()
 		diff.renameLimit
 		diff.renameLimit.
 		diff.renames
+		diff.suppressBlankEmpty
+		diff.tool
+		diff.wordRegex
+		difftool.prompt
 		fetch.unpackLimit
+		format.attach
+		format.cc
 		format.headers
 		format.numbered
 		format.pretty
+		format.signoff
+		format.subjectprefix
 		format.suffix
+		format.thread
 		gc.aggressiveWindow
 		gc.auto
 		gc.autopacklimit
@@ -1472,6 +1486,7 @@ _git_config ()
 		gc.rerereresolved
 		gc.rerereunresolved
 		gitcvs.allbinary
+		gitcvs.commitmsgannotation
 		gitcvs.dbTableNamePrefix
 		gitcvs.dbdriver
 		gitcvs.dbname
@@ -1506,13 +1521,23 @@ _git_config ()
 		http.sslVerify
 		i18n.commitEncoding
 		i18n.logOutputEncoding
+		imap.folder
+		imap.host
+		imap.pass
+		imap.port
+		imap.preformattedHTML
+		imap.sslverify
+		imap.tunnel
+		imap.user
 		instaweb.browser
 		instaweb.httpd
 		instaweb.local
 		instaweb.modulepath
 		instaweb.port
+		interactive.singlekey
 		log.date
 		log.showroot
+		mailmap.file
 		man.viewer
 		merge.conflictstyle
 		merge.log
@@ -1521,6 +1546,7 @@ _git_config ()
 		merge.tool
 		merge.verbosity
 		mergetool.keepBackup
+		mergetool.prompt
 		pack.compression
 		pack.deltaCacheLimit
 		pack.deltaCacheSize
@@ -1532,6 +1558,8 @@ _git_config ()
 		pack.windowMemory
 		pull.octopus
 		pull.twohead
+		push.default
+		rebase.stat
 		receive.denyCurrentBranch
 		receive.denyDeletes
 		receive.denyNonFastForwards
@@ -1540,6 +1568,26 @@ _git_config ()
 		repack.usedeltabaseoffset
 		rerere.autoupdate
 		rerere.enabled
+		sendemail.aliasesfile
+		sendemail.aliasesfiletype
+		sendemail.bcc
+		sendemail.cc
+		sendemail.cccmd
+		sendemail.chainreplyto
+		sendemail.confirm
+		sendemail.envelopesender
+		sendemail.multiedit
+		sendemail.signedoffbycc
+		sendemail.smtpencryption
+		sendemail.smtppass
+		sendemail.smtpserver
+		sendemail.smtpserverport
+		sendemail.smtpuser
+		sendemail.suppresscc
+		sendemail.suppressfrom
+		sendemail.thread
+		sendemail.to
+		sendemail.validate
 		showbranch.default
 		status.relativePaths
 		status.showUntrackedFiles
-- 
1.6.2.3
