From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 1/2] bash completion: Sort config completion variables
Date: Mon, 15 Dec 2008 10:45:48 -0700
Message-ID: <1229363149-37757-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 15 18:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCHXQ-00056T-7y
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 18:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949AbYLORp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 12:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753988AbYLORpz
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 12:45:55 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:57484 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbYLORpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 12:45:55 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1157504yxm.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 09:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PfmugsIVCaq/T2nbjYYnqZUWedlqy/6WDFwnHuOmOUM=;
        b=O67/6cEDk1EIXowRsYG8sHFwuIa/1PDmv3D7Yx1pmoWnhjibZrnrc7uoZcx+dDhJbT
         3f/BZjYGA0h59OnhTMLON3iGjC6AnTlpEpkxr1wBB/pFCNZ0VjmXAhlUiANiEbc6JlSd
         4n8vIaYHDttdgNpve8TVzTwNhDuQirl4NF9xY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mUQ7bCLBXUw6w6Sc/JEtW5F4aFnTotdcQ4fYfhyWY07CGvevGFDb/YguaIKXe/RNH+
         xLCQTFCnYiCshsoOSkRr3YuoG7N5bQUSHx48nbJiH6owGl/5vWyc1W5Yk96TheXtmIse
         pbGKabLzAmCERhwvRBRZXR9E2ifMpFJ6wBYeY=
Received: by 10.100.126.15 with SMTP id y15mr4777407anc.38.1229363153617;
        Mon, 15 Dec 2008 09:45:53 -0800 (PST)
Received: from localhost.localdomain ([12.25.108.178])
        by mx.google.com with ESMTPS id 9sm8734004yxs.35.2008.12.15.09.45.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Dec 2008 09:45:52 -0800 (PST)
X-Mailer: git-send-email 1.6.1.rc2.20.gde0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103192>

Sort the config variables to make sync-ing them with
Documents/config.txt easier in the future.

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   77 ++++++++++++++++---------------
 1 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c79c98f..79cbed5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1206,84 +1206,87 @@ _git_config ()
 	esac
 	__gitcomp "
 		apply.whitespace
-		core.fileMode
-		core.gitProxy
-		core.ignoreStat
-		core.preferSymlinkRefs
-		core.logAllRefUpdates
-		core.loosecompression
-		core.repositoryFormatVersion
-		core.sharedRepository
-		core.warnAmbiguousRefs
-		core.compression
-		core.packedGitWindowSize
-		core.packedGitLimit
 		clean.requireForce
 		color.branch
 		color.branch.current
 		color.branch.local
-		color.branch.remote
 		color.branch.plain
+		color.branch.remote
 		color.diff
-		color.diff.plain
-		color.diff.meta
+		color.diff.commit
 		color.diff.frag
-		color.diff.old
+		color.diff.meta
 		color.diff.new
-		color.diff.commit
+		color.diff.old
+		color.diff.plain
 		color.diff.whitespace
 		color.pager
 		color.status
-		color.status.header
 		color.status.added
 		color.status.changed
+		color.status.header
 		color.status.untracked
+		core.compression
+		core.fileMode
+		core.gitProxy
+		core.ignoreStat
+		core.logAllRefUpdates
+		core.loosecompression
+		core.packedGitLimit
+		core.packedGitWindowSize
+		core.preferSymlinkRefs
+		core.repositoryFormatVersion
+		core.sharedRepository
+		core.warnAmbiguousRefs
 		diff.renameLimit
 		diff.renames
 		fetch.unpackLimit
 		format.headers
 		format.subjectprefix
-		gitcvs.enabled
-		gitcvs.logfile
-		gitcvs.allbinary
-		gitcvs.dbname gitcvs.dbdriver gitcvs.dbuser gitcvs.dbpass
-		gitcvs.dbtablenameprefix
 		gc.packrefs
 		gc.reflogexpire
 		gc.reflogexpireunreachable
 		gc.rerereresolved
 		gc.rerereunresolved
-		http.sslVerify
-		http.sslCert
-		http.sslKey
-		http.sslCAInfo
-		http.sslCAPath
-		http.maxRequests
+		gitcvs.allbinary
+		gitcvs.dbdriver
+		gitcvs.dbname
+		gitcvs.dbpass
+		gitcvs.dbtablenameprefix
+		gitcvs.dbuser
+		gitcvs.enabled
+		gitcvs.logfile
 		http.lowSpeedLimit
 		http.lowSpeedTime
+		http.maxRequests
 		http.noEPSV
+		http.sslCAInfo
+		http.sslCAPath
+		http.sslCert
+		http.sslKey
+		http.sslVerify
 		i18n.commitEncoding
 		i18n.logOutputEncoding
 		log.showroot
-		merge.tool
 		merge.summary
+		merge.tool
 		merge.verbosity
-		pack.window
-		pack.depth
-		pack.windowMemory
 		pack.compression
-		pack.deltaCacheSize
 		pack.deltaCacheLimit
+		pack.deltaCacheSize
+		pack.depth
+		pack.window
+		pack.windowMemory
 		pull.octopus
 		pull.twohead
+		receive.denyNonFastForwards
+		receive.unpackLimit
 		repack.useDeltaBaseOffset
 		showbranch.default
 		tar.umask
 		transfer.unpackLimit
-		receive.unpackLimit
-		receive.denyNonFastForwards
-		user.name
 		user.email
+		user.name
 		user.signingkey
 		branch. remote.
 	"
-- 
1.6.1.rc2.20.gde0d
