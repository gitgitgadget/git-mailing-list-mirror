From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Fix some typos.
Date: Mon, 7 Jan 2008 22:43:27 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080107214326.GA15651@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 22:44:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBzlG-0004YQ-Ns
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbYAGVnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 16:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbYAGVnb
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:43:31 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:37181 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbYAGVna (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 16:43:30 -0500
Received: from localhost.localdomain (xdsl-87-78-66-129.netcologne.de [87.78.66.129])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 853C340000E3A
	for <git@vger.kernel.org>; Mon,  7 Jan 2008 22:43:28 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1JBzkl-00034j-62
	for git@vger.kernel.org; Mon, 07 Jan 2008 22:43:27 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69816>

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---

 Documentation/gitcli.txt                |    2 +-
 Documentation/technical/api-diff.txt    |    6 +++---
 Documentation/technical/pack-format.txt |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index b7dcf9c..07899ec 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -95,7 +95,7 @@ $ git foo -oArg
 $ git foo -o Arg
 ----------------------------
 
-However, this is *NOT* allowed for switches with an optionnal value, where the
+However, this is *NOT* allowed for switches with an optional value, where the
 'sticked' form must be used:
 ----------------------------
 $ git describe --abbrev HEAD     # correct
diff --git a/Documentation/technical/api-diff.txt b/Documentation/technical/api-diff.txt
index 822609b..83b007e 100644
--- a/Documentation/technical/api-diff.txt
+++ b/Documentation/technical/api-diff.txt
@@ -102,13 +102,13 @@ Notable members are:
 	and copies.
 
 `abbrev`::
-	Number of hexdigits to abbrevate raw format output to.
+	Number of hexdigits to abbreviate raw format output to.
 
 `pickaxe`::
 	A constant string (can and typically does contain newlines to
 	look for a block of text, not just a single line) to filter out
 	the filepairs that do not change the number of strings contained
-	in its preimage and postmage of the diff_queue.
+	in its preimage and postimage of the diff_queue.
 
 `flags`::
 	This is mostly a collection of boolean options that affects the
@@ -149,7 +149,7 @@ REVERSE_DIFF;;
 
 EXIT_WITH_STATUS;;
 	For communication between the calling program and the options
-	parser; tell the calling program to signal the presense of
+	parser; tell the calling program to signal the presence of
 	difference using program exit code.
 
 HAS_CHANGES;;
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index a80baa4..aa87756 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -125,7 +125,7 @@ Pack file entry: <+
 
   - A table of 4-byte CRC32 values of the packed object data.
     This is new in v2 so compressed data can be copied directly
-    from pack to pack during repacking withough undetected
+    from pack to pack during repacking without undetected
     data corruption.
 
   - A table of 4-byte offset values (in network byte order).
-- 
1.5.4.rc2.17.g257f
