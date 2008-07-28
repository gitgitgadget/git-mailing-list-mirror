From: =?windows-1250?Q?Jurko_Gospodneti=E6?= <jurko.gospodnetic@docte.hr>
Subject: [PATCH] Updated the Documentation/config.txt core.autocrlf configuration
 setting documentation
Date: Mon, 28 Jul 2008 13:48:14 +0200
Message-ID: <g6kbm1$gbp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030700040605070409050108"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 13:49:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNREG-0002ox-7i
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 13:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbYG1Ls2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 07:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbYG1Ls2
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 07:48:28 -0400
Received: from main.gmane.org ([80.91.229.2]:40295 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbYG1Ls1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 07:48:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KNRDG-0006nz-4v
	for git@vger.kernel.org; Mon, 28 Jul 2008 11:48:26 +0000
Received: from 87.252.133.29 ([87.252.133.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 11:48:26 +0000
Received: from jurko.gospodnetic by 87.252.133.29 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 11:48:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.252.133.29
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90446>

This is a multi-part message in MIME format.
--------------030700040605070409050108
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 8bit

    Hi all.

    This is just a fix for something in the documentation that confused 
me when playing around with git.

--- Comment: --------
    Updated the Documentation/config.txt core.autocrlf configuration
setting documentation to note that this setting can be set at a
repository or file level by using the gitattributes configuration.

Signed-off-by: Jurko <jurko.gospodnetic@docte.hr>
---------------------

    Diff is attached as a separate file.

    Still have not figured out how to best send in patches (working on
Windows here) so this one is a manually sent mail and you will most
likely not be able to apply it automatically. :-(

    I am also not sure whether there are perhaps any other documentation
copies that need to be updated for this. This was the only one I found
in the source tree.

    Best regards,
      Jurko Gospodnetiæ


--------------030700040605070409050108
Content-Type: text/plain;
 name="config.txt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config.txt.patch"

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1a13abc..d9c1401 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -135,9 +135,10 @@ core.autocrlf::
 	writing to the filesystem.  The variable can be set to
 	'input', in which case the conversion happens only while
 	reading from the filesystem but files are written out with
-	`LF` at the end of lines.  Currently, which paths to consider
-	"text" (i.e. be subjected to the autocrlf mechanism) is
-	decided purely based on the contents.
+	`LF` at the end of lines.  Which paths to consider "text" (i.e. be subjected
+    to the autocrlf mechanism) will be decided based on the contents but this
+    can be overruled on a per-repository or per-file level by using
+    linkgit:gitattributes[5].
 
 core.safecrlf::
 	If true, makes git check if converting `CRLF` as controlled by

--------------030700040605070409050108--
