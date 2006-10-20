From: andyparkins@gmail.com
Subject: (unknown)
Date: Fri, 20 Oct 2006 14:25:50 +0100
Message-ID: <E1GauNi-0006un-00@dvr.360vision.com>
X-From: git-owner@vger.kernel.org Fri Oct 20 15:26:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GauNo-0002TS-5A
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 15:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946198AbWJTNZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 09:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946201AbWJTNZx
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 09:25:53 -0400
Received: from mail.360visiontechnology.com ([194.70.53.226]:57194 "EHLO
	369run02s.360vision.com") by vger.kernel.org with ESMTP
	id S1946198AbWJTNZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 09:25:52 -0400
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 20 Oct 2006 14:28:43 +0100
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GauNi-0006un-00
	for <git@vger.kernel.org>; Fri, 20 Oct 2006 14:25:50 +0100
X-OriginalArrivalTime: 20 Oct 2006 13:28:43.0862 (UTC) FILETIME=[AA01FF60:01C6F44B]
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29463>

>From 9c128bc4b9b85385b7b98ceae0c89283d70e5d45 Mon Sep 17 00:00:00 2001
From: Andy Parkins <andyparkins@gmail.com>
Date: Fri, 20 Oct 2006 14:25:48 +0100
Subject: [PATCH] Remove git-send-email references from documentation
To: git@vger.kernel.org
MIME-Version: 1.0
X-TUID: 17b00343571b31b8
X-UID: 99
X-Length: 1933
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_c5MOFrK5Yix34S1"
Message-Id: <200610201425.48598.andyparkins@gmail.com>

This is a multi-part message in MIME format.
--Boundary-00=_c5MOFrK5Yix34S1
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

--Boundary-00=_c5MOFrK5Yix34S1
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
 

--Boundary-00=_c5MOFrK5Yix34S1--
