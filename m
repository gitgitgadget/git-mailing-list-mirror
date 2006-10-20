From: andyparkins@gmail.com
Subject: (unknown)
Date: Fri, 20 Oct 2006 15:24:23 +0100
Message-ID: <E1GavIN-0007Vi-00@dvr.360vision.com>
X-From: git-owner@vger.kernel.org Fri Oct 20 16:24:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GavIT-0006nE-1F
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992625AbWJTOY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992626AbWJTOY0
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:24:26 -0400
Received: from mail.360visiontechnology.com ([194.70.53.226]:21870 "EHLO
	369run02s.360vision.com") by vger.kernel.org with ESMTP
	id S2992625AbWJTOYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 10:24:25 -0400
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 20 Oct 2006 15:27:17 +0100
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GavIN-0007Vi-00
	for <git@vger.kernel.org>; Fri, 20 Oct 2006 15:24:23 +0100
X-OriginalArrivalTime: 20 Oct 2006 14:27:17.0699 (UTC) FILETIME=[D86AF930:01C6F453]
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29475>

>From 9c128bc4b9b85385b7b98ceae0c89283d70e5d45 Mon Sep 17 00:00:00 2001
From: Andy Parkins <andyparkins@gmail.com>
Date: Fri, 20 Oct 2006 15:24:22 +0100
Subject: [PATCH] Remove git-send-email references from documentation
MIME-Version: 1.0
X-TUID: 1fbae8e75caaf795
X-Length: 1933
To: git@vger.kernel.org
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WwNOFc8Re2ORHlu"
Message-Id: <200610201524.22493.andyparkins@gmail.com>

This is a multi-part message in MIME format.
--Boundary-00=_WwNOFc8Re2ORHlu
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


git-send-email doesn't exist; so don't refer to it in the documentation.

Perhaps git-send-email.perl is meant to do this job?  It runs with an error.
Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Documentation/git-format-patch.txt |    2 +-
 Documentation/git.txt              |    3 ---
 2 files changed, 1 insertions(+), 4 deletions(-)

--Boundary-00=_WwNOFc8Re2ORHlu
Content-Type: text/x-patch;
  name="9c128bc4b9b85385b7b98ceae0c89283d70e5d45.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="9c128bc4b9b85385b7b98ceae0c89283d70e5d45.diff"

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 67425dc..9257030 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -112,7 +112,7 @@ git-format-patch -M -B origin::
 
 See Also
 --------
-gitlink:git-am[1], gitlink:git-send-email[1]
+gitlink:git-am[1]
 
 
 Author
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3af6fc6..1f60d3f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -478,9 +478,6 @@ gitlink:git-request-pull[1]::
 gitlink:git-rev-parse[1]::
 	Pick out and massage parameters.
 
-gitlink:git-send-email[1]::
-	Send patch e-mails out of "format-patch --mbox" output.
-
 gitlink:git-symbolic-ref[1]::
 	Read and modify symbolic refs.
 

--Boundary-00=_WwNOFc8Re2ORHlu--
