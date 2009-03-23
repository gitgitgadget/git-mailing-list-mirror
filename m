From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH 4/5] Documentation: minor grammatical fixes in git-check-attr.txt.
Date: Sun, 22 Mar 2009 18:00:16 -0700
Message-ID: <1237770017-7168-5-git-send-email-dmellor@whistlingcat.com>
References: <1237770017-7168-1-git-send-email-dmellor@whistlingcat.com>
 <1237770017-7168-2-git-send-email-dmellor@whistlingcat.com>
 <1237770017-7168-3-git-send-email-dmellor@whistlingcat.com>
 <1237770017-7168-4-git-send-email-dmellor@whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 23 02:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlYZ8-0004Ed-B6
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 02:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269AbZCWBAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 21:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757265AbZCWBA3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 21:00:29 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:42007 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160AbZCWBAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 21:00:21 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 646F3488008;
	Sun, 22 Mar 2009 18:00:19 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 7CA1038E7584;
	Sun, 22 Mar 2009 18:00:18 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id 1AEB117A62; Sun, 22 Mar 2009 18:00:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1237770017-7168-4-git-send-email-dmellor@whistlingcat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114223>


Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-check-attr.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 8c2ac12..50824e3 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-For every pathname, this command will list if each attr is 'unspecified',
+For every pathname, this command will list if each attribute is 'unspecified',
 'set', or 'unset' as a gitattribute on that pathname.
 
 OPTIONS
@@ -23,11 +23,11 @@ OPTIONS
 	Read file names from stdin instead of from the command-line.
 
 -z::
-	Only meaningful with `--stdin`; paths are separated with
-	NUL character instead of LF.
+	Only meaningful with `--stdin`; paths are separated with a
+	NUL character instead of a linefeed character.
 
 \--::
-	Interpret all preceding arguments as attributes, and all following
+	Interpret all preceding arguments as attributes and all following
 	arguments as path names. If not supplied, only the first argument will
 	be treated as an attribute.
 
@@ -37,12 +37,12 @@ OUTPUT
 The output is of the form:
 <path> COLON SP <attribute> COLON SP <info> LF
 
-Where <path> is the path of a file being queried, <attribute> is an attribute
+<path> is the path of a file being queried, <attribute> is an attribute
 being queried and <info> can be either:
 
 'unspecified';; when the attribute is not defined for the path.
-'unset';;	when the attribute is defined to false.
-'set';;		when the attribute is defined to true.
+'unset';;	when the attribute is defined as false.
+'set';;		when the attribute is defined as true.
 <value>;;	when a value has been assigned to the attribute.
 
 EXAMPLES
@@ -69,7 +69,7 @@ org/example/MyClass.java: diff: java
 org/example/MyClass.java: myAttr: set
 ---------------
 
-* Listing attribute for multiple files:
+* Listing an attribute for multiple files:
 ---------------
 $ git check-attr myAttr -- org/example/MyClass.java org/example/NoMyAttr.java
 org/example/MyClass.java: myAttr: set
-- 
1.6.2.1
