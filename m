From: jidanni@jidanni.org
Subject: [PATCH/RFC] Documentation/git-mailsplit.txt: Emphasize -o more
Date: Tue, 13 Jan 2009 05:28:55 +0800
Message-ID: <877i50jjs8.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 22:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUMZ-00008y-5p
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbZALV27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbZALV27
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:28:59 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:53128
	"EHLO homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752806AbZALV26 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 16:28:58 -0500
Received: from jidanni.org (122-127-34-152.dynamic.hinet.net [122.127.34.152])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a5.g.dreamhost.com (Postfix) with ESMTP id 8B1E39C4E2
	for <git@vger.kernel.org>; Mon, 12 Jan 2009 13:28:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105386>

The need for -o cannot be overstated. Else the arguments get
interpreted differently. We also mention the output.
(By the way, "fatal: unknown option: -o" is seen if a space comes
after it.)

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-mailsplit.txt |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 5cc94ec..5dc24c9 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -13,10 +13,18 @@ DESCRIPTION
 -----------
 Splits a mbox file or a Maildir into a list of files: "0001" "0002" ..  in the
 specified directory so you can process them further from there.
+The number of files produced is printed to the standard output.
 
 IMPORTANT: Maildir splitting relies upon filenames being sorted to output
 patches in the correct order.
 
+REQUIRED OPTIONS
+-------
+-o<directory>::
+	Directory in which to place the individual messages.
+	-o is required or else arguments may be misinterpreted in a
+	backwards compatibility mode.
+
 OPTIONS
 -------
 <mbox>::
@@ -27,9 +35,6 @@ OPTIONS
 	Root of the Maildir to split. This directory should contain the cur, tmp
 	and new subdirectories.
 
--o<directory>::
-	Directory in which to place the individual messages.
-
 -b::
 	If any file doesn't begin with a From line, assume it is a
 	single mail message instead of signaling error.
-- 
1.6.0.6
