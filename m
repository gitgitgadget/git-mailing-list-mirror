From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Change options to alphabetical order
Date: Mon, 27 Aug 2007 08:55:26 +0300
Organization: Private
Message-ID: <6431frn5.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 07:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPXZF-000267-AX
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 07:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbXH0FzN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 01:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbXH0FzN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 01:55:13 -0400
Received: from main.gmane.org ([80.91.229.2]:39993 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804AbXH0FzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 01:55:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IPXZ0-0002Ff-1b
	for git@vger.kernel.org; Mon, 27 Aug 2007 07:55:02 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 07:55:02 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 07:55:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:sNpLH6iqHCDX7ezPpD1/d4/8aR4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56766>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-tag.txt |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 74a7e2e..c5ed80f 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -38,20 +38,15 @@ OPTIONS
 -a::
 	Make an unsigned, annotated tag object
 
--s::
-	Make a GPG-signed tag, using the default e-mail address's key
-
--u <key-id>::
-	Make a GPG-signed tag, using the given key
+-d::
+	Delete existing tags with the given names.
 
 -f::
 	Replace an existing tag with the given name (instead of failing)
 
--d::
-	Delete existing tags with the given names.
-
--v::
-	Verify the gpg signature of given the tag
+-F <file>::
+	Take the tag message from the given file.  Use '-' to
+	read the message from the standard input.
 
 -l <pattern>::
 	List tags that match the given pattern (or all if no pattern is given).
@@ -59,9 +54,14 @@ OPTIONS
 -m <msg>::
 	Use the given tag message (instead of prompting)
 
--F <file>::
-	Take the tag message from the given file.  Use '-' to
-	read the message from the standard input.
+-s::
+	Make a GPG-signed tag, using the default e-mail address's key
+
+-u <key-id>::
+	Make a GPG-signed tag, using the given key
+
+-v::
+	Verify the gpg signature of given the tag
 
 CONFIGURATION
 -------------
-- 
1.5.3.rc5
