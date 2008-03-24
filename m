From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: [PATCH] Documentation: git-tag '-m' implies '-a'
Date: Mon, 24 Mar 2008 15:41:54 +0100
Message-ID: <47E7BDB2.3030304@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 15:42:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdnss-0003An-8i
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 15:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760320AbYCXOl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 10:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760331AbYCXOl6
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 10:41:58 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:53584 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760320AbYCXOl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 10:41:58 -0400
Received: from [84.176.80.166] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Jdns4-0006qw-Ka
	for git@vger.kernel.org; Mon, 24 Mar 2008 15:41:56 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78042>

Described that '-a' is implied when '-m' or '-F' is present.
---
 Documentation/git-tag.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b62a3d1..c22fb71 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -26,6 +26,9 @@ creates a 'tag' object, and requires the tag message.  
Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user 
to type
 in the tag message.
 
+If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
+are absent, `-a` is implied.
+
 Otherwise just the SHA1 object name of the commit object is
 written (i.e. a lightweight tag).
 
@@ -68,10 +71,14 @@ OPTIONS
     Use the given tag message (instead of prompting).
     If multiple `-m` options are given, there values are
     concatenated as separate paragraphs.
+    Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
+    is given.
 
 -F <file>::
     Take the tag message from the given file.  Use '-' to
     read the message from the standard input.
+    Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
+    is given.
 
 CONFIGURATION
 -------------
-- 
1.5.4.950.ga176
