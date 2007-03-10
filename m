From: Raimund Bauer <ray007@gmx.net>
Subject: Re: Problems with autoCRLF?
Date: Sat, 10 Mar 2007 13:23:21 +0100
Message-ID: <1173529401.5975.10.camel@localhost>
References: <1173464102.6102.18.camel@localhost>
	 <7v8xe528mk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 13:23:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ0bj-0008Hr-N2
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 13:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbXCJMXZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 07:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933048AbXCJMXZ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 07:23:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:58814 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932943AbXCJMXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 07:23:24 -0500
Received: (qmail invoked by alias); 10 Mar 2007 12:23:23 -0000
Received: from p54988720.dip0.t-ipconnect.de (EHLO [192.168.178.22]) [84.152.135.32]
  by mail.gmx.net (mp001) with SMTP; 10 Mar 2007 13:23:23 +0100
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX18/o98KluQ/f/yF4czSUkXHi0n853Y4Ml92pQBJyG
	+xEg75YqJkrSE3
In-Reply-To: <7v8xe528mk.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41865>

On Fri, 2007-03-09 at 17:24 -0800, Junio C Hamano wrote:

> So on sane platforms, you do not want to set that variable,
> unless you are helping to test and improve that feature.

In that case we should document it as well. Having the information in
the Releasenotes is nice, but having it in the git-config manpage too
may be better, text taken straight from the Releasenotes for git 1.5.1.

---
 Documentation/config.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5408dd6..7864ea3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -137,6 +137,17 @@ Can be overridden by the 'GIT_PROXY_COMMAND' environment variable
 (which always applies universally, without the special "for"
 handling).
 
+core.autocrlf::
+    When set to 'true', makes git to convert CRLF at the end of lines
+    in text files to LF when reading from the filesystem, and convert
+    in reverse when writing to the filesystem.  The variable can be
+    set to 'input', in which case the conversion happens only while
+    reading from the filesystem but files are written out with LF at
+    the end of lines.  Currently, which paths to consider 'text'
+    (i.e. be subjected to the autocrlf mechanism) is decided purely
+    based on the contents, but the plan is to allow users to
+    explicitly override this heuristic based on paths.
+
 core.ignoreStat::
 	The working copy files are assumed to stay unchanged until you
 	mark them otherwise manually - Git will not detect the file changes
-- 
1.5.0.3.942.g299f

-- 
best regards

  Ray
