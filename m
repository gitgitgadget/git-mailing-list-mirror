From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] update Documentation/diff-options.txt
Date: Fri, 07 Jul 2006 05:30:42 -0700
Message-ID: <7vr70xy4ul.fsf_-_@assigned-by-dhcp.cox.net>
References: <11522670452824-git-send-email-normalperson@yhbt.net>
	<11522670473116-git-send-email-normalperson@yhbt.net>
	<7v7j2p3eac.fsf@assigned-by-dhcp.cox.net>
	<20060707110123.GA23400@soma>
	<7vpsghzmr1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 07 14:31:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FypTr-0001qe-6D
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 14:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWGGMao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 08:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWGGMao
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 08:30:44 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:33259 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932142AbWGGMao (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 08:30:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707123043.PHHW12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 08:30:43 -0400
To: git@vger.kernel.org
In-Reply-To: <7vpsghzmr1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 07 Jul 2006 04:18:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23438>

We've been lazy and left things undocumented for some time.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/diff-options.txt |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f523ec2..fdcfd68 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -4,18 +4,21 @@
 -u::
 	Synonym for "-p".
 
+--raw::
+	Generate the raw format.
+
 --patch-with-raw::
-	Generate patch but keep also the default raw diff output.
+	Synonym for "-p --raw".
 
 --stat::
-	Generate a diffstat instead of a patch.
+	Generate a diffstat.
 
 --summary::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
 
 --patch-with-stat::
-	Generate patch and prepend its diffstat.
+	Synonym for "-p --stat".
 
 -z::
 	\0 line termination on output
@@ -26,11 +29,26 @@
 --name-status::
 	Show only names and status of changed files.
 
+--color::
+	Show colored diff.
+
+--no-color::
+	Turn off colored diff, even when the configuration file
+	gives the default to color output.
+
+--no-renames::
+	Turn off rename detection, even when the configuration
+	file gives the default to do so.
+
 --full-index::
 	Instead of the first handful characters, show full
 	object name of pre- and post-image blob on the "index"
 	line when generating a patch format output.	
 
+--binary::
+	In addition to --full-index, output "binary diff" that
+	can be applied with "git apply".
+
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
-- 
1.4.1.gfff4c
