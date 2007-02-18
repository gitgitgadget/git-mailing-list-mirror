From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH] Documentation/i18n.txt: it is i18n.commitencoding not core.commitencoding
Date: Sun, 18 Feb 2007 10:36:51 +0100
Message-ID: <20070218093651.10173.51237.stgit@c165>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 18 10:36:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIiTZ-0005m5-7D
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 10:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130AbXBRJgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 04:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933162AbXBRJgy
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 04:36:54 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:58446 "EHLO
	mxfep02.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933130AbXBRJgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 04:36:53 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20070218093651.YAXF2832.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Sun, 18 Feb 2007 10:36:51 +0100
Received: from c-6466e455.09-360-6c6b701.cust.bredbandsbolaget.se (HELO c165) ([85.228.102.100])
  by ironport.bredband.com with ESMTP; 18 Feb 2007 10:36:51 +0100
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1HIiTT-0002eC-00
	for <git@vger.kernel.org>; Sun, 18 Feb 2007 10:36:51 +0100
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40070>


Similarly for i18n.logoutputencoding.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>

---

 Documentation/i18n.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index b4cbb38..b95f99b 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -25,15 +25,15 @@ mind.
   an warning if the commit log message given to it does not look
   like a valid UTF-8 string, unless you explicitly say your
   project uses a legacy encoding.  The way to say this is to
-  have core.commitencoding in `.git/config` file, like this:
+  have i18n.commitencoding in `.git/config` file, like this:
 +
 ------------
-[core]
+[i18n]
 	commitencoding = ISO-8859-1
 ------------
 +
 Commit objects created with the above setting record the value
-of `core.commitencoding` in its `encoding` header.  This is to
+of `i18n.commitencoding` in its `encoding` header.  This is to
 help other people who look at them later.  Lack of this header
 implies that the commit log message is encoded in UTF-8.
 
@@ -41,15 +41,15 @@ implies that the commit log message is encoded in UTF-8.
   header of a commit object, and tries to re-code the log
   message into UTF-8 unless otherwise specified.  You can
   specify the desired output encoding with
-  `core.logoutputencoding` in `.git/config` file, like this:
+  `i18n.logoutputencoding` in `.git/config` file, like this:
 +
 ------------
-[core]
+[i18n]
 	logoutputencoding = ISO-8859-1
 ------------
 +
 If you do not have this configuration variable, the value of
-`core.commitencoding` is used instead.
+`i18n.commitencoding` is used instead.
 
 Note that we deliberately chose not to re-code the commit log
 message when a commit is made to force UTF-8 at the commit
