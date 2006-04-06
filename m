From: Mike McCormack <mike@codeweavers.com>
Subject: [PATCH] Add documentation for git-imap-send.
Date: Thu, 06 Apr 2006 12:32:19 +0900
Organization: CodeWeavers
Message-ID: <44348BC3.8050901@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000100000608000908070009"
X-From: git-owner@vger.kernel.org Thu Apr 06 05:37:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRLJD-00015j-M3
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 05:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWDFDhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 23:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWDFDhT
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 23:37:19 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:28320 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751357AbWDFDhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 23:37:17 -0400
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1FRLJ5-0000Ni-2a
	for git@vger.kernel.org; Wed, 05 Apr 2006 22:37:16 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us, ko-kr
To: git@vger.kernel.org
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18464>

This is a multi-part message in MIME format.
--------------000100000608000908070009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by: Mike McCormack <mike@codeweavers.com>


---

  Documentation/git-imap-send.txt |   60 
+++++++++++++++++++++++++++++++++++++++
  1 files changed, 60 insertions(+), 0 deletions(-)
  create mode 100644 Documentation/git-imap-send.txt


--------------000100000608000908070009
Content-Type: text/x-patch;
 name="39f36da01434f743e36a7b0d6e8f625ad7785b2b.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="39f36da01434f743e36a7b0d6e8f625ad7785b2b.diff"

39f36da01434f743e36a7b0d6e8f625ad7785b2b
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
new file mode 100644
index 0000000..cfc0d88
--- /dev/null
+++ b/Documentation/git-imap-send.txt
@@ -0,0 +1,60 @@
+git-imap-send(1)
+================
+
+NAME
+----
+git-imap-send - Dump a mailbox from stdin into an imap folder
+
+
+SYNOPSIS
+--------
+'git-imap-send'
+
+
+DESCRIPTION
+-----------
+This command uploads a mailbox generated with git-format-patch
+into an imap drafts folder.  This allows patches to be sent as
+other email is sent with mail clients that cannot read mailbox
+files directly.
+
+Typical usage is something like:
+
+git-format-patch --signoff --stdout --attach origin | git-imap-send
+
+
+CONFIGURATION
+-------------
+
+git-imap-send requires the following values in the repository
+configuration file (shown with examples):
+
+[imap]
+    Folder = "INBOX.Drafts"
+
+[imap]
+    Tunnel = "ssh -q user@server.com /usr/bin/imapd ./Maildir 2> /dev/null"
+
+[imap]
+    Host = imap.server.com
+    User = bob
+    Password = pwd
+    Port = 143
+
+
+BUGS
+----
+Doesn't handle lines starting with "From " in the message body.
+
+
+Author
+------
+Derived from isync 1.0.1 by Mike McCormack.
+
+Documentation
+--------------
+Documentation by Mike McCormack
+
+GIT
+---
+Part of the gitlink:git[7] suite


--------------000100000608000908070009--
