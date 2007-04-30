From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Option --smtp-server clarified. The argument can be of two kinds
Date: Mon, 30 Apr 2007 15:37:28 +0300
Organization: Private
Message-ID: <3b2ixcl3.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 14:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiV9b-00058u-2i
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 14:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423204AbXD3MiR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 08:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423205AbXD3MiR
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 08:38:17 -0400
Received: from main.gmane.org ([80.91.229.2]:49205 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423204AbXD3MiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 08:38:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HiV8t-0000y9-Es
	for git@vger.kernel.org; Mon, 30 Apr 2007 14:38:11 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 14:38:11 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 14:38:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:i7S87mk2qyJnZoqhIWnsQwns9+Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45865>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 (1) eol whitespace removal

 (2) The first 3 lines are actual changes. The rest is due to formatting
 of the paragraph (fill).

 Documentation/git-send-email.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 795db87..070438d 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -54,7 +54,7 @@ The --cc option must be repeated for each user you want on the cc list.
 
 --in-reply-to::
 	Specify the contents of the first In-Reply-To header.
-	Subsequent emails will refer to the previous email 
+	Subsequent emails will refer to the previous email
 	instead of this if --chain-reply-to is set (the default)
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
@@ -68,13 +68,13 @@ The --cc option must be repeated for each user you want on the cc list.
 	all that is output.
 
 --smtp-server::
-	If set, specifies the outgoing SMTP server to use.  A full
-	pathname of a sendmail-like program can be specified instead;
-	the program must support the `-i` option.  Default value can
-	be specified by the 'sendemail.smtpserver' configuration
-	option; the built-in default is `/usr/sbin/sendmail` or
-	`/usr/lib/sendmail` if such program is available, or
-	`localhost` otherwise.
+	If set, specifies the outgoing SMTP server to use (like
+	smtp.example.com or raw IP address).  Alternatively the argument can
+	be a full pathname of a sendmail-like program.	The program must
+	support the `-i` option.  Default value can be specified by the
+	'sendemail.smtpserver' configuration option; the built-in default is
+	`/usr/sbin/sendmail` or `/usr/lib/sendmail` if such program is
+	available, or `localhost` otherwise.
 
 --subject::
    	Specify the initial subject of the email thread.
-- 
1.5.1.2.GIT
