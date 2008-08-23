From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK,GIT-GUI,DOCS) 7/7] Document new options of gui tools.
Date: Sat, 23 Aug 2008 12:33:01 +0400
Organization: TEPKOM
Message-ID: <200808231233.02019.angavrilov@gmail.com>
References: <200808231225.12596.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 10:34:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoZh-0004Zp-GV
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbYHWIdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbYHWIdR
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:33:17 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:8772 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbYHWIdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:33:16 -0400
Received: by fk-out-0910.google.com with SMTP id 18so488828fkq.5
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Ikb1GuPfSQBLmq5KfEkUaJ2cjh+ZkBktYQk6IVELArU=;
        b=b6B+RQimA9a20eFJgT7bvZ1J1QWGUXHKyrk/7xgLUmysaxC5TV0LkagDmN1Fo6HK2O
         qvwkWW7uSf4NpatWNF2jSmb1MDnuLIhJTYjMFm0nWK2tyLIrg1ETNmJfSh8pgVcEb+D9
         SbF08SPDQfu1OjjyJiJ7MG3DD2EAEFSsGdOhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=N8tu0l/bjUfD+hJLXIZ02kEFsKVsQULMCzzz2a+qppJroWpqS3GQnNDzSk33XVbAAX
         cAUiy9zoTIphAKpqghhhthx1tUW3UYF7pzD9dL8D2SecZvscyRlcBlp/K1pSKczDFef1
         O2Zi2vJdKVn8n2CTXskpsA23XOJXEP7NB3RqQ=
Received: by 10.180.236.20 with SMTP id j20mr1133104bkh.57.1219480394412;
        Sat, 23 Aug 2008 01:33:14 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id p9sm2028697fkb.5.2008.08.23.01.33.13
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 01:33:13 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808231225.12596.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93441>

Adds information on git-gui configuration, and new
git-gui blame & gitk command-line options.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 Documentation/config.txt  |   14 ++++++++++++++
 Documentation/git-gui.txt |    5 +++++
 Documentation/gitk.txt    |    5 +++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 676c39b..47bffea 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -772,6 +772,20 @@ gui.spellingdictionary::
 	the linkgit:git-gui[1]. When set to "none" spell checking is turned
 	off.
 
+gui.fastcopyblame::
+	If true, 'git gui blame' uses '-C' instead of '-C -C' for original location
+	detection. It makes blame significantly more usable on huge repositories.
+
+gui.copyblamethreshold::
+	Specifies the theshold to use in 'git gui blame' original location detection,
+	measured in alphanumeric characters. See the linkgit:git-blame[1] manual
+	for more information on copy detection.
+
+gui.blamehistoryctx::
+	Specifies the radius of history context (in days) to show in gitk for
+	the selected commit when the corresponding context menu item is invoked.
+	If this parameter is zero, all history is shown.
+
 help.browser::
 	Specify the browser that will be used to display help in the
 	'web' format. See linkgit:git-help[1].
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 0e650f4..39bdded 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -65,6 +65,11 @@ git gui blame v0.99.8 Makefile::
 	example the file is read from the object database and not
 	the working directory.
 
+git gui blame --line=100 Makefile::
+
+	Loads annotations as described above and automatically
+	scrolls the view to center on line 100.
+
 git gui citool::
 
 	Make one commit and return to the shell when it is complete.
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 6e827cd..8650809 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -49,6 +49,11 @@ frequently used options.
 	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
 	that modify the conflicted files.
 
+--select-commit=<ref>::
+
+	Automatically select the specified commit after loading the graph.
+	Default behavior is equivalent to specifying '--select-commit=HEAD'.
+
 <revs>::
 
 	Limit the revisions to show. This can be either a single revision
-- 
1.6.0.rc2
